#!/usr/bin/env python3
"""Project-local static gate and fresh OpenModelica nominal run entry point."""

from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

from audit_results import load_contract
from check_project import check

ROOT = Path(__file__).resolve().parents[1]
RESULTS = ROOT.parent / "results" / "MOSAIC-12UCubeSat"
WORK = ROOT.parent / "work" / "MOSAIC-12UCubeSat" / "v1.1.4"


def set_result(checks: dict, key: str, passing: bool, evidence: str) -> None:
    if key not in checks:
        raise KeyError(f"Current results contract lacks {key}")
    checks[key] = {"required": True, "status": "PASS" if passing else "FAIL",
                   "evidence": evidence}


def run_id_from_output(output: str) -> str | None:
    match = re.search(r"\bRunId=(MOSAIC12U-v1\.1\.4-[A-Za-z0-9_-]+)(?=[:\s]|$)", output)
    return match[1] if match else None


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-kind", choices=("NOMINAL_FULL", "LOCAL_TEST", "SMOKE", "DIAGNOSTIC"),
                        default="NOMINAL_FULL")
    parser.add_argument("--stop", type=float)
    parser.add_argument("--output-interval", type=float)
    parser.add_argument("--reason")
    parser.add_argument("--build-timeout", type=int, default=900)
    parser.add_argument("--simulation-timeout", type=int, default=3600)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()

    contract = load_contract()
    checks = json.loads(json.dumps(contract["requiredChecks"]))
    static = check(ROOT)
    preflight = WORK / "preflight"
    preflight.mkdir(parents=True, exist_ok=True)
    static_path = preflight / (datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ") +
                               "_project_static.json")
    static_path.write_text(json.dumps(static, ensure_ascii=False, indent=2), encoding="utf-8")
    sc = static["checks"]
    groups = {
        "P-IDENTITY": ("ROOT_IDENTITY", "FIVE_PACKAGES", "PACKAGE_ORDER", "TOP_LEVEL"),
        "P-CONFIG": ("GENERATED_GROUP", "FLAGS_SINGLE_SOURCE", "PURE_MO", "PARAMETER_CONTRACT"),
        "P-CONTRACTS": ("CONTRACT_FILES",),
        "P-STRUCTURE": ("NO_EXTERNAL_REQUEST", "ENVIRONMENT_PORT", "DIAGRAM_TOPOLOGY"),
        "P-DASHBOARD": ("DASHBOARD_SAVED",),
    }
    for gate, names in groups.items():
        set_result(checks, gate, all(sc.get(name, {}).get("status") == "PASS" for name in names),
                   str(static_path))
    if args.run_kind == "NOMINAL_FULL" and static["status"] != "PASS":
        failed = [key for key, value in sc.items() if value["status"] != "PASS"]
        print(f"[FAIL] PRECHECK: {failed}; evidence={static_path}", file=sys.stderr)
        return 1

    command = [sys.executable, str(ROOT / "Scripts/run_openmodelica.py"),
               "--run-kind", args.run_kind, "--build-timeout", str(args.build_timeout),
               "--simulation-timeout", str(args.simulation_timeout)]
    for option, value in (("--stop", args.stop), ("--output-interval", args.output_interval),
                          ("--reason", args.reason), ("--output", args.output)):
        if value is not None:
            command.extend((option, str(value)))
    process = subprocess.run(command, text=True, stdout=subprocess.PIPE,
                             stderr=subprocess.STDOUT)
    print(process.stdout, end="")
    run_id = run_id_from_output(process.stdout)
    if not run_id:
        return process.returncode or 1
    folder = RESULTS / run_id
    manifest_path = folder / "RunManifest.json"
    if not manifest_path.is_file():
        print("[FAIL] Run manifest missing", file=sys.stderr)
        return 1
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    audit_path = folder / "ResultAudit.json"
    audited = json.loads(audit_path.read_text(encoding="utf-8")) if audit_path.is_file() else {}
    audit_checks = audited.get("checks", {})
    integrity_names = ("MAT_FORMAT", "RESULT_PRECISION", "TIME_GRID",
                       "REQUIRED_SIGNALS", "SIGNAL_LIMITS")
    set_result(checks, "P-MAT", all(audit_checks.get(name, {}).get("status") == "PASS"
                                    for name in integrity_names), str(audit_path))
    set_result(checks, "P-RESULT-SIZE",
               audit_checks.get("RESULT_SIZE", {}).get("status") == "PASS", str(audit_path))
    mission = audited.get("mission_acceptance", {})
    set_result(checks, "V10-MISSION", mission.get("status") == "PASS", str(audit_path))
    physics = audited.get("physics_acceptance", {})
    set_result(checks, "PH-09", physics.get("PH-09", {}).get("status") == "PASS", str(audit_path))
    runner_passed = process.returncode == 0 and manifest.get("status") == "RUN_AND_RESULT_AUDIT_PASS"
    formal = args.run_kind == "NOMINAL_FULL" and runner_passed and all(
        item["status"] == "PASS" for item in checks.values())
    result = ("SUCCESS / v1.1.4 NOMINAL" if formal else
              ("SHORT_RUN_PASS" if args.run_kind != "NOMINAL_FULL" and runner_passed else
               "FAILED / CANDIDATE_RETAINED"))
    acceptance = {"schemaVersion": "1.1.1", "RunId": run_id, "runKind": args.run_kind,
                  "result": result, "runnerExitCode": process.returncode,
                  "runnerStatusFromManifest": manifest.get("status"),
                  "auditEvidence": str(audit_path), "staticEvidence": str(static_path),
                  "requiredChecks": checks}
    (folder / "Acceptance.json").write_text(json.dumps(acceptance, ensure_ascii=False, indent=2),
                                             encoding="utf-8")
    return 0 if formal or (args.run_kind != "NOMINAL_FULL" and runner_passed) else 1


if __name__ == "__main__":
    raise SystemExit(main())
