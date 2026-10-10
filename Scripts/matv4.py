"""Bounded-memory OpenModelica MAT v4 reader, including aliases and event rows.

The layout follows the OpenModelica 1.25.5 MAT v4 technical description.
This module does not smooth, deduplicate, or interpolate the recorded samples.
"""

from __future__ import annotations

import os
import struct
from pathlib import Path

import numpy as np

_TYPES = {0: "f8", 1: "f4", 2: "i4", 3: "i2", 4: "u2", 5: "u1"}
_REQUIRED = ("Aclass", "name", "description", "dataInfo", "data_1", "data_2")


def _decode_chars(matrix: np.ndarray) -> list[str]:
    if matrix.dtype.kind not in "iu":
        raise ValueError("MAT character table is not integer encoded")
    return [bytes(matrix[i, :].astype(np.uint8)).rstrip(b"\0 ").decode("utf-8", "replace")
            for i in range(matrix.shape[0])]


class MatV4:
    def __init__(self, path: Path):
        self.path = Path(path)
        size = self.path.stat().st_size
        self.matrices: dict[str, np.ndarray] = {}
        self.headers: dict[str, dict] = {}
        with self.path.open("rb") as stream:
            position = 0
            while position < size:
                stream.seek(position)
                raw = stream.read(20)
                if len(raw) != 20:
                    raise ValueError(f"Truncated MAT header at byte {position}")
                little = struct.unpack("<5i", raw)
                big = struct.unpack(">5i", raw)
                if self._plausible(little):
                    endian, header = "<", little
                elif self._plausible(big):
                    endian, header = ">", big
                else:
                    raise ValueError(f"Invalid MAT v4 matrix header at byte {position}")
                mopt, rows, cols, imaginary, name_length = header
                machine, precision, matrix_type = mopt // 1000, (mopt // 10) % 10, mopt % 10
                if machine not in (0, 1) or matrix_type not in (0, 1) or imaginary:
                    raise ValueError(f"Unsupported MAT v4 matrix type at byte {position}: {header}")
                name_raw = stream.read(name_length)
                if len(name_raw) != name_length:
                    raise ValueError("Truncated MAT variable name")
                name = name_raw.rstrip(b"\0").decode("ascii")
                if not name or name in self.matrices:
                    raise ValueError(f"Missing or duplicate MAT variable: {name!r}")
                dtype = np.dtype(endian + _TYPES[precision])
                data_start = position + 20 + name_length
                data_end = data_start + rows * cols * dtype.itemsize
                if data_end > size:
                    raise ValueError(f"Truncated MAT matrix {name}: {data_end} > {size}")
                self.matrices[name] = np.memmap(self.path, dtype=dtype, mode="r", offset=data_start,
                                                 shape=(rows, cols), order="F")
                self.headers[name] = {"shapeOnDisk": [rows, cols], "dtype": str(dtype),
                                      "offset": data_start, "matrixType": matrix_type}
                position = data_end
        if position != size or any(name not in self.matrices for name in _REQUIRED):
            raise ValueError("MAT v4 matrix set or file length is incomplete")
        aclass = self.matrices["Aclass"]
        row_strings = _decode_chars(aclass)
        col_strings = _decode_chars(aclass.T)
        if row_strings and row_strings[0] == "Atrajectory":
            class_rows = row_strings
        elif col_strings and col_strings[0] == "Atrajectory":
            class_rows = col_strings
        else:
            raise ValueError("MAT Aclass is not an OpenModelica trajectory")
        if len(class_rows) < 4 or class_rows[3] not in ("binTrans", "binNormal"):
            raise ValueError(f"Unsupported MAT Aclass: {class_rows}")
        self.orientation = class_rows[3]
        # Normalize metadata to (variable, field) and trajectory matrices to
        # (storage row, time). OpenModelica's binTrans result is written with
        # metadata transposed but with data_2 already in the row/time layout.
        metadata_transpose = self.orientation == "binTrans"
        self.layout = {key: (value.T if metadata_transpose and key in
                              ("name", "description", "dataInfo") else value)
                       for key, value in self.matrices.items()}
        self.names = _decode_chars(self.layout["name"])
        self.descriptions = _decode_chars(self.layout["description"])
        self.info = self.layout["dataInfo"]
        self.parameters = self.layout["data_1"] if metadata_transpose else self.layout["data_1"].T
        self.dynamic = self.layout["data_2"] if metadata_transpose else self.layout["data_2"].T
        if self.info.shape != (len(self.names), 4):
            raise ValueError(f"dataInfo shape {self.info.shape} does not match {len(self.names)} names")
        if len(self.descriptions) != len(self.names) or len(set(self.names)) != len(self.names):
            raise ValueError("Description count mismatch or duplicate MAT names")
        max_parameter_index = max((abs(int(row[1])) for row in self.info if int(row[0]) == 1), default=0)
        max_dynamic_index = max((abs(int(row[1])) for row in self.info if int(row[0]) in (0, 2)), default=0)
        if max_parameter_index > self.parameters.shape[0] or self.parameters.shape[1] not in (1, 2):
            raise ValueError("data_1 orientation/index inconsistent with Aclass")
        if max_dynamic_index > self.dynamic.shape[0]:
            raise ValueError("data_2 orientation/index inconsistent with Aclass")
        if self.dynamic.ndim != 2 or self.dynamic.shape[1] < 2:
            raise ValueError("data_2 has no trajectory")
        if self.parameters.ndim != 2 or self.parameters.shape[1] not in (1, 2):
            raise ValueError("data_1 must have one or two time columns")
        self.lookup = {name: i for i, name in enumerate(self.names)}
        if "time" not in self.lookup:
            raise ValueError("MAT has no time variable")
        ti = self.info[self.lookup["time"]]
        # Native filterSimulationResults files encode time as dataInfo group 2;
        # unfiltered OpenModelica files use group 0 for the same data_2 row.
        if int(ti[0]) not in (0, 2) or abs(int(ti[1])) != 1:
            raise ValueError(f"Invalid MAT time index: {ti.tolist()}")
        for i, row in enumerate(self.info):
            group, signed_index = int(row[0]), int(row[1])
            if group not in (0, 1, 2) or signed_index == 0:
                raise ValueError(f"Invalid dataInfo entry for {self.names[i]}: {row.tolist()}")
            bound = self.parameters.shape[0] if group == 1 else self.dynamic.shape[0]
            if abs(signed_index) > bound:
                raise ValueError(f"Out of range dataInfo entry for {self.names[i]}")

    @staticmethod
    def _plausible(header: tuple[int, ...]) -> bool:
        mopt, rows, cols, imaginary, name_length = header
        return (0 <= mopt < 2000 and rows > 0 and cols > 0 and imaginary in (0, 1)
                and 1 <= name_length <= 256 and (mopt // 10) % 10 in _TYPES)

    @property
    def time(self) -> np.ndarray:
        return np.asarray(self.dynamic[0, :], dtype=np.float64)

    def storage(self, name: str) -> dict:
        group, index = (int(self.info[self.lookup[name], i]) for i in (0, 1))
        return {"group": group, "signedIndex": index, "row": abs(index) - 1,
                "negatedAlias": index < 0}

    def read(self, name: str, *, allow_parameter_end_change: bool = False) -> np.ndarray:
        if name not in self.lookup:
            raise KeyError(name)
        location = self.storage(name)
        sign = -1 if location["negatedAlias"] else 1
        if location["group"] in (0, 2):
            return sign * np.asarray(self.dynamic[location["row"], :], dtype=np.float64)
        pair = np.asarray(self.parameters[location["row"], :], dtype=np.float64)
        if pair.size == 2 and not allow_parameter_end_change and not np.array_equal(pair[:1], pair[1:]):
            raise ValueError(f"Parameter {name} has distinct start/end values: {pair.tolist()}")
        return sign * pair

    def summary(self) -> dict:
        time = self.time
        if not np.isfinite(time).all() or np.any(np.diff(time) < 0):
            raise ValueError("Time is nonfinite or decreases")
        unique = np.count_nonzero(np.r_[True, time[1:] != time[:-1]])
        storage_rows = {abs(int(row[1])) for row in self.info if int(row[0]) in (0, 2)}
        return {"format": "MAT v4", "orientation": self.orientation,
                "names": len(self.names), "independentDynamicRows": len(storage_rows),
                "dynamicRowsOnDisk": int(self.dynamic.shape[0]), "timePoints": int(time.size),
                "uniqueTimePoints": int(unique), "duplicateEventPoints": int(time.size - unique),
                "start": float(time[0]), "stop": float(time[-1]),
                "maximumPositiveStep": float(np.max(np.diff(time))),
                "dynamicDType": str(self.dynamic.dtype), "parameterDType": str(self.parameters.dtype),
                "matrices": {key: {"shape": list(value.shape), "dtype": str(value.dtype)}
                             for key, value in self.matrices.items()}}


def require_grid(time: np.ndarray, start: float, stop: float, interval: float,
                 tolerance: float = 1e-6) -> dict:
    if interval <= 0 or stop < start:
        raise ValueError("Invalid requested grid")
    if not np.isfinite(time).all() or np.any(np.diff(time) < -tolerance):
        raise ValueError("Time decreases or contains nonfinite values")
    if abs(time[0] - start) > tolerance or abs(time[-1] - stop) > tolerance:
        raise ValueError(f"Incomplete time span {time[0]}..{time[-1]}, expected {start}..{stop}")
    expected = np.linspace(start, stop, round((stop - start) / interval) + 1)
    if abs(expected[-1] - stop) > tolerance:
        raise ValueError("Stop is not aligned to regular output grid")
    positions = np.searchsorted(time, expected, side="left")
    positions = np.minimum(positions, time.size - 1)
    left = np.maximum(positions - 1, 0)
    error = np.minimum(np.abs(time[positions] - expected), np.abs(time[left] - expected))
    if np.max(error) > tolerance:
        bad = int(np.argmax(error))
        raise ValueError(f"Missing regular grid point {expected[bad]} s; nearest error {error[bad]} s")
    positive = np.diff(time)
    if np.max(positive) > interval + tolerance:
        raise ValueError(f"Gap {np.max(positive)} s exceeds interval {interval} s")
    unique, _counts = np.unique(time, return_counts=True)
    offsets = (unique - start) / interval
    off_grid = np.abs(offsets - np.rint(offsets)) * interval > tolerance
    # Event solvers may emit single off-grid samples. A complete, uniformly
    # finer lattice is instead evidence that the runtime ignored the declared
    # output interval (for example 1 s output claimed as a 2 s run).
    off_grid_times = unique[off_grid]
    if off_grid_times.size >= max(10, 0.75 * expected.size):
        steps = np.diff(unique)
        median_step = float(np.median(steps))
        if (median_step < interval - tolerance and
                np.mean(np.abs(steps - median_step) <= tolerance) >= 0.95):
            raise ValueError(f"Systematic {median_step:g} s output lattice contradicts requested {interval:g} s interval")
    return {"regularGridPoints": int(expected.size), "maxGridError": float(np.max(error)),
            "maxAdjacentStep": float(np.max(positive)),
            "offGridEventTimes": int(np.sum(off_grid))}
