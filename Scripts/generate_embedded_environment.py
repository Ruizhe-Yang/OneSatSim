#!/usr/bin/env python3
"""Convert a generated Modelica text table into the run-time Modelica constant.

This script runs only during UpdateConfig.  The resulting .mo contains every
original decimal token and is the sole environment data source for simulation.
"""

from __future__ import annotations

import argparse
import hashlib
import math
from pathlib import Path

ROOT_NAME = "OneSatSim"
ROWS = 34563
COLUMNS = 16


def render(source: Path) -> tuple[str, str]:
    content = source.read_bytes()
    source_sha = hashlib.sha256(content).hexdigest()
    lines = content.decode("ascii").splitlines()
    declaration = f"double environment({ROWS},{COLUMNS})"
    if declaration not in lines:
        raise ValueError(f"Missing {declaration}")
    raw_rows = [line.split() for line in lines if line and not line.startswith("#") and not line.startswith("double ")]
    if len(raw_rows) != ROWS or any(len(row) != COLUMNS for row in raw_rows):
        raise ValueError(f"Environment shape mismatch: {len(raw_rows)} rows")
    times = []
    for row in raw_rows:
        values = [float(token) for token in row]
        if not all(math.isfinite(value) for value in values):
            raise ValueError("Environment contains nonfinite values")
        times.append(values[0])
    if not all(a < b for a, b in zip(times, times[1:])):
        raise ValueError("Environment time column is not strictly increasing")
    if times[0] > 0 or times[-1] < 86400:
        raise ValueError("Environment lacks guard rows around the nominal interval")
    matrix = ";\n    ".join(",".join(row) for row in raw_rows)
    model = (
        f"within {ROOT_NAME}.Scenarios;\n"
        "record GeneratedEnvironmentData \"Generated nominal GCRS and Earth-orientation table\"\n"
        f"  constant Integer rowCount={ROWS};\n"
        f"  constant Integer columnCount={COLUMNS};\n"
        f"  constant Real firstTime={raw_rows[0][0]};\n"
        f"  constant Real lastTime={raw_rows[-1][0]};\n"
        f"  constant String sourceTableSHA256=\"{source_sha}\";\n"
        f"  constant Real table[{ROWS},{COLUMNS}]=[\n    {matrix}\n  ];\n"
        "  annotation(Documentation(info=\"<html><p>Offline generated from the complete environment table; "
        "columns are time, GCRS position (3), GCRS sun direction (3), and row-major "
        "Earth-to-inertial matrix (9). No runtime file access.</p></html>\"));\n"
        "end GeneratedEnvironmentData;\n"
    )
    return model, source_sha


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("source", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()
    text, source_sha = render(args.source)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    if not args.output.is_file() or args.output.read_text(encoding="utf-8") != text:
        args.output.write_text(text, encoding="utf-8")
    print(f"rows={ROWS} columns={COLUMNS} sha256={source_sha}")


if __name__ == "__main__":
    main()
