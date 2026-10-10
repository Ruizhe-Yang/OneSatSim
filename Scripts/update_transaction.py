#!/usr/bin/env python3
"""Stage and atomically publish one coherent DesignConfig generation."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import shutil
import subprocess
import sys
import tempfile
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PUBLIC = ROOT.parent
WORK = PUBLIC / "work" / "MOSAIC-12UCubeSat" / "config-transactions"
CONFIG = PUBLIC / "config" / "MOSAIC-12UCubeSat" / "latest"
FILES = (
    "DesignConfig.xlsx",
    "Scenarios/GeneratedSpacecraftDesignConfig.mo",
    "Scenarios/GeneratedScenario.mo",
    "Scenarios/GeneratedEnvironmentData.mo",
    "Scenarios/GeneratedMassProperties.mo",
    "Simulation/CompleteMission.mo",
    "Scripts/ConfigSupport/generated_simulation_flags.txt",
    "Scripts/ConfigSupport/current_snapshot.json",
    "Scripts/ConfigSupport/generation_manifest.json",
)


def digest(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for block in iter(lambda: f.read(1024 * 1024), b""):
            h.update(block)
    return h.hexdigest()


def replace(source: Path, target: Path) -> None:
    target.parent.mkdir(parents=True, exist_ok=True)
    temp = target.with_name(target.name + ".transaction-tmp")
    shutil.copy2(source, temp)
    os.replace(temp, target)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--failure-after", type=int, default=-1, help=argparse.SUPPRESS)
    args = parser.parse_args()
    WORK.mkdir(parents=True, exist_ok=True)
    lock = WORK / "update.lock"
    try:
        fd = os.open(lock, os.O_CREAT | os.O_EXCL | os.O_WRONLY)
    except FileExistsError:
        raise SystemExit("Another configuration transaction is active; inspect work/MOSAIC-12UCubeSat/config-transactions/update.lock")
    os.write(fd, f"pid={os.getpid()}\n".encode())
    os.close(fd)
    try:
        initial_workbook_sha256 = digest(ROOT / "DesignConfig.xlsx")
        with tempfile.TemporaryDirectory(prefix="stage-", dir=WORK) as staging_name:
            stage = Path(staging_name)
            staged_root = stage / "OneSatSim"
            shutil.copytree(ROOT, staged_root, ignore=shutil.ignore_patterns("__pycache__", "*.pyc"))
            command = [sys.executable, str(staged_root / "Scripts" / "update_config.py")]
            result = subprocess.run(command, cwd=staged_root, text=True, encoding="utf-8", errors="replace", stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
            print(result.stdout.encode(sys.stdout.encoding or "utf-8", errors="replace").decode(sys.stdout.encoding or "utf-8"), end="")
            if result.returncode:
                raise RuntimeError("Staged configuration validation/generation failed; live project was not changed")
            staged_config = stage / "config" / "MOSAIC-12UCubeSat" / "latest"
            snapshot_path = staged_config / "resolved_parameter_snapshot.json"
            snapshot = json.loads(snapshot_path.read_text(encoding="utf-8"))
            manifest = {
                "generationUTC": datetime.now(timezone.utc).isoformat(),
                "entryModel": "OneSatSim.Simulation.CompleteMission",
                "workbookSHA256": digest(staged_root / "DesignConfig.xlsx"),
                "defaultRecordSHA256": digest(staged_root / "Scenarios" / "DefaultSpacecraftDesignConfig.mo"),
                "generatorSHA256": digest(staged_root / "Scripts" / "update_config.py"),
                "schemaSHA256": digest(staged_root / "Scripts" / "parameter_schema.py"),
                "unitRulesSHA256": digest(staged_root / "Scripts" / "parameter_units.py"),
                "ephemerisGeneratorSHA256": digest(staged_root / "Scripts" / "prepare_ephemeris.py"),
                "embeddedGeneratorSHA256": digest(staged_root / "Scripts" / "generate_embedded_environment.py"),
                "massGeneratorSHA256": digest(staged_root / "Scripts" / "generate_mass_properties.py"),
                "transactionSHA256": digest(staged_root / "Scripts" / "update_transaction.py"),
                "generated": {rel: digest(staged_root / rel) for rel in FILES if (staged_root / rel).is_file() and not rel.endswith(("current_snapshot.json", "generation_manifest.json"))},
                "parameterCount": len(snapshot["parameters"]),
                "environmentTableSHA256": json.loads((staged_config / "environment_metadata.json").read_text(encoding="utf-8"))["tableSHA256"],
            }
            support_dir = staged_root / "Scripts" / "ConfigSupport"
            support_dir.mkdir(parents=True, exist_ok=True)
            (support_dir / "current_snapshot.json").write_text(json.dumps(snapshot, ensure_ascii=False, indent=2), encoding="utf-8")
            (support_dir / "generation_manifest.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
            if digest(ROOT / "DesignConfig.xlsx") != initial_workbook_sha256:
                raise RuntimeError("DesignConfig.xlsx changed during generation; live project was not changed")
            with tempfile.TemporaryDirectory(prefix="backup-", dir=WORK) as backup_name:
                backup = Path(backup_name)
                old = {}
                for rel in FILES:
                    destination = ROOT / rel
                    old[rel] = destination.is_file()
                    if old[rel]:
                        target = backup / "project" / rel
                        target.parent.mkdir(parents=True, exist_ok=True)
                        shutil.copy2(destination, target)
                old_config = CONFIG.exists()
                if old_config:
                    shutil.copytree(CONFIG, backup / "config")
                try:
                    for index, rel in enumerate(FILES, 1):
                        source = staged_root / rel
                        if source.is_file():
                            replace(source, ROOT / rel)
                        elif (ROOT / rel).exists():
                            (ROOT / rel).unlink()
                        if index == args.failure_after:
                            raise RuntimeError(f"Injected failure after commit item {index}")
                    if CONFIG.exists():
                        shutil.rmtree(CONFIG)
                    shutil.copytree(staged_config, CONFIG)
                except Exception:
                    for rel in FILES:
                        destination = ROOT / rel
                        if old[rel]:
                            replace(backup / "project" / rel, destination)
                        elif destination.exists():
                            destination.unlink()
                    if CONFIG.exists():
                        shutil.rmtree(CONFIG)
                    if old_config:
                        shutil.copytree(backup / "config", CONFIG)
                    raise
            print(f"[SUCCESS] transaction committed; workbook SHA256={manifest['workbookSHA256']}")
            print(f"[SUCCESS] snapshot={ROOT / 'Scripts/ConfigSupport/current_snapshot.json'}")
        return 0
    finally:
        lock.unlink(missing_ok=True)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except SystemExit:
        raise
    except Exception as exc:
        print(f"[ERROR] {exc}", file=sys.stderr)
        raise SystemExit(1)
