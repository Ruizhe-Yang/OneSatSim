#!/usr/bin/env python3
"""Validate DesignConfig.xlsx and update the single NISSA Modelica configuration chain."""

from __future__ import annotations

import argparse
import ast
import csv
import json
import math
import os
import re
import shutil
import subprocess
import sys
import tempfile
import traceback
from collections import defaultdict
from datetime import datetime, timezone
from pathlib import Path
from typing import Any

import numpy as np

try:
    from openpyxl import load_workbook
except ImportError as exc:
    print("[ERROR] 缺少 openpyxl / Python package 'openpyxl' is required.")
    raise SystemExit(2) from exc

from parameter_schema import (
    ValidationCollector,
    iter_table,
    validate_component_rows,
    validate_workbook_shape,
)
from parameter_units import (
    UnitConversionError,
    modelica_literal,
    parse_boolean,
    parse_number,
    to_si,
    values_equal,
)
from prepare_ephemeris import (
    EphemerisPreparationError,
    ResourceSettings,
    add_physical_seconds,
    configure_astropy,
    duration_seconds,
    keplerian_to_state,
    parse_absolute_time,
    prepare_environment,
    state_to_keplerian,
    time_iso_utc,
)


PACKAGE_ROOT = Path(__file__).resolve().parents[1]
SCENARIOS = PACKAGE_ROOT / "Scenarios"
OUTPUT_DIR = PACKAGE_ROOT / "outputs" / "config" / "latest"
DEFAULT_DESIGN = SCENARIOS / "DefaultSpacecraftDesignConfig.mo"
GENERATED_DESIGN = SCENARIOS / "GeneratedSpacecraftDesignConfig.mo"
DEFAULT_SCENARIO = SCENARIOS / "DefaultScenario.mo"
GENERATED_SCENARIO = SCENARIOS / "GeneratedScenario.mo"
COMPLETE_MISSION = PACKAGE_ROOT / "Simulation" / "CompleteMission.mo"
GENERATED_ENVIRONMENT = PACKAGE_ROOT / "Resources" / "Data" / "GeneratedEphemeris"


def balanced(text: str, open_index: int, left: str = "(", right: str = ")") -> tuple[str, int]:
    depth = 0
    in_string = False
    escaped = False
    for index in range(open_index, len(text)):
        char = text[index]
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            continue
        if char == '"':
            in_string = True
        elif char == left:
            depth += 1
        elif char == right:
            depth -= 1
            if depth == 0:
                return text[open_index + 1:index], index + 1
    raise ValueError("unbalanced Modelica delimiter")


def split_top_level(text: str) -> list[str]:
    parts = []
    start = 0
    depth = 0
    in_string = False
    escaped = False
    for index, char in enumerate(text):
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
            continue
        if char == '"':
            in_string = True
        elif char in "({[":
            depth += 1
        elif char in ")} ]".replace(" ", ""):
            depth -= 1
        elif char == "," and depth == 0:
            parts.append(text[start:index].strip())
            start = index + 1
    parts.append(text[start:].strip())
    return [part for part in parts if part]


def parse_scalar(expression: str) -> Any:
    expression = expression.strip()
    if expression.startswith("{") and expression.endswith("}"):
        return [parse_scalar(part) for part in split_top_level(expression[1:-1])]
    if expression == "true":
        return True
    if expression == "false":
        return False
    if expression.startswith('"') and expression.endswith('"'):
        return ast.literal_eval(expression)
    safe = expression.replace("Modelica.Constants.pi", repr(math.pi))
    tree = ast.parse(safe, mode="eval")

    def visit(node: ast.AST) -> float:
        if isinstance(node, ast.Expression):
            return visit(node.body)
        if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
            return float(node.value)
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.UAdd, ast.USub)):
            value = visit(node.operand)
            return value if isinstance(node.op, ast.UAdd) else -value
        if isinstance(node, ast.BinOp) and isinstance(node.op, (ast.Add, ast.Sub, ast.Mult, ast.Div, ast.Pow)):
            left, right = visit(node.left), visit(node.right)
            return {
                ast.Add: left + right,
                ast.Sub: left - right,
                ast.Mult: left * right,
                ast.Div: left / right,
                ast.Pow: left**right,
            }[type(node.op)]
        raise ValueError(f"unsupported Modelica scalar {expression!r}")

    return visit(tree)


def parse_assignments(content: str) -> dict[str, Any]:
    result = {}
    for part in split_top_level(content):
        if "=" not in part:
            continue
        name, expression = part.split("=", 1)
        result[name.strip()] = parse_scalar(expression)
    return result


def extract_call(text: str, marker: str) -> dict[str, Any]:
    match = re.search(re.escape(marker) + r"\s*\(", text)
    if not match:
        raise ValueError(f"Modelica default marker not found: {marker}")
    content, _ = balanced(text, match.end() - 1)
    return parse_assignments(content)


def parse_default_design(rows: list[dict[str, Any]]) -> dict[str, Any]:
    text = DEFAULT_DESIGN.read_text(encoding="utf-8")
    cache: dict[str, dict[str, Any]] = {}
    defaults = {}
    for row in rows:
        key = str(row["PlannedConfigKey"])
        _, _, instance, field = key.split(".")
        if instance not in cache:
            pattern = re.compile(r"\b" + re.escape(instance) + r"=DesignConfigRecords\.\w+ComponentConfig\(")
            match = pattern.search(text)
            if not match:
                raise ValueError(f"DefaultSpacecraftDesignConfig has no instance {instance!r}")
            content, _ = balanced(text, match.end() - 1)
            cache[instance] = parse_assignments(content)
        if field not in cache[instance]:
            raise ValueError(f"DefaultSpacecraftDesignConfig has no field {key}")
        defaults[key] = cache[instance][field]
    return defaults


def write_if_changed(path: Path, content: str) -> bool:
    previous = path.read_text(encoding="utf-8") if path.exists() else None
    if previous == content:
        return False
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")
    return True


def generated_design_text(rows: list[dict[str, Any]], overrides: list[dict[str, Any]]) -> str:
    """Build every record field explicitly while keeping Default as numeric source.

    OpenModelica does not reliably apply a deep modifier such as
    ``eps(battery(CellCapacity_Ah=...))`` when ``eps`` already has a record
    binding in the inherited default record.  The generated record therefore
    reconstructs the hierarchy: overridden fields contain the Excel value and
    every other field references ``base``.  No inherited numeric default is
    copied into Python or into the generated record.
    """
    grouped: dict[str, dict[str, list[dict[str, Any]]]] = defaultdict(lambda: defaultdict(list))
    override_keys = {str(row["PlannedConfigKey"]) for row in overrides}
    for row in rows:
        _, subsystem, instance, _ = str(row["PlannedConfigKey"]).split(".")
        grouped[subsystem][instance].append(row)
    subsystem_bindings = []
    for subsystem, instances in sorted(grouped.items()):
        instance_bindings = []
        for instance, instance_rows in sorted(instances.items()):
            record_name = instance[:1].upper() + instance[1:] + "ComponentConfig"
            assignments = []
            for row in instance_rows:
                key = str(row["PlannedConfigKey"])
                field = key.split(".")[-1]
                value = modelica_literal(row["ResolvedSIValue"]) if key in override_keys else f"defaultSpacecraftDesignConfig.{subsystem}.{instance}.{field}"
                assignments.append(f"{field}={value}")
            instance_bindings.append(
                f"{instance}=DesignConfigRecords.{record_name}(" + ",".join(assignments) + ")"
            )
        subsystem_record = subsystem[:1].upper() + subsystem[1:] + "DesignConfig"
        subsystem_bindings.append(
            f"{subsystem}=DesignConfigRecords.{subsystem_record}(\n      " + ",\n      ".join(instance_bindings) + ")"
        )
    extends_clause = "  extends SpacecraftDesignConfig(\n    " + ",\n    ".join(subsystem_bindings) + ");"
    return f'''within NISSA_12UCubeSat.Scenarios;
record GeneratedSpacecraftDesignConfig "由根目录DesignConfig.xlsx生成的整星设计配置"
{extends_clause}
  annotation(Documentation(info="<html><h4>生成规则</h4><p>UseDefault=FALSE字段保存经SI转换的Excel覆盖；其余字段均引用包常量defaultSpacecraftDesignConfig中的DefaultSpacecraftDesignConfig，不复制数值默认值。</p></html>"));
end GeneratedSpacecraftDesignConfig;
'''


def parse_meta(wb: Any, collector: ValidationCollector) -> dict[str, Any]:
    values = {str(row.get("Parameter") or "").strip(): row.get("Value") for _, row in iter_table(wb["Meta"], collector)}
    scenario_name = str(values.get("ScenarioName") or "").strip()
    if not scenario_name or not re.fullmatch(r"[A-Za-z0-9_]+", scenario_name):
        collector.error("Meta", None, "ScenarioName must contain only letters, numbers, and underscore")
    policy = str(values.get("MissingValuePolicy") or "DEFAULT").strip().upper()
    if policy not in {"DEFAULT", "ERROR"}:
        collector.error("Meta", None, "MissingValuePolicy must be DEFAULT or ERROR")
    try:
        strict = parse_boolean(values.get("StrictValidation", False))
    except UnitConversionError as exc:
        collector.error("Meta", None, str(exc))
        strict = False
    return {"scenarioName": scenario_name, "missingValuePolicy": policy, "strictValidation": strict}


def parse_orbit(
    wb: Any,
    collector: ValidationCollector,
    default_text: str,
    start_time: Any,
    time_zone: str,
) -> tuple[dict[str, Any], list[dict[str, Any]]]:
    """Resolve the retained Keplerian fields and one complete active state source."""
    defaults = extract_call(default_text, "orbit=OrbitConfig")
    legacy_fields = {
        "SemiMajorAxis": "semiMajorAxis",
        "Eccentricity": "eccentricity",
        "Inclination": "inclination",
        "InitialRAAN": "initialRAAN",
        "InitialMeanAnomaly": "initialMeanAnomaly",
        "ArgumentOfPerigee": "argumentOfPerigee",
        "InitialEpoch": "initialEpoch",
    }
    required_new = {"StateInputMode", "StateFrame", "StateEpochDateTime", "X0", "Y0", "Z0", "VX0", "VY0", "VZ0"}
    legacy: dict[str, float] = {}
    new_values: dict[str, Any] = {}
    snapshot = []
    found: set[str] = set()
    for row_number, row in iter_table(wb["Orbit"], collector):
        parameter = str(row.get("Parameter") or "").strip()
        found.add(parameter)
        unit = str(row.get("Unit") or "").strip()
        try:
            use_default = parse_boolean(row.get("UseDefault"))
            selected = row.get("DefaultValue") if use_default else row.get("Value")
            if parameter in legacy_fields:
                field = legacy_fields[parameter]
                excel_default_si = to_si(row.get("DefaultValue"), unit)
                resolved = defaults[field] if use_default else to_si(selected, unit)
                legacy[field] = float(resolved)
                if not values_equal(excel_default_si, defaults[field]):
                    collector.warning(f"Orbit row {row_number} DefaultValue differs from DefaultScenario.{field}")
                changed = not values_equal(resolved, defaults[field])
            elif parameter in {"StateInputMode", "StateFrame"}:
                resolved = str(selected or "").strip()
                new_values[parameter] = resolved
                changed = resolved != str(row.get("DefaultValue") or "").strip()
            elif parameter == "StateEpochDateTime":
                resolved = selected
                new_values[parameter] = resolved
                changed = resolved not in (None, "")
            elif parameter in {"X0", "Y0", "Z0", "VX0", "VY0", "VZ0"}:
                resolved = to_si(selected, unit)
                new_values[parameter] = float(resolved)
                changed = not values_equal(resolved, to_si(row.get("DefaultValue"), unit))
            else:
                collector.error("Orbit", row_number, f"unknown orbit parameter {parameter!r}", parameter=parameter)
                continue
        except (UnitConversionError, KeyError, ValueError) as exc:
            collector.error("Orbit", row_number, str(exc), parameter=parameter)
            continue
        snapshot.append({
            "Kind": "Orbit", "Subsystem": "Mission", "Instance": "orbit", "Parameter": parameter,
            "ExcelValue": row.get("Value"), "Unit": unit, "UseDefault": use_default,
            "ResolvedValue": resolved, "ResolvedSIValue": resolved,
            "ConfigKey": row.get("ModelicaTarget"), "ModelicaTarget": row.get("ModelicaTarget"),
            "ChangedFromDefault": changed,
        })
    missing = required_new - found
    if missing:
        collector.error("Orbit", None, "missing new orbit fields: " + ", ".join(sorted(missing)))
    if legacy.get("semiMajorAxis", 0) <= 6378137:
        collector.error("Orbit", None, "semi-major axis must exceed Earth radius", parameter="SemiMajorAxis")
    if not 0 <= legacy.get("eccentricity", -1) < 1:
        collector.error("Orbit", None, "eccentricity must satisfy 0 <= e < 1", parameter="Eccentricity")
    mode = str(new_values.get("StateInputMode") or "")
    frame = str(new_values.get("StateFrame") or "")
    if mode not in {"Cartesian", "Keplerian"}:
        collector.error("Orbit", None, "StateInputMode must be Cartesian or Keplerian", parameter="StateInputMode")
    if frame != "GCRS":
        collector.error("Orbit", None, "StateFrame must be GCRS; unsupported frames are rejected", parameter="StateFrame")
    epoch_input = new_values.get("StateEpochDateTime")
    try:
        state_epoch = start_time if epoch_input in (None, "") else parse_absolute_time(epoch_input, time_zone, "Orbit.StateEpochDateTime")
    except EphemerisPreparationError as exc:
        collector.error("Orbit", None, str(exc), parameter="StateEpochDateTime")
        state_epoch = start_time
    try:
        if mode == "Cartesian":
            initial_state = [new_values[key] for key in ("X0", "Y0", "Z0", "VX0", "VY0", "VZ0")]
            state_to_keplerian(np.asarray(initial_state, dtype=float))
        else:
            initial_state = keplerian_to_state(legacy).tolist()
    except (KeyError, EphemerisPreparationError) as exc:
        collector.error("Orbit", None, str(exc), parameter="StateInputMode")
        initial_state = [0.0] * 6
    if abs(legacy.get("initialEpoch", 0.0)) > 1e-12:
        collector.warning("Orbit.InitialEpoch is retained only as a legacy display field and is not added to StateEpochDateTime")
    return {
        "legacy": legacy,
        "state_input_mode": mode,
        "state_frame": frame,
        "state_epoch": state_epoch,
        "initial_state": initial_state,
    }, snapshot


def parse_initial(wb: Any, collector: ValidationCollector, default_text: str) -> tuple[list[str], list[str], list[dict[str, Any]]]:
    defaults = extract_call(default_text, "initialConditions=InitialConditionConfig")
    operational_match = re.search(r"operationalSnapshotStart\s*=\s*(true|false)", default_text)
    if not operational_match:
        raise ValueError("DefaultScenario operationalSnapshotStart not found")
    operational_default = operational_match.group(1) == "true"
    top_overrides: list[str] = []
    initial_overrides: list[str] = []
    snapshot = []
    wheel_values = dict(enumerate(defaults.get("wheelSpeed", []), start=1)) if isinstance(defaults.get("wheelSpeed"), list) else {}
    for row_number, row in iter_table(wb["InitialConditions"], collector):
        parameter = str(row.get("Parameter") or "").strip()
        target = str(row.get("ModelicaTarget") or "")
        field = target.split(".")[-1]
        vector_match = re.fullmatch(r"wheelSpeed\[(\d+)\]", field)
        try:
            use_default = parse_boolean(row.get("UseDefault"))
            input_value = row.get("DefaultValue") if use_default else row.get("Value")
            resolved = to_si(input_value, str(row.get("Unit") or ""))
        except UnitConversionError as exc:
            collector.error("InitialConditions", row_number, str(exc), subsystem=str(row.get("Subsystem") or ""), parameter=parameter)
            continue
        if field == "operationalSnapshotStart":
            model_default = operational_default
            if not use_default:
                top_overrides.append(f"operationalSnapshotStart={modelica_literal(resolved)}")
        elif vector_match:
            index = int(vector_match.group(1))
            model_default = wheel_values.get(index, resolved)
            if not use_default:
                initial_overrides.append(f"{field}={modelica_literal(resolved)}")
        else:
            if field not in defaults:
                collector.error("InitialConditions", row_number, f"unknown Modelica target field {field}", parameter=parameter)
                continue
            model_default = defaults[field]
            if not use_default:
                initial_overrides.append(f"{field}={modelica_literal(resolved)}")
        default_si = to_si(row.get("DefaultValue"), str(row.get("Unit") or ""))
        if not values_equal(default_si, model_default):
            collector.warning(f"InitialConditions row {row_number} DefaultValue differs from DefaultScenario.{field}")
        snapshot.append({
            "Kind": "InitialConditions", "Subsystem": str(row.get("Subsystem") or ""), "Instance": "initialConditions",
            "Parameter": parameter, "ExcelValue": row.get("Value"), "Unit": row.get("Unit"), "UseDefault": use_default,
            "ResolvedValue": resolved, "ResolvedSIValue": resolved, "ConfigKey": target, "ModelicaTarget": target,
            "ChangedFromDefault": not values_equal(resolved, model_default),
        })
    return top_overrides, initial_overrides, snapshot


def parse_sites(wb: Any, sheet: str, count: int, record_name: str, collector: ValidationCollector) -> tuple[str, list[dict[str, Any]]]:
    rows = iter_table(wb[sheet], collector)
    if len(rows) != count:
        collector.error(sheet, None, f"expected exactly {count} fixed slots, got {len(rows)}")
    records = []
    snapshot = []
    seen_slots = set()
    seen_ids = set()
    for row_number, row in rows:
        try:
            slot = int(parse_number(row.get("Slot")))
            enabled = parse_boolean(row.get("Enabled"))
            identifier = int(parse_number(row.get("ID"))) if row.get("ID") not in (None, "") else 0
            name = str(row.get("Name") or "")
            latitude = to_si(row.get("Latitude_deg") if row.get("Latitude_deg") not in (None, "") else 0, "deg")
            longitude = to_si(row.get("Longitude_deg") if row.get("Longitude_deg") not in (None, "") else 0, "deg")
            altitude = to_si(row.get("Altitude_m") if row.get("Altitude_m") not in (None, "") else 0, "m")
            elevation = to_si(row.get("MinElevation_deg") if row.get("MinElevation_deg") not in (None, "") else 0, "deg")
            priority = int(parse_number(row.get("Priority"))) if row.get("Priority") not in (None, "") else 0
        except UnitConversionError as exc:
            collector.error(sheet, row_number, str(exc))
            continue
        if slot in seen_slots or slot < 1 or slot > count:
            collector.error(sheet, row_number, f"invalid or duplicate Slot {slot}")
        seen_slots.add(slot)
        if enabled and (identifier <= 0 or not name):
            collector.error(sheet, row_number, "enabled slot requires positive ID and non-empty Name")
        if enabled and identifier in seen_ids:
            collector.error(sheet, row_number, f"duplicate enabled ID {identifier}")
        if enabled:
            seen_ids.add(identifier)
        if not -math.pi / 2 <= latitude <= math.pi / 2:
            collector.error(sheet, row_number, "latitude must be within [-90, 90] deg")
        if not -math.pi <= longitude <= math.pi:
            collector.error(sheet, row_number, "longitude must be within [-180, 180] deg")
        if elevation < 0 or elevation >= math.pi / 2:
            collector.error(sheet, row_number, "minimum elevation must be within [0, 90) deg")
        records.append(
            f"{record_name}(enabled={modelica_literal(enabled)},id={identifier},name={modelica_literal(name)},"
            f"latitude={modelica_literal(latitude)},longitude={modelica_literal(longitude)},"
            f"altitude={modelica_literal(altitude)},minimumElevation={modelica_literal(elevation)},priority={priority})"
        )
        snapshot.append({
            "Kind": sheet, "Subsystem": "Mission", "Instance": f"slot{slot}", "Parameter": name or f"Slot{slot}",
            "ExcelValue": {key: row.get(key) for key in row}, "Unit": "mixed", "UseDefault": False,
            "ResolvedValue": {"enabled": enabled, "id": identifier, "name": name, "latitude": latitude, "longitude": longitude, "altitude": altitude, "minimumElevation": elevation, "priority": priority},
            "ResolvedSIValue": "record", "ConfigKey": row.get("ModelicaTarget"), "ModelicaTarget": row.get("ModelicaTarget"),
            "ChangedFromDefault": True,
        })
    return "{" + ",".join(records) + "}", snapshot


def orbit_record_literal(orbit: dict[str, Any], metadata: dict[str, Any]) -> str:
    legacy = orbit["legacy"]
    input_state = orbit["initial_state"]
    start_state = metadata["stateAtSimulationStart"]
    derived = metadata["derivedElementsAtSimulationStart"]
    fields = [
        f"semiMajorAxis={modelica_literal(legacy['semiMajorAxis'])}",
        f"eccentricity={modelica_literal(legacy['eccentricity'])}",
        f"inclination={modelica_literal(legacy['inclination'])}",
        f"initialRAAN={modelica_literal(legacy['initialRAAN'])}",
        f"initialMeanAnomaly={modelica_literal(legacy['initialMeanAnomaly'])}",
        f"argumentOfPerigee={modelica_literal(legacy['argumentOfPerigee'])}",
        f"initialEpoch={modelica_literal(legacy['initialEpoch'])}",
        f"stateInputMode={modelica_literal(orbit['state_input_mode'])}",
        f"stateFrame={modelica_literal(orbit['state_frame'])}",
        f"simulationStartUTC={modelica_literal(metadata['startUTC'])}",
        f"stateEpochUTC={modelica_literal(metadata['stateEpochUTC'])}",
        "inputPosition={" + ",".join(modelica_literal(value) for value in input_state[:3]) + "}",
        "inputVelocity={" + ",".join(modelica_literal(value) for value in input_state[3:]) + "}",
        "propagatedPositionAtStart={" + ",".join(modelica_literal(value) for value in start_state[:3]) + "}",
        "propagatedVelocityAtStart={" + ",".join(modelica_literal(value) for value in start_state[3:]) + "}",
        f"referenceSemiMajorAxis={modelica_literal(derived['semiMajorAxis'])}",
        f"simulationDuration={modelica_literal(metadata['durationSeconds'])}",
        f"environmentSampleInterval={modelica_literal(metadata['finalSampleInterval'])}",
        f"environmentTableRows={int(metadata['tableRows'])}",
        'environmentDataURI="modelica://NISSA_12UCubeSat/Resources/Data/GeneratedEphemeris/environment.txt"',
        'environmentTableName="environment"',
    ]
    return "OrbitConfig(" + ",".join(fields) + ")"


def generated_scenario_text(orbit_literal: str, top: list[str], initial: list[str], ground: str, targets: str) -> str:
    modifiers = list(top)
    modifiers.append("orbit=" + orbit_literal)
    if initial:
        modifiers.append("initialConditions(" + ",".join(initial) + ")")
    modifiers.append("groundStations=" + ground)
    modifiers.append("imagingTargets=" + targets)
    return '''within NISSA_12UCubeSat.Scenarios;
record GeneratedScenario "由根目录DesignConfig.xlsx生成的任务场景"
  extends DefaultScenario(
    %s);
  annotation(Documentation(info="<html><p>场景、初值与站点/目标数据库由tools/update_nissa_config.py离线生成；硬件设计参数由GeneratedSpacecraftDesignConfig提供。</p></html>"));
end GeneratedScenario;
''' % ",\n    ".join(modifiers)


def _resolve_resource_path(value: Any, field: str) -> Path:
    token = str(value or "").strip()
    if not token:
        raise EphemerisPreparationError(f"Ephemeris.{field} is blank")
    path = Path(token)
    if not path.is_absolute():
        path = PACKAGE_ROOT / path
    return path.resolve()


def parse_ephemeris(wb: Any, collector: ValidationCollector) -> tuple[ResourceSettings, list[dict[str, Any]]]:
    rows = iter_table(wb["Ephemeris"], collector)
    raw = {str(row.get("Parameter") or "").strip(): (row_number, row) for row_number, row in rows}
    required = {
        "SPKFile", "IERSFile", "LeapSecondsFile", "AllowPredictedEOP", "EnvironmentSampleInterval",
        "PropagationModel", "PropagationRtol", "PropagationAtolPosition", "PropagationAtolVelocity",
    }
    if missing := required - raw.keys():
        collector.error("Ephemeris", None, "missing parameters: " + ", ".join(sorted(missing)))
    def value(name: str) -> Any:
        return raw.get(name, (None, {}))[1].get("Value")
    try:
        settings = ResourceSettings(
            spk_path=_resolve_resource_path(value("SPKFile"), "SPKFile"),
            iers_path=_resolve_resource_path(value("IERSFile"), "IERSFile"),
            leap_seconds_path=_resolve_resource_path(value("LeapSecondsFile"), "LeapSecondsFile"),
            allow_predicted_eop=parse_boolean(value("AllowPredictedEOP")),
            sample_interval=float(to_si(value("EnvironmentSampleInterval"), str(raw["EnvironmentSampleInterval"][1].get("Unit") or "s"))),
            propagation_model=str(value("PropagationModel") or "").strip(),
            propagation_rtol=parse_number(value("PropagationRtol")),
            propagation_atol_position=float(to_si(value("PropagationAtolPosition"), str(raw["PropagationAtolPosition"][1].get("Unit") or "m"))),
            propagation_atol_velocity=float(to_si(value("PropagationAtolVelocity"), str(raw["PropagationAtolVelocity"][1].get("Unit") or "m/s"))),
        )
        if settings.sample_interval <= 0 or settings.propagation_rtol <= 0 or settings.propagation_atol_position <= 0 or settings.propagation_atol_velocity <= 0:
            raise EphemerisPreparationError("sampling interval and propagation tolerances must be positive")
        configure_astropy(settings.leap_seconds_path)
    except (EphemerisPreparationError, UnitConversionError, KeyError) as exc:
        collector.error("Ephemeris", None, str(exc))
        settings = ResourceSettings(Path(), Path(), Path(), False, 10.0, "", 1e-10, 1e-4, 1e-7)
    snapshot = []
    for row_number, row in rows:
        name = str(row.get("Parameter") or "").strip()
        snapshot.append({
            "Kind": "Ephemeris", "Subsystem": "Environment", "Instance": "resources", "Parameter": name,
            "ExcelValue": row.get("Value"), "Unit": row.get("Unit"), "UseDefault": False,
            "ResolvedValue": str(row.get("Value") or ""), "ResolvedSIValue": str(row.get("Value") or ""),
            "ConfigKey": f"Ephemeris.{name}", "ModelicaTarget": "offline environment generator",
            "ChangedFromDefault": not values_equal(row.get("Value"), row.get("DefaultValue")),
        })
    return settings, snapshot


def parse_simulation(wb: Any, collector: ValidationCollector) -> tuple[dict[str, Any], list[dict[str, Any]]]:
    rows = iter_table(wb["Simulation"], collector)
    values = {}
    units = {}
    snapshot = []
    numeric = {"StartTime", "StopTime", "OutputInterval", "Tolerance", "MaxSizeLinearTearing", "Duration"}
    for row_number, row in rows:
        parameter = str(row.get("Parameter") or "").strip()
        value = row.get("Value")
        units[parameter] = str(row.get("Unit") or "").strip()
        if parameter in numeric:
            try:
                value = parse_number(value)
            except UnitConversionError as exc:
                collector.error("Simulation", row_number, str(exc), parameter=parameter)
                continue
        elif parameter != "StartDateTime":
            value = str(value or "").strip()
        values[parameter] = value
        try:
            changed_from_default = not values_equal(value, row.get("DefaultValue"))
        except (TypeError, ValueError):
            changed_from_default = str(value) != str(row.get("DefaultValue"))
        snapshot.append({
            "Kind": "Simulation", "Subsystem": "Simulation", "Instance": "CompleteMission", "Parameter": parameter,
            "ExcelValue": row.get("Value"), "Unit": row.get("Unit"), "UseDefault": False,
            "ResolvedValue": value, "ResolvedSIValue": value, "ConfigKey": row.get("ToolTarget"),
            "ModelicaTarget": row.get("ToolTarget"), "ChangedFromDefault": changed_from_default,
        })
    required = {"StartTime", "StopTime", "OutputInterval", "Tolerance", "Solver", "IDALinearSolver", "Jacobian", "MaxSizeLinearTearing", "StartDateTime", "TimeZone", "Duration"}
    missing = required - values.keys()
    if missing:
        collector.error("Simulation", None, "missing parameters: " + ", ".join(sorted(missing)))
    try:
        start_time = parse_absolute_time(values.get("StartDateTime"), str(values.get("TimeZone") or ""), "Simulation.StartDateTime")
        duration = duration_seconds(values.get("Duration"), units.get("Duration", ""))
        if abs(duration - round(duration)) > 1e-9:
            raise EphemerisPreparationError("Duration must resolve to an integer number of SI seconds")
        values["StartTime"] = 0.0
        values["StopTime"] = float(duration)
        values["DurationSeconds"] = float(duration)
        values["StartTimeUTC"] = start_time
        values["EndTimeUTC"] = add_physical_seconds(start_time, duration)
    except EphemerisPreparationError as exc:
        collector.error("Simulation", None, str(exc))
        values["StartTime"] = 0.0
        values["StopTime"] = 0.0
        values["DurationSeconds"] = 0.0
        values["StartTimeUTC"] = None
        values["EndTimeUTC"] = None
    if values.get("OutputInterval", 0) <= 0 or values.get("Tolerance", 0) <= 0:
        collector.error("Simulation", None, "OutputInterval and Tolerance must be positive")
    if values.get("OutputInterval", 0) > 0 and abs(values["OutputInterval"] - round(values["OutputInterval"])) > 1e-9:
        collector.error("Simulation", None, "OutputInterval must be an integer number of seconds")
    if str(values.get("Solver", "")).lower() not in {"ida", "dassl", "cvode"}:
        collector.error("Simulation", None, "Solver must be ida, dassl, or cvode")
    for item in snapshot:
        if item["Parameter"] == "StartTime":
            item["ResolvedValue"] = item["ResolvedSIValue"] = 0.0
        elif item["Parameter"] == "StopTime":
            item["ResolvedValue"] = item["ResolvedSIValue"] = values["StopTime"]
        elif item["Parameter"] == "StartDateTime" and values["StartTimeUTC"] is not None:
            item["ResolvedValue"] = item["ResolvedSIValue"] = time_iso_utc(values["StartTimeUTC"])
    return values, snapshot


def update_complete_mission(settings: dict[str, Any]) -> bool:
    text = COMPLETE_MISSION.read_text(encoding="utf-8")
    experiment = (
        f"experiment(StartTime={modelica_literal(settings['StartTime'])},"
        f"StopTime={modelica_literal(settings['StopTime'])},"
        f"Interval={modelica_literal(settings['OutputInterval'])},"
        f"Tolerance={modelica_literal(settings['Tolerance'])})"
    )
    updated, count = re.subn(r"experiment\([^)]*\)", experiment, text, count=1)
    if count != 1:
        raise ValueError("CompleteMission experiment annotation not found")
    updated, count = re.subn(
        r'__OpenModelica_commandLineOptions="[^"]*"',
        f'__OpenModelica_commandLineOptions="--maxSizeLinearTearing={int(settings["MaxSizeLinearTearing"])}"',
        updated,
        count=1,
    )
    if count != 1:
        raise ValueError("CompleteMission OpenModelica command options not found")
    flags = (
        f'__OpenModelica_simulationFlags(s="{str(settings["Solver"]).lower()}",'
        f'idaLS="{settings["IDALinearSolver"]}",jacobian="{settings["Jacobian"]}")'
    )
    updated, count = re.subn(r"__OpenModelica_simulationFlags\([^)]*\)", flags, updated, count=1)
    if count != 1:
        raise ValueError("CompleteMission OpenModelica simulation flags not found")
    return write_if_changed(COMPLETE_MISSION, updated)


def lower_alias(parameter: str) -> str:
    converted = re.sub(r"^([A-Z]+)(?=[A-Z][a-z]|_)", lambda m: m.group(1).lower(), parameter)
    return converted[:1].lower() + converted[1:]


def source_path(row: dict[str, Any]) -> Path:
    model = str(row["ComponentModel"])
    if model.startswith("Components."):
        return PACKAGE_ROOT / "Components" / f"{model.split('.')[-1]}.mo"
    return PACKAGE_ROOT / "Systems" / "Four_systems" / "ThermalOverall.mo"


def mapping_audit(rows: list[dict[str, Any]], defaults: dict[str, Any], collector: ValidationCollector) -> list[dict[str, Any]]:
    audit = []
    for row in rows:
        key = str(row["PlannedConfigKey"])
        _, _, instance, field = key.split(".")
        record_path = SCENARIOS / "DesignConfigRecords" / f"{instance[:1].upper() + instance[1:]}ComponentConfig.mo"
        record_text = record_path.read_text(encoding="utf-8") if record_path.exists() else ""
        source = source_path(row)
        source_text = source.read_text(encoding="utf-8") if source.exists() else ""
        config_record = bool(re.search(r"\bparameter\s+[^;\n]+\b" + re.escape(field) + r"(?:\(|\s|$)", record_text))
        component_parameter = f"config.{field}" in source_text
        status_text = str(row.get("CurrentStatus") or "")
        alias = "cellCapacity" if row.get("Parameter") == "CellCapacity_Ah" else lower_alias(str(row.get("Parameter") or ""))
        if str(row.get("CurrentModelTarget")) == "Foundation.Types.MassProperties.primaryStructureMass":
            actual_connected = source_text.count("primaryStructureMass") >= 2 and component_parameter
        elif status_text.startswith("H-"):
            actual_connected = source_text.count(alias) >= 2 and component_parameter
        else:
            target_tail = str(row.get("CurrentModelTarget") or "").split(".")[-1].split("[")[0]
            actual_connected = component_parameter and target_tail in source_text
        try:
            excel_default = to_si(row.get("DefaultValue"), str(row.get("Unit") or ""))
            default_matched = values_equal(excel_default, defaults[key])
        except Exception:
            default_matched = False
        passed = config_record and component_parameter and actual_connected and default_matched
        item = {
            "Subsystem": row.get("Subsystem"),
            "Instance": row.get("Instance"),
            "Parameter": row.get("Parameter"),
            "CurrentModelTarget": row.get("CurrentModelTarget"),
            "PlannedConfigKey": key,
            "ConfigRecordCreated": config_record,
            "ComponentParameterCreated": component_parameter,
            "ActualTargetConnected": actual_connected,
            "DefaultMatched": default_matched,
            "UnitConversion": f"{row.get('Unit')} -> SI" if str(row.get("Unit")) not in {"1", "Boolean", "byte", "byte/s"} else "identity",
            "Status": "PASS" if passed else "FAIL",
        }
        audit.append(item)
        if not passed:
            collector.error("Components", int(row["ExcelRow"]), "parameter mapping audit failed", subsystem=str(row.get("Subsystem") or ""), instance=str(row.get("Instance") or ""), parameter=str(row.get("Parameter") or ""))
    return audit


def write_csv(path: Path, rows: list[dict[str, Any]]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    if not rows:
        path.write_text("", encoding="utf-8-sig")
        return
    with path.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)


def copy_if_changed(source: Path, destination: Path) -> bool:
    content = source.read_bytes()
    if destination.exists() and destination.read_bytes() == content:
        return False
    destination.parent.mkdir(parents=True, exist_ok=True)
    temporary = destination.with_suffix(destination.suffix + ".tmp")
    temporary.write_bytes(content)
    os.replace(temporary, destination)
    return True


def update_orbit_resolved_workbook(source: Path, metadata: dict[str, Any], destination: Path) -> None:
    workbook = load_workbook(source, data_only=False, read_only=False)
    resolved = workbook["OrbitResolved"]
    row_map = {
        str(resolved.cell(row, 1).value or "").strip(): row
        for row in range(1, resolved.max_row + 1)
    }
    state = metadata["stateAtSimulationStart"]
    elements = metadata["derivedElementsAtSimulationStart"]
    values = {
        "StartUTC": metadata["startUTC"],
        "EndUTC": metadata["endUTC"],
        "DurationSeconds": metadata["durationSeconds"],
        "StateEpochUTC": metadata["stateEpochUTC"],
        "StateInputMode": metadata["stateInputMode"],
        "InputFrame": metadata["inputFrame"],
        "InternalFrame": metadata["internalFrame"],
        "R0_X": state[0], "R0_Y": state[1], "R0_Z": state[2],
        "V0_X": state[3], "V0_Y": state[4], "V0_Z": state[5],
        "DerivedSemiMajorAxis": elements["semiMajorAxis"],
        "DerivedEccentricity": elements["eccentricity"],
        "DerivedInclination": elements["inclination"],
        "EphemerisCoverage": f"{metadata['spkCoverageTDB_JD'][0]:.1f} .. {metadata['spkCoverageTDB_JD'][1]:.1f}",
        "IERSCoverage": f"{metadata['iers']['coverageMJD'][0]:.1f} .. {metadata['iers']['coverageMJD'][1]:.1f}",
        "EOPStatus": metadata["iers"]["label"],
        "SPK_SHA256": metadata["resources"]["spkSHA256"],
        "IERS_SHA256": metadata["resources"]["iersSHA256"],
        "LeapSeconds_SHA256": metadata["resources"]["leapSecondsSHA256"],
        "EnvironmentTable_SHA256": metadata["tableSHA256"],
        "FinalSampleInterval": metadata["finalSampleInterval"],
        "PropagationConvergence": metadata["propagationConvergenceMaxPosition_m"],
        "TablePositionError": metadata["interpolationValidation"]["maxPositionError_m"],
        "TableVelocityError": metadata["interpolationValidation"]["maxVelocityError_m_s"],
        "EarthOrientationError": metadata["interpolationValidation"]["maxEarthRotationAngleError_arcsec"],
    }
    for name, value in values.items():
        if name in row_map:
            resolved.cell(row_map[name], 2).value = value
    simulation = workbook["Simulation"]
    for row in range(1, simulation.max_row + 1):
        if simulation.cell(row, 1).value == "StartTime":
            simulation.cell(row, 2).value = 0.0
        elif simulation.cell(row, 1).value == "StopTime":
            simulation.cell(row, 2).value = float(metadata["durationSeconds"])
    workbook.save(destination)


def serialize_snapshot_value(value: Any) -> Any:
    if isinstance(value, dict):
        return {str(k): serialize_snapshot_value(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [serialize_snapshot_value(v) for v in value]
    if isinstance(value, datetime):
        return value.isoformat()
    if hasattr(value, "isot"):
        return time_iso_utc(value)
    return value


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--excel", default="DesignConfig.xlsx", help="path relative to project root or absolute")
    parser.add_argument("--skip-mass-properties", action="store_true", help="diagnostic use only")
    args = parser.parse_args()
    excel_path = Path(args.excel)
    if not excel_path.is_absolute():
        excel_path = PACKAGE_ROOT / excel_path
    collector = ValidationCollector()
    if not excel_path.is_file():
        raise FileNotFoundError(f"Design workbook not found: {excel_path}")
    wb = load_workbook(excel_path, data_only=True, read_only=False)
    validate_workbook_shape(wb, collector)
    meta = parse_meta(wb, collector)
    resources, ephemeris_snapshot = parse_ephemeris(wb, collector)
    simulation, simulation_snapshot = parse_simulation(wb, collector)
    component_table = iter_table(wb["Components"], collector)
    components = validate_component_rows(component_table, collector)
    collector.raise_if_errors()

    defaults = parse_default_design(components)
    component_snapshot = []
    overrides = []
    for row in components:
        key = str(row["PlannedConfigKey"])
        excel_default_si = to_si(row.get("DefaultValue"), str(row.get("Unit") or ""))
        if not values_equal(excel_default_si, defaults[key]):
            message = f"Components row {row['ExcelRow']} DefaultValue differs from Modelica default {key}"
            if meta["strictValidation"]:
                collector.error("Components", int(row["ExcelRow"]), message, subsystem=str(row.get("Subsystem") or ""), instance=str(row.get("Instance") or ""), parameter=str(row.get("Parameter") or ""))
            else:
                collector.warning(message)
        use_default = bool(row["UseDefaultResolved"])
        resolved_si = defaults[key] if use_default else to_si(row.get("Value"), str(row.get("Unit") or ""))
        row["ResolvedSIValue"] = resolved_si
        if not use_default:
            overrides.append(row)
        component_snapshot.append({
            "Kind": "Component", "Subsystem": row.get("Subsystem"), "Instance": row.get("Instance"),
            "ComponentModel": row.get("ComponentModel"), "Category": row.get("Category"),
            "Parameter": row.get("Parameter"), "ExcelValue": row.get("Value"), "Unit": row.get("Unit"),
            "UseDefault": use_default, "ResolvedValue": resolved_si, "ResolvedSIValue": resolved_si,
            "ConfigKey": key, "ModelicaTarget": row.get("CurrentModelTarget"),
            "ChangedFromDefault": not values_equal(resolved_si, defaults[key]),
        })

    default_scenario_text = DEFAULT_SCENARIO.read_text(encoding="utf-8")
    orbit, orbit_snapshot = parse_orbit(
        wb,
        collector,
        default_scenario_text,
        simulation["StartTimeUTC"],
        str(simulation["TimeZone"]),
    )
    top_mods, initial_mods, initial_snapshot = parse_initial(wb, collector, default_scenario_text)
    ground_array, ground_snapshot = parse_sites(wb, "GroundStations", 8, "GroundStationConfig", collector)
    target_array, target_snapshot = parse_sites(wb, "ImagingTargets", 32, "ImagingTargetConfig", collector)
    audit = mapping_audit(components, defaults, collector)
    if meta["strictValidation"] and collector.warnings:
        for warning in collector.warnings:
            collector.error("Workbook", None, warning)
        collector.warnings.clear()
    collector.raise_if_errors()

    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="nissa_ephemeris_") as temporary_name:
        staging = Path(temporary_name)
        metadata = prepare_environment({
            "resources": resources,
            "start_time": simulation["StartTimeUTC"],
            "duration_seconds": simulation["DurationSeconds"],
            "state_epoch": orbit["state_epoch"],
            "state_input_mode": orbit["state_input_mode"],
            "state_frame": orbit["state_frame"],
            "initial_state": orbit["initial_state"],
        }, staging)
        workbook_staging = staging / "DesignConfig.xlsx"
        update_orbit_resolved_workbook(excel_path, metadata, workbook_staging)
        changed_files = []
        for name in ("environment.txt", "environment_metadata.json"):
            if copy_if_changed(staging / name, GENERATED_ENVIRONMENT / name):
                changed_files.append(str((GENERATED_ENVIRONMENT / name).relative_to(PACKAGE_ROOT)))
        if write_if_changed(GENERATED_DESIGN, generated_design_text(components, overrides)):
            changed_files.append(str(GENERATED_DESIGN.relative_to(PACKAGE_ROOT)))
        scenario_text = generated_scenario_text(
            orbit_record_literal(orbit, metadata), top_mods, initial_mods, ground_array, target_array
        )
        if write_if_changed(GENERATED_SCENARIO, scenario_text):
            changed_files.append(str(GENERATED_SCENARIO.relative_to(PACKAGE_ROOT)))
        if update_complete_mission(simulation):
            changed_files.append(str(COMPLETE_MISSION.relative_to(PACKAGE_ROOT)))
        copy_if_changed(workbook_staging, excel_path)
        copy_if_changed(staging / "environment_metadata.json", OUTPUT_DIR / "environment_metadata.json")
    flags_keys = (
        "StartTime", "StopTime", "OutputInterval", "Tolerance", "Solver", "IDALinearSolver", "Jacobian", "MaxSizeLinearTearing"
    )
    flags_text = "\n".join(f"{key}={simulation[key]}" for key in flags_keys) + (
        f"\nStartUTC={metadata['startUTC']}\nEndUTC={metadata['endUTC']}\n"
    )
    write_if_changed(PACKAGE_ROOT / "Simulation" / "generated_simulation_flags.txt", flags_text)

    resolved_snapshot = [{
        "Kind": "OrbitResolved", "Subsystem": "Environment", "Instance": "generatedEnvironment",
        "Parameter": key, "ExcelValue": None, "Unit": "derived", "UseDefault": False,
        "ResolvedValue": value, "ResolvedSIValue": value,
        "ConfigKey": f"OrbitResolved.{key}", "ModelicaTarget": "Generated environment resource",
        "ChangedFromDefault": False,
    } for key, value in {
        "StartUTC": metadata["startUTC"], "EndUTC": metadata["endUTC"],
        "StateEpochUTC": metadata["stateEpochUTC"], "StateAtSimulationStart": metadata["stateAtSimulationStart"],
        "DerivedElementsAtSimulationStart": metadata["derivedElementsAtSimulationStart"],
        "EOPStatus": metadata["iers"]["label"], "EnvironmentTableSHA256": metadata["tableSHA256"],
    }.items()]
    snapshot = component_snapshot + orbit_snapshot + initial_snapshot + ground_snapshot + target_snapshot + simulation_snapshot + ephemeris_snapshot + resolved_snapshot
    snapshot_doc = {
        "generatedAtUTC": datetime.now(timezone.utc).isoformat(),
        "sourceWorkbook": str(excel_path),
        "scenarioName": meta["scenarioName"],
        "modelicaDefaultSource": str(DEFAULT_DESIGN.relative_to(PACKAGE_ROOT)),
        "absoluteTimeEnvironment": metadata,
        "parameters": [serialize_snapshot_value(item) for item in snapshot],
    }
    snapshot_json = OUTPUT_DIR / "resolved_parameter_snapshot.json"
    snapshot_json.write_text(json.dumps(snapshot_doc, ensure_ascii=False, indent=2), encoding="utf-8")
    flat_snapshot = []
    for item in snapshot:
        flat_snapshot.append({key: json.dumps(value, ensure_ascii=False) if isinstance(value, (dict, list)) else value for key, value in item.items()})
    write_csv(OUTPUT_DIR / "resolved_parameter_snapshot.csv", flat_snapshot)
    write_csv(PACKAGE_ROOT / "PARAMETER_MAPPING_AUDIT.csv", audit)

    if not args.skip_mass_properties:
        mass_tool = Path(__file__).with_name("generate_mass_properties.py")
        result = subprocess.run(
            [sys.executable, str(mass_tool), "--resolved-snapshot", str(snapshot_json), "--generate-record", "--output-dir", str(OUTPUT_DIR / "mass_properties")],
            cwd=PACKAGE_ROOT,
            text=True,
            encoding="utf-8",
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
        )
        if result.returncode != 0:
            raise RuntimeError("mass-properties audit failed:\n" + result.stdout)

    report = [
        "# NISSA 设计配置更新报告",
        "",
        f"- 场景名称：`{meta['scenarioName']}`",
        f"- 参数表：`{excel_path.name}`",
        f"- 组件参数：{len(components)}",
        f"- Excel 显式覆盖：{len(overrides)}",
        f"- 参数映射：{sum(item['Status'] == 'PASS' for item in audit)}/{len(audit)} PASS",
        f"- 配置生成文件变化：{len(changed_files)}",
        f"- 机械质量属性：{'跳过（仅诊断）' if args.skip_mass_properties else '审计并生成'}",
        f"- UTC区间：`{metadata['startUTC']}` → `{metadata['endUTC']}`",
        f"- 状态输入：`{metadata['stateInputMode']} / {metadata['inputFrame']}`，状态历元 `{metadata['stateEpochUTC']}`",
        f"- 环境传播：`{metadata['model']}`，环境采样 {metadata['finalSampleInterval']} s",
        f"- EOP状态：`{metadata['iers']['label']}`",
        f"- 环境插值最大误差：位置 {metadata['interpolationValidation']['maxPositionError_m']:.6g} m；速度 {metadata['interpolationValidation']['maxVelocityError_m_s']:.6g} m/s；地球定向 {metadata['interpolationValidation']['maxEarthRotationAngleError_arcsec']:.6g} arcsec",
        "",
        "## 生成文件",
        "",
        *[f"- `{item}`" for item in changed_files],
        "",
        "## 警告",
        "",
        *([f"- {item}" for item in collector.warnings] or ["- 无"]),
        "",
        "## 下一步",
        "",
        "在 OpenModelica/OMEdit 中运行 `NISSA_12UCubeSat.Simulation.CompleteMission`。配置更新工具不会自动启动 MWorks，也不会自动运行24 h仿真。",
        "",
    ]
    (OUTPUT_DIR / "config_update_report.md").write_text("\n".join(report), encoding="utf-8")
    error_log = OUTPUT_DIR / "update_error.log"
    if error_log.exists():
        error_log.unlink()
    print(f"[SUCCESS] 配置更新成功 / configuration updated: {len(components)} component parameters")
    print(f"[SUCCESS] 参数映射 / mapping audit: {len(audit)}/{len(audit)} PASS")
    print("[INFO] Simulation entry: NISSA_12UCubeSat.Simulation.CompleteMission")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception as exc:
        OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
        (OUTPUT_DIR / "update_error.log").write_text(traceback.format_exc(), encoding="utf-8")
        print(f"[ERROR] 配置更新失败 / configuration update failed: {exc}")
        print(f"[INFO] 详细日志 / details: {OUTPUT_DIR / 'update_error.log'}")
        raise SystemExit(1)
