"""Independent physical SOC charge ledger for the current nominal result.

The results contract declares PH-09 only. Every saved event row is retained; a
repeated time contributes zero charge. Old study/research gates were removed.
"""

from __future__ import annotations

import json
from pathlib import Path

import numpy as np


class MissingEvidence(Exception):
    pass


def _simpson_charge_prefix(time: np.ndarray, current: np.ndarray,
                           denominator_c: float) -> np.ndarray:
    """Integrate the saved current independently, keeping every event row.

    A repeated timestamp ends one continuous segment and starts the next, so
    an event jump contributes zero charge. Within each strictly increasing
    segment, adjacent triples define a nonuniform quadratic Simpson rule. For
    an even number of samples, average the first/last trapezoid corrections;
    this makes the choice symmetric and deterministic without a SciPy runtime
    dependency. The returned prefix includes every raw sample, including both
    sides of an event.
    """
    time = np.asarray(time, dtype=np.float64)
    current = np.asarray(current, dtype=np.float64)
    if (time.ndim != 1 or current.shape != time.shape or time.size < 2
            or denominator_c <= 0 or not np.isfinite(time).all()
            or not np.isfinite(current).all() or np.any(np.diff(time) < 0)):
        raise MissingEvidence("Invalid raw time/current series for physical SOC charge ledger")

    prefix = np.zeros(time.size, dtype=np.float64)
    boundaries = np.r_[0, np.flatnonzero(np.diff(time) == 0) + 1, time.size]
    offset = 0.0
    for start, stop in zip(boundaries[:-1], boundaries[1:]):
        count = stop - start
        if count == 1:
            prefix[start] = offset
            continue
        x = time[start:stop]
        y = current[start:stop]
        h = np.diff(x)
        trapezoids = h * (y[:-1] + y[1:]) / (2 * denominator_c)
        local = np.zeros(count, dtype=np.float64)
        local[1] = trapezoids[0]
        if count > 2:
            h0, h1 = h[:-1], h[1:]
            width = h0 + h1
            triples = width / (6 * denominator_c) * (
                (2 - h1 / h0) * y[:-2]
                + (width * width / (h0 * h1)) * y[1:-1]
                + (2 - h0 / h1) * y[2:])
            local[2::2] = np.cumsum(triples[::2])
            odd_last = np.arange(3, count, 2)
            if odd_last.size:
                shifted = np.cumsum(triples[1::2])
                local[odd_last] = (
                    local[odd_last - 1] + trapezoids[odd_last - 1]
                    + trapezoids[0] + shifted) / 2
        prefix[start:stop] = offset + local
        offset = float(prefix[stop - 1])
    return prefix


def _row(status: str, reason: str, **evidence) -> dict:
    return {"status": status, "reason": reason, "evidence": evidence}


class Ledger:
    def __init__(self, mat, contract: dict, root: Path):
        self.mat = mat
        self.time = mat.time
        self.spec = {s["semanticId"]: s for s in contract["signals"]}
        self.rules = contract["physics_acceptance"]
        parameter_file = Path(root) / "Scripts" / "Contracts" / "parameters.json"
        parameters = json.loads(parameter_file.read_text(encoding="utf-8"))
        self.component = {s["id"]: s for s in parameters["componentIds"]}

    def tol(self, gate: str, name: str) -> float:
        try:
            return float(self.rules[gate]["tolerance"][name])
        except (KeyError, TypeError, ValueError) as exc:
            raise MissingEvidence(f"results.json {gate}.tolerance.{name} absent") from exc

    def value(self, semantic_id: str) -> np.ndarray:
        item = self.spec.get(semantic_id)
        if item is None:
            raise MissingEvidence(f"Results contract has no semantic ID {semantic_id}")
        path = item["path"]
        if path not in self.mat.lookup:
            raise MissingEvidence(f"MAT lacks {semantic_id}: {path}")
        value = self.mat.read(path)
        if not np.isfinite(value).all():
            raise MissingEvidence(f"MAT has nonfinite {semantic_id}: {path}")
        if item["timeKind"] == "parameter":
            if value.size not in (1, 2) or (value.size == 2 and value[0] != value[1]):
                raise MissingEvidence(f"Parameter {semantic_id} has nonconstant endpoints")
            return np.full(self.time.size, float(value[0]))
        if value.size != self.time.size:
            raise MissingEvidence(f"{semantic_id} length {value.size}, time length {self.time.size}")
        return value

    def parameter(self, suffix: str) -> float:
        key = "SpacecraftDesignConfig." + suffix
        try:
            item = self.component[key]
            if item["status"] == "UNMAPPED":
                raise MissingEvidence(f"Parameter {key} is unmapped")
            return float(item["generatedValue"])
        except (KeyError, TypeError, ValueError) as exc:
            raise MissingEvidence(f"Parameter contract lacks generated value {key}") from exc

def _ph09(d: Ledger) -> dict:
    """Check physical stack SOC against independent measured-charge integration."""
    gate = "PH-09"
    soc = d.value("BAT.SOC")
    cell_i = d.value("BAT.I_CELL")
    n_parallel = d.parameter("eps.battery.ParallelCellCount")
    q_nom = d.parameter("eps.battery.CellCapacity_Ah")
    if d.parameter("eps.battery.UseEOLCapacity"):
        q_nom *= d.parameter("eps.battery.EOLCapacityFactor")
    if n_parallel <= 0 or q_nom <= 0:
        raise MissingEvidence("Battery cell count and charge capacity must be positive")
    denominator_c = n_parallel * q_nom
    charge_prefix = _simpson_charge_prefix(d.time, cell_i, denominator_c)
    reference = soc[0] + charge_prefix
    residual = soc - reference
    final_residual = float(residual[-1])
    # Preserve the former adjacent-endpoint rule as a disclosed diagnostic.
    # Its 1 s output-grid bias was measured independently on a finer trajectory.
    trapezoid_delta = np.diff(d.time) * (cell_i[:-1] + cell_i[1:]) / (2 * denominator_c)
    trapezoid_reference = soc[0] + np.r_[0.0, np.cumsum(trapezoid_delta)]
    trapezoid_residual = soc - trapezoid_reference
    passed = abs(final_residual) <= d.tol(gate, "absoluteSOC")
    return _row("PASS" if passed else "FAIL", "Independent physical stack SOC charge ledger",
                socDelta=float(soc[-1] - soc[0]), predictedSOCDelta=float(charge_prefix[-1]),
                socResidual=final_residual, maxAbsSOCResidual=float(np.max(np.abs(residual))),
                socTolerance=d.tol(gate, "absoluteSOC"), parallelCellCount=n_parallel,
                cellChargeCapacityC=q_nom, duplicateEventRows=int(np.count_nonzero(np.diff(d.time) == 0)),
                integrationMethod="nonuniform segmentwise Simpson; symmetric end trapezoid averaging",
                adjacentTrapezoidPredictedSOCDelta=float(np.sum(trapezoid_delta)),
                adjacentTrapezoidSOCResidual=float(trapezoid_residual[-1]),
                adjacentTrapezoidMaxAbsSOCResidual=float(np.max(np.abs(trapezoid_residual))))

def audit_physics(mat, contract: dict, resolved_config: dict, root: Path) -> dict[str, dict]:
    """Evaluate only the currently declared independent physical ledger."""
    try:
        ledger = Ledger(mat, contract, root)
    except Exception as exc:
        return {key: _row("NOT_CHECKED", f"Cannot initialize charge ledger: {exc}")
                for key in contract["physics_acceptance"]}
    results = {}
    for key, spec in contract["physics_acceptance"].items():
        if key != "PH-09":
            row = _row("NOT_CHECKED", "No evaluator for undeclared v1.1.0 physics gate")
        elif mat.dynamic.dtype != np.dtype("float64") or mat.parameters.dtype != np.dtype("float64"):
            row = _row("NOT_CHECKED", "Physical charge ledger requires float64 MAT data_1 and data_2")
        else:
            try:
                row = _ph09(ledger)
            except MissingEvidence as exc:
                row = _row("NOT_CHECKED", str(exc))
            except Exception as exc:
                row = _row("FAIL", f"Charge ledger failed: {type(exc).__name__}: {exc}")
        row["formula"] = spec.get("formula")
        row["tolerance"] = spec.get("tolerance")
        row["scenario"] = spec.get("scenario")
        results[key] = row
    return results
