"""Resolve one effective CLI configuration from the generated configuration group."""

from __future__ import annotations

import json
import math
import re
from pathlib import Path

import openpyxl

ROOT = Path(__file__).resolve().parents[1]
_FIELDS = ("StartTime", "StopTime", "OutputInterval", "Tolerance", "Solver",
           "IDALinearSolver", "Jacobian", "MaxSizeLinearTearing")
_MAP = {"StartTime": "startTime", "StopTime": "stopTime", "OutputInterval": "outputInterval",
        "Tolerance": "tolerance", "Solver": "solver", "IDALinearSolver": "idaLinearSolver",
        "Jacobian": "jacobian", "MaxSizeLinearTearing": "maxSizeLinearTearing"}
_FORMAL = {"startTime": 0.0, "stopTime": 86400.0, "outputInterval": 1.0,
           "tolerance": 1e-7, "solver": "ida", "idaLinearSolver": "spgmr",
           "jacobian": "coloredNumerical"}


def _same(a, b):
    if isinstance(a, (int, float)) and isinstance(b, (int, float)):
        return math.isclose(float(a), float(b), rel_tol=1e-12, abs_tol=1e-12)
    return str(a) == str(b)


def _number_or_text(value: str):
    try:
        return float(value)
    except ValueError:
        return value


def _workbook_values(path: Path) -> dict:
    book = openpyxl.load_workbook(path, read_only=True, data_only=True)
    try:
        sheet = book["Simulation"]
        rows = list(sheet.iter_rows(values_only=True))
        heading = next(i for i, row in enumerate(rows) if row and row[0] == "Parameter" and row[1] == "Value")
        return {str(row[0]): row[1] for row in rows[heading + 1:] if row and row[0] in _FIELDS}
    finally:
        book.close()


def _annotation(path: Path) -> dict:
    text = path.read_text(encoding="utf-8")
    experiment = re.search(r"experiment\s*\(\s*StartTime\s*=\s*([^,]+),\s*StopTime\s*=\s*([^,]+),\s*Interval\s*=\s*([^,]+),\s*Tolerance\s*=\s*([^\)]+)\)", text)
    simulation = re.search(r"__OpenModelica_simulationFlags\s*\(\s*s\s*=\s*\"([^\"]+)\"\s*,\s*idaLS\s*=\s*\"([^\"]+)\"\s*,\s*jacobian\s*=\s*\"([^\"]+)\"", text)
    tearing = re.search(r"--maxSizeLinearTearing\s*=\s*([0-9.eE+-]+)", text)
    if not (experiment and simulation and tearing):
        raise ValueError("CONFIG_CONTRACT_CONFLICT: CompleteMission experiment/solver annotation incomplete")
    return {"startTime": float(experiment[1]), "stopTime": float(experiment[2]),
            "outputInterval": float(experiment[3]), "tolerance": float(experiment[4]),
            "solver": simulation[1], "idaLinearSolver": simulation[2], "jacobian": simulation[3],
            "maxSizeLinearTearing": float(tearing[1])}


def resolve(root: Path, contract: dict, *, run_kind: str = "NOMINAL_FULL",
            stop: float | None = None, output_interval: float | None = None,
            reason: str | None = None, build_timeout: int = 900,
            simulation_timeout: int = 3600) -> dict:
    if run_kind not in ("NOMINAL_FULL", "LOCAL_TEST", "SMOKE", "DIAGNOSTIC"):
        raise ValueError("Invalid runKind")
    flags_path = root / "Scripts/ConfigSupport/generated_simulation_flags.txt"
    flags = {}
    for line in flags_path.read_text(encoding="utf-8").splitlines():
        if line.strip():
            key, value = line.split("=", 1)
            flags[key.strip()] = _number_or_text(value.strip())
    missing = sorted(set(_FIELDS) - flags.keys())
    if missing:
        raise ValueError(f"CONFIG_CONTRACT_CONFLICT: generated flags missing {missing}")
    source = {_MAP[key]: flags[key] for key in _FIELDS}
    snapshot = json.loads((root / "Scripts/ConfigSupport/current_snapshot.json").read_text(encoding="utf-8"))
    snapshot_values = {item["Parameter"]: item["ResolvedValue"] for item in snapshot["parameters"]
                       if item.get("Kind") == "Simulation" and item.get("Parameter") in _FIELDS}
    workbook_values = _workbook_values(root / "DesignConfig.xlsx")
    annotation_values = _annotation(root / "Simulation/CompleteMission.mo")
    conflicts = []
    for key in _FIELDS:
        if key not in snapshot_values or key not in workbook_values:
            conflicts.append(f"{key}: missing workbook/snapshot value")
            continue
        if not _same(flags[key], snapshot_values[key]) or not _same(flags[key], workbook_values[key]):
            conflicts.append(f"{key}: workbook={workbook_values[key]!r}, snapshot={snapshot_values[key]!r}, flags={flags[key]!r}")
    for key, expected in annotation_values.items():
        if not _same(source[key], expected):
            conflicts.append(f"{key}: annotation={expected!r}, flags={source[key]!r}")
    if conflicts:
        raise ValueError("CONFIG_CONTRACT_CONFLICT: " + "; ".join(conflicts))
    if run_kind == "NOMINAL_FULL":
        if stop is not None or output_interval is not None:
            raise ValueError("NOMINAL_FULL cannot apply diagnostic time/grid overrides")
        wrong = [f"{key}={source[key]!r}" for key, value in _FORMAL.items() if not _same(source[key], value)]
        if wrong:
            raise ValueError("CONFIG_CONTRACT_CONFLICT: formal nominal settings " + ", ".join(wrong))
    else:
        if not reason:
            raise ValueError("Diagnostic run requires --reason")
    effective = dict(source)
    overrides = {}
    if stop is not None:
        effective["stopTime"] = float(stop)
        overrides["stopTime"] = {"requested": source["stopTime"], "effective": float(stop), "reason": reason}
    if output_interval is not None:
        effective["outputInterval"] = float(output_interval)
        overrides["outputInterval"] = {"requested": source["outputInterval"],
                                        "effective": float(output_interval), "reason": reason}
    if effective["stopTime"] <= effective["startTime"] or effective["outputInterval"] <= 0:
        raise ValueError("Invalid effective time interval")
    intervals = (effective["stopTime"] - effective["startTime"]) / effective["outputInterval"]
    if abs(intervals - round(intervals)) > 1e-10:
        raise ValueError("Effective duration is not divisible by output interval")
    if build_timeout <= 0 or simulation_timeout <= 0:
        raise ValueError("Supervision timeout must be positive")
    policy = contract["outputPolicy"]
    return {"schemaVersion": "1.0", "projectVersion": "1.1.4", "mosaicVersion": "0.5.0",
            "entryModel": contract["entryModel"], "runKind": run_kind,
            "requested": source, "effective": effective, "overrides": overrides,
            "sourcePaths": {"workbook": "DesignConfig.xlsx", "snapshot": "Scripts/ConfigSupport/current_snapshot.json",
                            "flags": "Scripts/ConfigSupport/generated_simulation_flags.txt",
                            "annotation": "Simulation/CompleteMission.mo"},
            "numberOfIntervals": round(intervals),
            "compileOptions": f"--maxSizeLinearTearing={int(effective['maxSizeLinearTearing'])}",
            "output": {"format": policy["format"], "precision": policy["precision"],
                       "maximumBytes": policy["maximumBytes"], "retainEvents": policy["retainEvents"]},
            "supervision": {"buildSeconds": build_timeout, "simulationSeconds": simulation_timeout,
                            "role": "abnormal-process-supervision-not-performance-budget"},
            "diagnosticReason": reason}
