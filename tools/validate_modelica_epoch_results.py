#!/usr/bin/env python3
"""Validate the new OpenModelica short and 24 h result files against generated resources."""

from __future__ import annotations

import csv
import json
import math
import re
import struct
from pathlib import Path
from typing import Any

import numpy as np
from scipy.interpolate import Akima1DInterpolator

ROOT = Path(__file__).resolve().parents[1]
PROJECT = ROOT.parent
WORK = PROJECT / "work" / "real_epoch"
OUTPUT = ROOT / "outputs" / "real_epoch_ephemeris_upgrade"


def read_mat4(path: Path) -> dict[str, np.ndarray]:
    matrices: dict[str, np.ndarray] = {}
    with path.open("rb") as handle:
        while True:
            header = handle.read(20)
            if len(header) < 20:
                break
            kind, rows, columns, imaginary, name_length = struct.unpack("<5i", header)
            name = handle.read(name_length).rstrip(b"\0").decode("latin1")
            precision = (kind // 10) % 10
            dtype = {0: "<f8", 1: "<f4", 2: "<i4", 3: "<i2", 4: "<u2", 5: "u1"}[precision]
            count = rows * columns
            raw = handle.read(count * np.dtype(dtype).itemsize)
            matrices[name] = np.frombuffer(raw, dtype=dtype).reshape((rows, columns), order="F")
            if imaginary:
                handle.seek(count * np.dtype(dtype).itemsize, 1)
    return matrices


def decode_columns(matrix: np.ndarray) -> list[str]:
    return [
        bytes(int(value) for value in matrix[:, column] if int(value) != 0).decode("utf-8", errors="replace").strip()
        for column in range(matrix.shape[1])
    ]


class Result:
    def __init__(self, path: Path) -> None:
        self.path = path
        self.matrices = read_mat4(path)
        self.names = decode_columns(self.matrices["name"])
        self.index = {name: offset for offset, name in enumerate(self.names)}
        self.info = self.matrices["dataInfo"].astype(int)

    def series(self, name: str) -> np.ndarray:
        offset = self.index[name]
        matrix_id = int(self.info[0, offset])
        signed_index = int(self.info[1, offset])
        sign = -1.0 if signed_index < 0 else 1.0
        row = abs(signed_index) - 1
        if matrix_id == 0:
            data = self.matrices["data_2"][0, :].astype(float) * sign
        else:
            data = self.matrices[f"data_{matrix_id}"][row, :].astype(float) * sign
        if matrix_id == 1 and data.size == 2:
            return np.full_like(self.series("time"), data[0], dtype=float)
        return data

    def optional(self, *names: str) -> tuple[np.ndarray | None, str | None]:
        for name in names:
            if name in self.index:
                return self.series(name), name
        return None, None


def stats(values: np.ndarray) -> dict[str, float]:
    data = np.asarray(values, dtype=float)
    return {
        "min": float(np.min(data)),
        "max": float(np.max(data)),
        "mean": float(np.mean(data)),
        "final": float(data[-1]),
    }


def rising_edges(values: np.ndarray) -> int:
    active = np.asarray(values) > 0.5
    return int(np.count_nonzero(active & ~np.r_[False, active[:-1]]))


def vector(result: Result, base: str) -> np.ndarray:
    return np.column_stack([result.series(f"{base}[{axis}]") for axis in range(1, 4)])


def thermal_stats(result: Result) -> dict[str, dict[str, float]]:
    candidates = {
        "ExternalShell": "spacecraft.thermalOverall.externalShell.T",
        "BusDeck": "spacecraft.thermalOverall.busDeck.T",
        "OBC_CPU": "spacecraft.dataHandlingSystem.obc.cpuNode.T",
        "OBC_Board": "spacecraft.dataHandlingSystem.obc.boardNode.T",
        "CameraOpticalBench": "spacecraft.payloadSystem.earthCamera.opticalBench.T",
        "CameraFocalBox": "spacecraft.payloadSystem.earthCamera.focalBox.T",
        "SolarArrayPlusX": "spacecraft.electricalPowerSystem.solarArrayPlusX.panelThermalMass.T",
        "SolarArrayPlusY": "spacecraft.electricalPowerSystem.solarArrayPlusY.panelThermalMass.T",
        "SolarArrayMinusX": "spacecraft.electricalPowerSystem.solarArrayMinusX.panelThermalMass.T",
        "WheelY": "spacecraft.gncSystem.wheelY.thermalMass.T",
        "WheelZ": "spacecraft.gncSystem.wheelZ.thermalMass.T",
        "WheelS": "spacecraft.gncSystem.wheelS.thermalMass.T",
    }
    return {label: stats(result.series(name) - 273.15) for label, name in candidates.items() if name in result.index}


def main() -> int:
    OUTPUT.mkdir(parents=True, exist_ok=True)
    result_path = WORK / "CompleteMission_epoch_24h.mat"
    probe_path = WORK / "EnvironmentReaderProbe.mat"
    metadata = json.loads((ROOT / "Resources" / "Data" / "GeneratedEphemeris" / "environment_metadata.json").read_text(encoding="utf-8"))
    result = Result(result_path)
    time = result.series("time")
    position = vector(result, "spacecraft.mechanicsOverall.orbitEnvironment.environment.position")
    velocity = vector(result, "spacecraft.mechanicsOverall.orbitEnvironment.environment.velocity")
    sun = vector(result, "spacecraft.mechanicsOverall.orbitEnvironment.environment.sunVectorBody")

    table = np.loadtxt(ROOT / "Resources" / "Data" / "GeneratedEphemeris" / "environment.txt", comments="#", skiprows=3)
    position_splines = [Akima1DInterpolator(table[:, 0], table[:, axis]) for axis in range(1, 4)]
    expected_position = np.column_stack([spline(time) for spline in position_splines])
    expected_velocity = np.column_stack([spline.derivative()(time) for spline in position_splines])
    modelica_table_position_error = float(np.max(np.linalg.norm(position - expected_position, axis=1)))
    modelica_table_velocity_error = float(np.max(np.linalg.norm(velocity - expected_velocity, axis=1)))

    unique_indices = np.r_[True, np.diff(time) > 0]
    unique_time = time[unique_indices]
    unique_position = position[unique_indices]
    unique_velocity = velocity[unique_indices]
    finite_difference = np.gradient(unique_position, unique_time, axis=0, edge_order=2)
    derivative_error = np.linalg.norm(finite_difference[1:-1] - unique_velocity[1:-1], axis=1)
    radius = np.linalg.norm(position, axis=1)
    sun_norm = np.linalg.norm(sun, axis=1)

    image_complete = result.series("onboardTelemetry.SAT_S3_imagingImageComplete")
    transmitter_status = result.series("spacecraft.communicationSystem.xband.transmissionLogic.transmitterStatus")
    safe_required = result.series("onboardTelemetry.SAT_S3_safeModeRequired")
    ground_contact = result.series("spacecraft.mechanicsOverall.orbitEnvironment.environment.groundContact")
    eclipse = result.series("spacecraft.mechanicsOverall.orbitEnvironment.environment.eclipse")
    soc = result.series("spacecraft.electricalPowerSystem.battery.cells.SOC")
    bus12 = result.series("spacecraft.electricalPowerSystem.pcdu.voltage12.v")
    storage = result.series("spacecraft.dataHandlingSystem.recorder.storedBytes.y")

    wheel_names = {
        "X": "spacecraft.gncSystem.wheelX.speedSensor.w",
        "Y": "spacecraft.gncSystem.wheelY.speed.w",
        "Z": "spacecraft.gncSystem.wheelZ.speed.w",
        "S": "spacecraft.gncSystem.wheelS.speed.w",
    }
    wheel_peaks = {
        label: float(np.max(np.abs(result.series(name))) * 60.0 / (2.0 * math.pi))
        for label, name in wheel_names.items()
    }

    onboard_names = [name for name in result.names if name.startswith("onboardTelemetry.")]
    dynamic_onboard = []
    for name in onboard_names:
        offset = result.index[name]
        if int(result.info[0, offset]) == 2:
            values = result.series(name)
            if np.all(np.isfinite(values)):
                dynamic_onboard.append(name)

    probe = Result(probe_path)
    rotation = np.empty((len(probe.series("time")), 3, 3))
    for row in range(3):
        for column in range(3):
            rotation[:, row, column] = probe.series(f"reader.earthToInertial[{row + 1},{column + 1}]")
    orthogonality = float(np.max(np.linalg.norm(np.transpose(rotation, (0, 2, 1)) @ rotation - np.eye(3), axis=(1, 2))))
    determinant = float(np.max(np.abs(np.linalg.det(rotation) - 1.0)))

    checks = {
        "timeGrid": bool(time[0] == 0.0 and time[-1] == 86400.0 and abs(float(np.median(np.diff(unique_time))) - 1.0) < 1e-12),
        "finiteTrajectory": bool(np.all(np.isfinite(position)) and np.all(np.isfinite(velocity)) and np.min(radius) > 6378137.0),
        "initialState": bool(np.linalg.norm(position[0] - np.asarray(metadata["stateAtSimulationStart"][:3])) < 0.1 and np.linalg.norm(velocity[0] - np.asarray(metadata["stateAtSimulationStart"][3:])) < 0.03),
        "modelicaMatchesGeneratedTable": bool(modelica_table_position_error < 1e-5 and modelica_table_velocity_error < 1e-4),
        "positionVelocityConsistency": bool(float(np.max(derivative_error)) < 0.05),
        "sunNormalized": bool(float(np.max(np.abs(sun_norm - 1.0))) < 1e-10),
        "rotationOrthogonal": bool(orthogonality < 1e-10 and determinant < 1e-10),
        "closedLoopFinite": bool(np.all(np.isfinite(soc)) and np.all(np.isfinite(bus12)) and np.all(np.isfinite(storage))),
        "onboardTelemetryPresent": bool(len(onboard_names) > 0 and len(dynamic_onboard) > 0),
    }

    api_metrics = json.loads((WORK / "complete_24h_api_metrics.json").read_text(encoding="utf-8"))

    report = {
        "status": "PASS" if all(checks.values()) else "FAIL",
        "checks": checks,
        "absoluteTime": {key: metadata[key] for key in ("startUTC", "endUTC", "durationSeconds", "stateEpochUTC", "stateFrame", "stateInputMode")},
        "trajectory": {
            "initialPosition_m": position[0].tolist(),
            "initialVelocity_m_s": velocity[0].tolist(),
            "radius_m": stats(radius),
            "maxModelicaVsTablePositionError_m": modelica_table_position_error,
            "maxModelicaVsTableVelocityError_m_s": modelica_table_velocity_error,
            "maxFiniteDifferenceVelocityError_m_s": float(np.max(derivative_error)),
            "maxOneSecondPositionStep_m": float(np.max(np.linalg.norm(np.diff(unique_position, axis=0), axis=1))),
            "maxOneSecondVelocityStep_m_s": float(np.max(np.linalg.norm(np.diff(unique_velocity, axis=0), axis=1))),
            "maxSunNormError": float(np.max(np.abs(sun_norm - 1.0))),
        },
        "mission": {
            "completedImages": rising_edges(image_complete),
            "realXBandTransmissions": rising_edges(transmitter_status),
            "groundContactWindows": rising_edges(ground_contact),
            "eclipseEntries": rising_edges(eclipse),
            "safeModeRequired": bool(np.max(safe_required) > 0.5),
            "storedBytesFinal": float(storage[-1]),
        },
        "eps": {"batterySOC": stats(soc), "bus12Voltage_V": stats(bus12)},
        "wheelsPeak_rpm": wheel_peaks,
        "thermal_C": thermal_stats(result),
        "onboardTelemetry": {"namedFields": len(onboard_names), "finiteDynamicFields": len(dynamic_onboard)},
        "earthOrientationProbe": {"maxOrthogonalityError": orthogonality, "maxDeterminantError": determinant},
        "performance": {
            "equations": api_metrics["equations"],
            "variables": api_metrics["variables"],
            "trivialEquations": api_metrics["trivialEquations"],
            "integrationAndOutput_s": api_metrics["integrationAndOutput_s"],
            "frontend_s": api_metrics["timeFrontend_s"],
            "backend_s": api_metrics["timeBackend_s"],
            "compile_s": api_metrics["timeCompile_s"],
            "simulationAPI_s": api_metrics["timeSimulationAPI_s"],
            "totalOMC_s": api_metrics["timeTotalOMC_s"],
            "idaSteps": api_metrics["idaSteps"],
            "stateEvents": api_metrics["stateEvents"],
            "timeEvents": api_metrics["timeEvents"],
            "resultFileBytes": result_path.stat().st_size,
            "environmentTableBytes": (ROOT / "Resources" / "Data" / "GeneratedEphemeris" / "environment.txt").stat().st_size,
            "samplesIncludingEvents": int(len(time)),
            "uniqueOutputTimes": int(len(unique_time)),
        },
        "source": str(result_path),
    }
    json_text = json.dumps(report, ensure_ascii=False, indent=2)
    (WORK / "modelica_result_validation.json").write_text(json_text, encoding="utf-8")
    (OUTPUT / "modelica_result_validation.json").write_text(json_text, encoding="utf-8")
    rows = []
    for section in ("mission", "eps", "wheelsPeak_rpm", "earthOrientationProbe", "performance"):
        for key, value in report[section].items():
            rows.append({"Section": section, "Metric": key, "Value": json.dumps(value, ensure_ascii=False) if isinstance(value, dict) else value})
    with (OUTPUT / "modelica_result_summary.csv").open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=["Section", "Metric", "Value"])
        writer.writeheader()
        writer.writerows(rows)
    print(json.dumps({"status": report["status"], "checks": checks, "mission": report["mission"], "performance": report["performance"]}, ensure_ascii=False, indent=2))
    return 0 if report["status"] == "PASS" else 1


if __name__ == "__main__":
    raise SystemExit(main())
