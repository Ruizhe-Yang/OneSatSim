"""OneSatSim 根目录 DesignConfig.xlsx 的结构与物理合法性规则。"""

from __future__ import annotations

import math
import re
from dataclasses import dataclass
from typing import Any, Iterable

from parameter_units import UnitConversionError, parse_boolean, to_si


REQUIRED_SHEETS = (
    "README",
    "Meta",
    "Orbit",
    "GroundStations",
    "ImagingTargets",
    "InitialConditions",
    "Simulation",
    "Components",
    "Ephemeris",
    "OrbitResolved",
)

REQUIRED_HEADERS = {
    "Meta": ("Parameter", "Value", "DefaultValue", "Description", "Tool / Model Target", "Notes"),
    "Orbit": ("Parameter", "Value", "Unit", "DefaultValue", "UseDefault", "ModelicaTarget", "Description", "Notes"),
    "GroundStations": ("Slot", "Enabled", "ID", "Name", "Latitude_deg", "Longitude_deg", "Altitude_m", "MinElevation_deg", "Priority", "ModelicaTarget", "Notes"),
    "ImagingTargets": ("Slot", "Enabled", "ID", "Name", "Latitude_deg", "Longitude_deg", "Altitude_m", "MinElevation_deg", "Priority", "ModelicaTarget", "Notes"),
    "InitialConditions": ("Subsystem", "Parameter", "Value", "Unit", "DefaultValue", "UseDefault", "ModelicaTarget", "Description", "Notes"),
    "Simulation": ("Parameter", "Value", "Unit", "DefaultValue", "ToolTarget", "Description", "Notes"),
    "Components": ("Subsystem", "Instance", "ComponentModel", "Category", "Parameter", "中文参数", "Value", "Unit", "DefaultValue", "UseDefault", "CurrentStatus", "CurrentModelTarget", "PlannedConfigKey", "Description", "Notes / Validation", "Changed"),
    "Ephemeris": ("Parameter", "Value", "Unit", "DefaultValue", "Description", "Notes"),
    "OrbitResolved": ("Parameter", "Value", "Unit", "Description", "Source"),
}

ALLOWED_SUBSYSTEMS = {
    "EPS",
    "GNC",
    "Payload",
    "DataHandling",
    "Communication",
    "Navigation",
    "ThermalControl",
    "Structure",
}

PROHIBITED_CONTROL_TERMS = (
    "PointingTolerance",
    "ControlGain",
    "DwellTime",
    "MomentumDumpEnter",
    "MomentumDumpExit",
    "SafeModeThreshold",
    "MissionPriority",
    "Sequencer",
)


@dataclass(frozen=True)
class ConfigError:
    sheet: str
    row: int | None
    reason: str
    subsystem: str = ""
    instance: str = ""
    parameter: str = ""

    def render(self) -> str:
        lines = ["[ERROR]", f"Sheet: {self.sheet}"]
        if self.row is not None:
            lines.append(f"Row: {self.row}")
        if self.subsystem:
            lines.append(f"Subsystem: {self.subsystem}")
        if self.instance:
            lines.append(f"Instance: {self.instance}")
        if self.parameter:
            lines.append(f"Parameter: {self.parameter}")
        lines.append(f"Reason: {self.reason}")
        return "\n".join(lines)


class ValidationCollector:
    def __init__(self) -> None:
        self.errors: list[ConfigError] = []
        self.warnings: list[str] = []

    def error(self, sheet: str, row: int | None, reason: str, **context: str) -> None:
        self.errors.append(ConfigError(sheet, row, reason, **context))

    def warning(self, message: str) -> None:
        self.warnings.append(message)

    def raise_if_errors(self) -> None:
        if self.errors:
            raise ValueError("\n\n".join(error.render() for error in self.errors))


def normalize_header(value: Any) -> str:
    return str(value or "").strip()


def find_header_row(ws: Any, expected: Iterable[str], collector: ValidationCollector) -> tuple[int, dict[str, int]]:
    expected = tuple(expected)
    for row in range(1, min(ws.max_row, 12) + 1):
        mapping = {
            normalize_header(ws.cell(row, col).value): col
            for col in range(1, ws.max_column + 1)
            if normalize_header(ws.cell(row, col).value)
        }
        if all(name in mapping for name in expected):
            return row, mapping
    collector.error(ws.title, None, f"required headers missing or renamed: {', '.join(expected)}")
    return 0, {}


def iter_table(ws: Any, collector: ValidationCollector) -> list[tuple[int, dict[str, Any]]]:
    header_row, mapping = find_header_row(ws, REQUIRED_HEADERS[ws.title], collector)
    if not header_row:
        return []
    rows = []
    for row_number in range(header_row + 1, ws.max_row + 1):
        row = {name: ws.cell(row_number, column).value for name, column in mapping.items()}
        if any(value not in (None, "") for value in row.values()):
            rows.append((row_number, row))
    return rows


def validate_workbook_shape(wb: Any, collector: ValidationCollector) -> None:
    actual = tuple(wb.sheetnames)
    if actual != REQUIRED_SHEETS:
        collector.error(
            "Workbook",
            None,
            "sheet names/order must be exactly: " + ", ".join(REQUIRED_SHEETS) + f"; got: {', '.join(actual)}",
        )
    for sheet in REQUIRED_HEADERS:
        if sheet in wb.sheetnames:
            find_header_row(wb[sheet], REQUIRED_HEADERS[sheet], collector)


def _positive(parameter: str) -> bool:
    tokens = (
        "Mass", "Inertia", "Resistance", "HeatCapacity", "CapacityBytes",
        "Conductance", "Current", "Power", "Voltage", "DataRate", "ImageSize",
        "CaptureDuration", "SpeedLimit", "MaxTorque", "RotorInertia", "Density",
        "Width", "Height", "Length", "Thickness", "ActiveArea",
    )
    return any(token in parameter for token in tokens)


def validate_component_rows(rows: list[tuple[int, dict[str, Any]]], collector: ValidationCollector) -> list[dict[str, Any]]:
    resolved_rows: list[dict[str, Any]] = []
    seen_keys: set[str] = set()
    instance_models: dict[tuple[str, str], str] = {}
    vector_groups: dict[tuple[str, str], dict[str, float]] = {}
    battery_soc: dict[str, float] = {}
    for row_number, row in rows:
        subsystem = str(row.get("Subsystem") or "").strip()
        instance = str(row.get("Instance") or "").strip()
        parameter = str(row.get("Parameter") or "").strip()
        context = {"subsystem": subsystem, "instance": instance, "parameter": parameter}
        if subsystem not in ALLOWED_SUBSYSTEMS:
            collector.error("Components", row_number, f"unknown subsystem {subsystem!r}", **context)
        model = str(row.get("ComponentModel") or "").strip()
        if not re.fullmatch(r"(?:Components|Systems\.Four_systems)\.[A-Za-z_]\w*", model):
            collector.error("Components", row_number, f"invalid ComponentModel {model!r}", **context)
        previous_model = instance_models.setdefault((subsystem, instance), model)
        if previous_model != model:
            collector.error("Components", row_number, "same instance refers to more than one ComponentModel", **context)
        key = str(row.get("PlannedConfigKey") or "").strip()
        expected_prefix = "SpacecraftDesignConfig."
        if not key.startswith(expected_prefix) or len(key.split(".")) != 4:
            collector.error("Components", row_number, f"invalid PlannedConfigKey {key!r}", **context)
        if key in seen_keys:
            collector.error("Components", row_number, f"duplicate PlannedConfigKey {key}", **context)
        seen_keys.add(key)
        if not str(row.get("CurrentModelTarget") or "").strip():
            collector.error("Components", row_number, "CurrentModelTarget is blank", **context)
        status = str(row.get("CurrentStatus") or "")
        if not (status.startswith("P-") or status.startswith("H-")):
            collector.error("Components", row_number, "CurrentStatus must begin with P- or H-", **context)
        if any(term.lower() in parameter.lower() for term in PROHIBITED_CONTROL_TERMS):
            collector.error("Components", row_number, "control-law parameter is outside the design configuration boundary", **context)
        try:
            use_default = parse_boolean(row.get("UseDefault"))
        except UnitConversionError as exc:
            collector.error("Components", row_number, str(exc), **context)
            continue
        source_value = row.get("DefaultValue") if use_default else row.get("Value")
        try:
            si_value = to_si(source_value, str(row.get("Unit") or ""))
        except UnitConversionError as exc:
            collector.error("Components", row_number, str(exc), **context)
            continue
        if isinstance(si_value, (int, float)) and not isinstance(si_value, bool):
            numeric = float(si_value)
            if _positive(parameter) and "Offset" not in parameter and "RCM_" not in parameter and numeric <= 0:
                collector.error("Components", row_number, "expected positive physical value", **context)
            if any(term in parameter for term in ("Efficiency", "Absorptivity", "Emissivity", "EOLFactor")) and not (0 < numeric <= 1):
                collector.error("Components", row_number, "expected value in (0, 1]", **context)
            if parameter in {"CellSOCMin", "CellSOCMax"}:
                battery_soc[parameter] = numeric
                if not 0 <= numeric <= 1:
                    collector.error("Components", row_number, "SOC bound must be within [0, 1]", **context)
            vector_match = re.fullmatch(r"(?:Normal|Axis)_([XYZ])", parameter)
            if vector_match:
                vector_groups.setdefault((subsystem, instance), {})[vector_match.group(1)] = numeric
        resolved_rows.append({**row, "ExcelRow": row_number, "UseDefaultResolved": use_default, "ResolvedSIValue": si_value})
    if battery_soc and battery_soc.get("CellSOCMin", 0) >= battery_soc.get("CellSOCMax", 1):
        collector.error("Components", None, "battery CellSOCMin must be smaller than CellSOCMax", subsystem="EPS", instance="battery")
    for (subsystem, instance), vector in vector_groups.items():
        if set(vector) == {"X", "Y", "Z"} and math.sqrt(sum(value * value for value in vector.values())) <= 1e-12:
            collector.error("Components", None, "normal/axis vector cannot be zero", subsystem=subsystem, instance=instance)
    return resolved_rows
