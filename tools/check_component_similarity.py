#!/usr/bin/env python3
"""Flag suspiciously duplicated white-box topologies across hardware families."""
from __future__ import annotations

import csv
import itertools
import re
import sys
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
COMP = ROOT / "Components"
OUT = ROOT / "outputs" / "config" / "latest" / "COMPONENT_SIMILARITY_AUDIT.csv"

ALLOWED_FAMILIES = [
    {"ReactionWheelXUnit", "ReactionWheelYUnit", "ReactionWheelZUnit", "ReactionWheelSUnit"},
    {"StarTrackerYUnit", "StarTrackerZUnit"},
    {"BodyMountedSolarArrayPlusXUnit", "BodyMountedSolarArrayPlusYUnit", "BodyMountedSolarArrayMinusXUnit"},
]


def allowed(a: str, b: str) -> bool:
    return any(a in group and b in group for group in ALLOWED_FAMILIES)


def signature(path: Path) -> set[str]:
    text = path.read_text(encoding="utf-8-sig")
    before = text.split("equation", 1)[0]
    types = re.findall(r"^\s*((?:Modelica|Foundation)\.[A-Za-z0-9_.]+)\s+\w+", before, re.M)
    types = [t for t in types if ".Interfaces." not in t]
    local_type: dict[str, str] = {}
    for typ, name in re.findall(r"^\s*((?:Modelica|Foundation)\.[A-Za-z0-9_.]+)\s+(\w+)", before, re.M):
        local_type[name] = typ
    edges: Counter[str] = Counter()
    for left, right in re.findall(r"connect\s*\(\s*([\w\[\].:]+)\s*,\s*([\w\[\].:]+)\s*\)", text):
        la = local_type.get(re.split(r"[.\[]", left)[0], "PORT")
        rb = local_type.get(re.split(r"[.\[]", right)[0], "PORT")
        edges["EDGE:" + "<->".join(sorted((la, rb)))] += 1
    sig = {f"TYPE:{typ}:{count}" for typ, count in Counter(types).items()}
    sig |= {f"{edge}:{count}" for edge, count in edges.items()}
    return sig


def jaccard(a: set[str], b: set[str]) -> float:
    return len(a & b) / max(1, len(a | b))


def main() -> int:
    files = sorted(p for p in COMP.glob("*.mo") if p.name != "package.mo")
    signatures = {p.stem: signature(p) for p in files}
    rows = []
    failures = []
    for a, b in itertools.combinations(signatures, 2):
        score = jaccard(signatures[a], signatures[b])
        review = score > 0.90
        family_allowed = allowed(a, b)
        result = "ALLOWED_SAME_HARDWARE_FAMILY" if review and family_allowed else ("FAIL_REVIEW" if review else "PASS")
        rows.append({"component_a": a, "component_b": b, "similarity": round(score, 4), "result": result})
        if review and not family_allowed:
            failures.append((a, b, score))
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=["component_a", "component_b", "similarity", "result"])
        writer.writeheader()
        writer.writerows(rows)
    if failures:
        print("COMPONENT SIMILARITY CHECK FAIL")
        for a, b, score in failures:
            print(f"{a} vs {b}: {score:.3f}")
        return 1
    highest = sorted(rows, key=lambda r: r["similarity"], reverse=True)[:5]
    print(f"COMPONENT SIMILARITY CHECK PASS: {len(files)} components, {len(rows)} pairs; audit={OUT}")
    for row in highest:
        print(row)
    return 0


if __name__ == "__main__":
    sys.exit(main())
