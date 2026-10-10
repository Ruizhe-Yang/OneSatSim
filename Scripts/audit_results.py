#!/usr/bin/env python3
"""Audit an actual OpenModelica MAT v4 against Scripts/Contracts/results.json.

The reader keeps dynamic data memory mapped and preserves duplicate event rows.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import sys
from pathlib import Path

import numpy as np

from matv4 import MatV4, require_grid

ROOT = Path(__file__).resolve().parents[1]
CONTRACT = ROOT / "Scripts" / "Contracts" / "results.json"


def digest(path: Path) -> str:
    result = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            result.update(block)
    return result.hexdigest()


def load_contract(path: Path = CONTRACT) -> dict:
    contract = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(contract.get("signals"), list) or not contract["signals"]:
        raise ValueError("results.json needs nonempty signals[]")
    if contract.get("schemaVersion") != "1.0" or contract.get("entryModel") != "OneSatSim.Simulation.CompleteMission":
        raise ValueError("results.json identity/schema mismatch")
    required = ("semanticId", "path", "unit", "dimensions", "timeKind", "identity",
                "producer", "required", "save", "purpose")
    seen = set()
    for signal in contract["signals"]:
        if any(field not in signal for field in required):
            raise ValueError(f"Incomplete signal contract: {signal}")
        identifier = signal["semanticId"]
        if not isinstance(identifier, str) or identifier in seen:
            raise ValueError(f"Duplicate or invalid semantic ID: {identifier!r}")
        seen.add(identifier)
        if not isinstance(signal["path"], str) or not signal["path"]:
            raise ValueError(f"Invalid path for {identifier}")
        if not isinstance(signal["required"], bool) or not isinstance(signal["save"], bool):
            raise ValueError(f"required/save must be Boolean for {identifier}")
        if signal["required"] and not signal["save"]:
            raise ValueError(f"Required signal cannot be omitted from MAT: {identifier}")
        if signal["timeKind"] not in ("continuous", "discrete", "event", "parameter", "time"):
            raise ValueError(f"Unknown time kind for {identifier}")
    policy = contract.get("outputPolicy", {})
    if policy.get("format") != "mat" or policy.get("precision") != "float64":
        raise ValueError("Formal output policy requires MAT/float64")
    if policy.get("maximumBytes") != 50_000_000 or policy.get("retainEvents") is not True:
        raise ValueError("Output policy disagrees with v1.1.4 acceptance")
    if not isinstance(contract.get("physics_acceptance"), dict):
        raise ValueError("physics_acceptance is required")
    return contract


def integrate(time: np.ndarray, values: np.ndarray, method: str) -> float:
    """Integrate raw event segments; duplicate timestamps contribute zero duration."""
    dt = np.diff(time)
    if method == "trapezoid":
        return float(np.sum(dt * (values[:-1] + values[1:]) / 2.0))
    if method == "post-event-hold":
        return float(np.sum(dt * values[:-1]))
    raise ValueError(f"Unsupported integration method: {method}")


def _signal_summary(time: np.ndarray, values: np.ndarray, signal: dict) -> dict:
    if values.size == 0 or not np.isfinite(values).all():
        raise ValueError(f"Required signal nonfinite/empty: {signal['semanticId']}")
    discrete = signal["timeKind"] in ("discrete", "event")
    method = "post-event-hold" if discrete else "trapezoid"
    duration = time[-1] - time[0]
    changes = np.flatnonzero(values[1:] != values[:-1]) + 1 if values.size == time.size else np.array([], dtype=int)
    positive = float(np.sum(np.diff(time) * (values[:-1] > 0.5))) if values.size == time.size else None
    summary = {"start": float(values[0]), "end": float(values[-1]),
               "minimum": float(np.min(values)), "maximum": float(np.max(values)),
               "changes": int(changes.size), "firstChangeTimes": time[changes[:25]].tolist(),
               "positiveSeconds": positive}
    if values.size == time.size and duration > 0:
        summary["timeWeightedMean"] = integrate(time, values, method) / duration
        summary["integral"] = integrate(time, values, method)
        summary["integrationMethod"] = method
    if discrete and values.size == time.size:
        edges = np.flatnonzero((values[:-1] <= 0.5) & (values[1:] > 0.5)) + 1
        summary["risingEdges"] = int(edges.size)
        summary["firstRisingTimes"] = time[edges[:25]].tolist()
    return summary


def audit_mission(mat: MatV4, config: dict) -> dict:
    """Check daily task completions and request order from unresampled rows."""
    if config.get("runKind") != "NOMINAL_FULL":
        return {"status": "NOT_APPLICABLE", "reason": "Short run has no daily mission quota"}
    names = {
        "imageCount": "onboardTelemetry.completedImagingCount",
        "target": "onboardTelemetry.lastCompletedTargetId",
        "downlinkCount": "onboardTelemetry.completedDownlinkCount",
        "readRate": "onboardTelemetry.actualReadRate",
        "writeRate": "onboardTelemetry.acceptedWriteRate",
        "validBytes": "onboardTelemetry.validImageBytes",
        "acceptedId": "spacecraft.dataHandlingSystem.obc.missionControl.arbiter.decision.acceptedCommandId",
        "terminalId": "onboardTelemetry.lastTerminalRequestId",
        "activeId": "spacecraft.dataHandlingSystem.obc.missionControl.stateMachine.state.activeRequestId",
        "captureStarted": "spacecraft.dataHandlingSystem.obc.missionControl.imagingSequencer.action.captureStarted",
        "imageEventId": "spacecraft.dataHandlingSystem.obc.missionControl.stateMachine.imagingCompletedEventId",
        "downlinkEventId": "spacecraft.dataHandlingSystem.obc.missionControl.stateMachine.downlinkCompletedEventId",
    }
    absent = {key: path for key, path in names.items() if path not in mat.lookup}
    if absent:
        return {"status": "FAIL", "reason": "Mission evidence absent", "missing": absent}
    values = {key: mat.read(path) for key, path in names.items()}
    time = mat.time

    def events(key: str) -> list[dict]:
        series = values[key]
        indices = np.flatnonzero((series[1:] != series[:-1]) & (series[1:] > 0)) + 1
        if series[0] > 0:
            indices = np.r_[0, indices]
        return [{"id": int(round(series[i])), "time": float(time[i]), "row": int(i)}
                for i in indices]

    accepted = events("acceptedId")
    terminal = events("terminalId")
    image_events = events("imageEventId")
    downlink_events = events("downlinkEventId")
    accepted_by_id = {event["id"]: event for event in accepted}
    terminal_by_id = {event["id"]: event for event in terminal}
    duplicate_accepted = len(accepted) != len(accepted_by_id)
    duplicate_terminal = len(terminal) != len(terminal_by_id)
    orphan = sorted(set(terminal_by_id) - set(accepted_by_id))
    unterminated = sorted(set(accepted_by_id) - set(terminal_by_id))
    out_of_order = [event["id"] for event in terminal
                    if event["id"] in accepted_by_id and
                    event["row"] < accepted_by_id[event["id"]]["row"]]
    image_edges = np.flatnonzero(np.diff(values["imageCount"]) > 0) + 1
    image_completions = []
    for i in image_edges:
        # Retain the final post-event state at this exact Modelica time.
        j = int(np.searchsorted(time, time[i], side="right") - 1)
        image_completions.append({"time": float(time[i]), "row": int(i),
                                  "targetId": int(round(values["target"][j])),
                                  "validBytes": float(values["validBytes"][j])})
    distinct = sorted({item["targetId"] for item in image_completions if item["targetId"] > 0})
    capture_indices = np.flatnonzero((values["captureStarted"][:-1] <= 0.5) &
                                     (values["captureStarted"][1:] > 0.5)) + 1
    captures = [{"time": float(time[i]), "requestId": int(round(values["activeId"][i]))}
                for i in capture_indices]
    completed = int(round(values["imageCount"][-1]))
    downlinks = int(round(values["downlinkCount"][-1]))
    read_bytes = integrate(time, values["readRate"], "trapezoid")
    written_bytes = integrate(time, values["writeRate"], "trapezoid")
    image_ids = [event["id"] for event in image_events]
    downlink_ids = [event["id"] for event in downlink_events]
    event_order_ok = (all(event["id"] in accepted_by_id and event["id"] in terminal_by_id
                          for event in image_events + downlink_events) and
                      all(item["targetId"] > 0 and item["validBytes"] > 0
                          for item in image_completions))
    passed = (completed >= 4 and len(distinct) >= 4 and downlinks >= 1 and
              read_bytes > 0 and written_bytes > 0 and
              len(image_completions) == completed - int(round(values["imageCount"][0])) and
              len(image_events) == completed and len(downlink_events) == downlinks and
              len(image_ids) == len(set(image_ids)) and
              len(downlink_ids) == len(set(downlink_ids)) and
              event_order_ok and not duplicate_accepted and not duplicate_terminal and
              not orphan and not unterminated and not out_of_order)
    return {"status": "PASS" if passed else "FAIL", "completedImages": completed,
            "distinctCompletedTargets": distinct, "completedDownlinks": downlinks,
            "actualReadBytes": read_bytes, "acceptedWriteBytes": written_bytes,
            "acceptedRequests": accepted, "captureStarts": captures,
            "imageCompletedEvents": image_events, "imageCompletions": image_completions,
            "downlinkCompletedEvents": downlink_events, "terminalRequests": terminal,
            "orphanTerminalIds": orphan, "unterminatedAcceptedIds": unterminated,
            "duplicateAcceptedIds": duplicate_accepted,
            "duplicateTerminalIds": duplicate_terminal,
            "terminalBeforeAcceptanceIds": out_of_order,
            "eventOrderAndValidBytesPass": event_order_ok}


def audit_storage_ledger(mat: MatV4, config: dict) -> dict:
    """Close the nominal recorder inventory from independently saved rates."""
    if config.get("runKind") != "NOMINAL_FULL":
        return {"status": "NOT_APPLICABLE", "reason": "Short run has no nominal storage ledger gate"}
    paths = {
        "stored": "onboardTelemetry.storedBytes",
        "acceptedWrite": "onboardTelemetry.acceptedWriteRate",
        "actualRead": "onboardTelemetry.actualReadRate",
        "explicitDiscard": "spacecraft.dataHandlingSystem.recorder.recorderCalculation.discardedBytesRate",
    }
    missing = {key: path for key, path in paths.items() if path not in mat.lookup}
    if missing:
        return {"status": "FAIL", "reason": "Recorder ledger evidence absent", "missing": missing}
    time = mat.time
    try:
        values = {}
        for key, path in paths.items():
            series = mat.read(path)
            if series.size == 2 and time.size != 2 and series[0] == series[1]:
                series = np.full(time.size, series[0], dtype=np.float64)
            if series.size != time.size or not np.isfinite(series).all():
                raise ValueError(f"{key} must be a finite value at every raw time/event row")
            values[key] = series
        net_rate = values["acceptedWrite"] - values["actualRead"] - values["explicitDiscard"]
        increments = np.diff(time) * (net_rate[:-1] + net_rate[1:]) / 2.0
        expected = values["stored"][0] + np.r_[0.0, np.cumsum(increments)]
        residual = values["stored"] - expected
        accepted_bytes = integrate(time, values["acceptedWrite"], "trapezoid")
        actual_read_bytes = integrate(time, values["actualRead"], "trapezoid")
        discarded_bytes = integrate(time, values["explicitDiscard"], "trapezoid")
        throughput = max(0.0, accepted_bytes) + max(0.0, actual_read_bytes)
        tolerance = max(100.0, 1e-5 * throughput)
        max_residual = float(np.max(np.abs(residual)))
        max_discard_rate = float(np.max(np.abs(values["explicitDiscard"])))
        rates_nonnegative = (float(np.min(values["acceptedWrite"])) >= -1e-9 and
                             float(np.min(values["actualRead"])) >= -1e-9)
        passed = max_residual <= tolerance and max_discard_rate <= 1e-9 and rates_nonnegative
        return {"status": "PASS" if passed else "FAIL",
                "initialStoredBytes": float(values["stored"][0]),
                "acceptedWriteBytes": accepted_bytes,
                "actualReadBytes": actual_read_bytes,
                "explicitDiscardBytes": discarded_bytes,
                "observedFinalStoredBytes": float(values["stored"][-1]),
                "predictedFinalStoredBytes": float(expected[-1]),
                "finalResidualBytes": float(residual[-1]),
                "maximumAbsoluteResidualBytes": max_residual,
                "toleranceBytes": tolerance,
                "maximumAbsoluteDiscardRateBytesPerSecond": max_discard_rate,
                "acceptedAndReadRatesNonnegative": rates_nonnegative,
                "integrationMethod": "trapezoid over every saved raw time/event row"}
    except (KeyError, ValueError, IndexError) as exc:
        return {"status": "FAIL", "reason": f"Recorder ledger could not be evaluated: {exc}"}


def audit(path: Path, contract: dict, config: dict) -> dict:
    path = Path(path)
    report = {"schemaVersion": "1.0", "resultPath": str(path), "status": "FAIL",
              "checks": {}, "signals": {}, "missing": []}
    try:
        mat = MatV4(path)
        report["mat"] = mat.summary()
        time = mat.time
        report["checks"]["MAT_FORMAT"] = {"status": "PASS", "detail": "OpenModelica MAT v4 parsed"}
    except Exception as exc:
        report["checks"]["MAT_FORMAT"] = {"status": "FAIL", "detail": str(exc)}
        return report
    formal = config.get("runKind") == "NOMINAL_FULL"
    output = contract["outputPolicy"]
    if formal and (mat.dynamic.dtype != np.dtype("float64") or mat.parameters.dtype != np.dtype("float64")):
        report["checks"]["RESULT_PRECISION"] = {"status": "FAIL", "detail": "Formal MAT must store float64 data_1 and data_2"}
    else:
        report["checks"]["RESULT_PRECISION"] = {"status": "PASS", "detail": str(mat.dynamic.dtype)}
    try:
        grid = require_grid(time, float(config["effective"]["startTime"]),
                            float(config["effective"]["stopTime"]),
                            float(config["effective"]["outputInterval"]))
        report["mat"]["grid"] = grid
        report["checks"]["TIME_GRID"] = {"status": "PASS", "detail": grid}
    except Exception as exc:
        report["checks"]["TIME_GRID"] = {"status": "FAIL", "detail": str(exc)}
    size = path.stat().st_size
    report["bytes"] = size
    report["sha256"] = digest(path)
    report["checks"]["RESULT_SIZE"] = {"status": "PASS" if not formal or size <= output["maximumBytes"] else "FAIL",
                                        "bytes": size, "limitBytes": output["maximumBytes"]}
    missing_required = []
    for signal in contract["signals"]:
        if not signal["save"]:
            continue
        name = signal["path"]
        identifier = signal["semanticId"]
        if name not in mat.lookup:
            report["missing"].append({"semanticId": identifier, "path": name, "required": signal["required"]})
            if signal["required"]:
                missing_required.append(identifier)
            continue
        try:
            values = mat.read(name)
            if signal["timeKind"] != "parameter" and values.size != time.size:
                raise ValueError(f"Expected {time.size} time points, got {values.size}")
            summary = _signal_summary(time, values, signal)
            summary.update({"path": name, "storage": mat.storage(name), "unit": signal["unit"]})
            limits = signal.get("limits", {})
            if "minimum" in limits:
                low = float(limits["minimum"])
                summary["belowMinimumSeconds"] = float(np.sum(np.diff(time) * (values[:-1] < low)))
                if summary["minimum"] < low - float(limits.get("absoluteTolerance", 0)):
                    summary["limitStatus"] = "FAIL"
            if "maximum" in limits:
                high = float(limits["maximum"])
                summary["aboveMaximumSeconds"] = float(np.sum(np.diff(time) * (values[:-1] > high)))
                if summary["maximum"] > high + float(limits.get("absoluteTolerance", 0)):
                    summary["limitStatus"] = "FAIL"
            report["signals"][identifier] = summary
        except Exception as exc:
            report["missing"].append({"semanticId": identifier, "path": name, "required": signal["required"], "error": str(exc)})
            if signal["required"]:
                missing_required.append(identifier)
    report["checks"]["REQUIRED_SIGNALS"] = {"status": "PASS" if not missing_required else "FAIL",
                                             "missing": missing_required, "found": len(report["signals"])}
    bad_limits = [identifier for identifier, signal in report["signals"].items() if signal.get("limitStatus") == "FAIL"]
    report["checks"]["SIGNAL_LIMITS"] = {"status": "PASS" if not bad_limits else "FAIL", "violations": bad_limits}
    structural = "PASS" if all(check["status"] == "PASS" for check in report["checks"].values()) else "FAIL"
    report["matIntegrityStatus"] = structural
    # Physics/use acceptance is supplied by the independent raw-term ledger
    # module. Readability, size and finite columns never imply PH PASS.
    try:
        from physics_ledgers import audit_physics
    except ImportError:
        physics = {key: {"status": "NOT_CHECKED", "reason": "Independent ledger module unavailable"}
                   for key in contract["physics_acceptance"]}
    else:
        physics = audit_physics(mat, contract, config, ROOT)
    report["physics_acceptance"] = physics
    mission = audit_mission(mat, config)
    storage = audit_storage_ledger(mat, config)
    report["storage_acceptance"] = storage
    mission["storageLedger"] = storage
    if formal and storage["status"] != "PASS":
        mission["status"] = "FAIL"
    report["mission_acceptance"] = mission
    required_ph = [physics.get(key, {}).get("status", "NOT_CHECKED")
                   for key, value in contract["physics_acceptance"].items() if value.get("required")]
    if structural == "FAIL" or "FAIL" in required_ph or mission["status"] == "FAIL":
        report["status"] = "FAIL"
    elif all(state in ("PASS", "NOT_APPLICABLE") for state in required_ph):
        report["status"] = "PASS"
    else:
        report["status"] = "NOT_CHECKED"
    return report


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("mat", type=Path)
    parser.add_argument("--resolved-config", type=Path, required=True)
    parser.add_argument("--contract", type=Path, default=CONTRACT)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    contract = load_contract(args.contract)
    config = json.loads(args.resolved_config.read_text(encoding="utf-8"))
    report = audit(args.mat, contract, config)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
    print(json.dumps({"status": report["status"], "checks": report["checks"]}, ensure_ascii=False))
    return 0 if report["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
