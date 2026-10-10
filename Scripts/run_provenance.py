"""Candidate source/config/resource inventory and drift detection."""

from __future__ import annotations

import hashlib
import json
from pathlib import Path


def sha256(path: Path) -> str:
    value = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(8 * 1024 * 1024), b""):
            value.update(block)
    return value.hexdigest()


def canonical_hash(value) -> str:
    return hashlib.sha256(json.dumps(value, ensure_ascii=False, sort_keys=True,
                                     separators=(",", ":")).encode("utf-8")).hexdigest()


def inventory(root: Path, config: dict, *, omc: Path | None = None,
              msl_package: Path | None = None) -> dict:
    root = root.resolve()
    groups = {"modelica": [], "configuration": [], "toolsAndContracts": []}
    for path in root.rglob("*"):
        if not path.is_file() or "__pycache__" in path.parts or path.suffix == ".pyc":
            continue
        rel = path.relative_to(root).as_posix()
        if path.suffix == ".mo" or path.name == "package.order":
            group = "modelica"
        elif rel == "DesignConfig.xlsx" or rel.startswith("Scripts/Inputs/") or rel.startswith("Scripts/ConfigSupport/"):
            group = "configuration"
        elif rel.startswith("Scripts/") or rel in ("RunSimulation.bat", "UpdateConfig.bat"):
            group = "toolsAndContracts"
        else:
            continue
        groups[group].append({"path": rel, "sha256": sha256(path), "bytes": path.stat().st_size})
    for files in groups.values():
        files.sort(key=lambda item: item["path"])
    hashes = {group: canonical_hash(files) for group, files in groups.items()}
    runtime = {}
    if omc is not None:
        runtime["omcExecutable"] = {"path": str(omc.resolve()), "sha256": sha256(omc)}
    if msl_package is not None:
        runtime["mslPackage"] = {"path": str(msl_package.resolve()), "sha256": sha256(msl_package)}
    hashes["resolvedRunConfig"] = canonical_hash(config)
    hashes["runtime"] = canonical_hash(runtime)
    fingerprint = canonical_hash(hashes)
    return {"schemaVersion": "1.0", "root": str(root), "files": groups,
            "groupSHA256": hashes, "runtime": runtime,
            "CandidateId": "MOSAIC12U-" + fingerprint[:16], "BuildFingerprint": fingerprint}


def compare(expected: dict, current: dict) -> list[str]:
    differences = []
    for group in ("modelica", "configuration", "toolsAndContracts"):
        old = {item["path"]: item["sha256"] for item in expected["files"][group]}
        new = {item["path"]: item["sha256"] for item in current["files"][group]}
        for path in sorted(set(old) | set(new)):
            if old.get(path) != new.get(path):
                differences.append(f"{group}:{path}: {old.get(path)} -> {new.get(path)}")
    if expected["groupSHA256"].get("resolvedRunConfig") != current["groupSHA256"].get("resolvedRunConfig"):
        differences.append("effective run configuration changed")
    if expected["groupSHA256"].get("runtime") != current["groupSHA256"].get("runtime"):
        differences.append("OMC/MSL runtime identity changed")
    return differences
