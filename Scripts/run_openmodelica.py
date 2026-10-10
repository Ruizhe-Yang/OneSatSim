#!/usr/bin/env python3
"""Fresh OpenModelica CLI build, run, provenance, and MAT audit."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import random
import re
import shutil
import signal
import subprocess
import sys
import time
from datetime import datetime, timezone
from pathlib import Path

import numpy as np
import psutil

from audit_results import audit, load_contract
from matv4 import MatV4
from run_config import resolve
from run_provenance import compare, inventory, sha256

ROOT = Path(__file__).resolve().parents[1]
PUBLIC = ROOT.parent
WORK = PUBLIC / "work" / "MOSAIC-12UCubeSat" / "v1.1.4"
RESULTS = PUBLIC / "results" / "MOSAIC-12UCubeSat"


def source_files(root: Path) -> list[Path]:
    packages = sorted((p for p in root.rglob("package.mo") if p != root / "package.mo"),
                      key=lambda p: (len(p.relative_to(root).parts), p.as_posix().lower()))
    models = sorted((p for p in root.rglob("*.mo") if p.name != "package.mo"),
                    key=lambda p: p.as_posix().lower())
    return [root / "package.mo", *packages, *models]


def mos_string(value: str | Path) -> str:
    return '"' + str(value).replace("\\", "/").replace('"', '\\"') + '"'


def mos_regex(value: str) -> str:
    # Modelica string syntax consumes one escape layer. Preserve regex
    # backslashes rather than passing them through the filesystem path helper.
    return '"' + value.replace("\\", "\\\\").replace('"', '\\"') + '"'


def filter_regex(contract: dict) -> str:
    paths = [signal["path"] for signal in contract["signals"] if signal["save"]]
    if "time" not in paths:
        paths.append("time")
    if len(paths) != len(set(paths)):
        raise ValueError("Duplicate saved MAT paths in results.json")
    return "^(" + "|".join(re.escape(path) for path in sorted(paths)) + ")$"


def locate_omc() -> Path:
    for candidate in (os.environ.get("OMC_EXE"), shutil.which("omc"),
                      r"F:\OpenModelica1.25.5-64bit\bin\omc.exe"):
        if candidate and Path(candidate).is_file():
            return Path(candidate).resolve()
    raise FileNotFoundError("OpenModelica CLI not found; set OMC_EXE")


def tool_environment(omc: Path) -> tuple[dict[str, str], dict]:
    env = os.environ.copy()
    additions = []
    tools = {}
    if os.name == "nt":
        tool_root = omc.parent.parent / "tools"
        if tool_root.is_dir():
            for name in ("gcc.exe", "mingw32-make.exe", "sh.exe"):
                matches = sorted(tool_root.rglob(name), key=lambda p: len(p.parts))
                if matches:
                    path = matches[0]
                    if str(path.parent) not in additions:
                        additions.append(str(path.parent))
                    tools[name] = {"path": str(path), "sha256": sha256(path)}
        additions.append(str(omc.parent))
    if additions:
        env["PATH"] = os.pathsep.join(additions + [env.get("PATH", "")])
    return env, {"pathAdditions": additions, "buildTools": tools}


def terminate_tree(process: subprocess.Popen) -> dict:
    if process.poll() is not None:
        return {"attempted": False, "exited": True}
    if os.name == "nt":
        # Record descendants before the parent can exit. Some managed Windows
        # hosts deny taskkill /T even for a process started by this runner.
        descendants = []
        try:
            descendants = psutil.Process(process.pid).children(recursive=True)
        except (psutil.Error, OSError):
            pass
        killed = subprocess.run(["taskkill", "/T", "/F", "/PID", str(process.pid)],
                                capture_output=True, text=True, timeout=30)
        detail = {"method": "taskkill-specific-PID-tree", "pid": process.pid,
                  "taskkillReturnCode": killed.returncode,
                  "taskkillOutput": (killed.stdout + killed.stderr)[-2000:]}
        if killed.returncode != 0:
            try:
                for child in reversed(descendants):
                    try:
                        child.kill()
                    except psutil.NoSuchProcess:
                        pass
                try:
                    psutil.Process(process.pid).kill()
                except psutil.NoSuchProcess:
                    pass
                gone, alive = psutil.wait_procs(descendants, timeout=5)
                detail.update(method="taskkill-then-psutil-specific-PID-tree",
                              psutilChildrenKilled=len(gone), psutilChildrenAlive=[p.pid for p in alive])
            except (psutil.Error, OSError) as exc:
                detail["fallbackError"] = repr(exc)
    else:
        os.killpg(process.pid, signal.SIGKILL)
        detail = {"method": "SIGKILL-specific-process-group", "pid": process.pid}
    try:
        process.wait(timeout=5)
    except subprocess.TimeoutExpired:
        detail["exited"] = False
    else:
        detail["exited"] = True
    detail["attempted"] = True
    return detail


def run_process(command: list[str], *, cwd: Path, log: Path, timeout: int,
                env: dict[str, str]) -> dict:
    start_utc = datetime.now(timezone.utc).isoformat()
    start = time.perf_counter()
    with log.open("wb") as output:
        process = subprocess.Popen(command, cwd=cwd, stdout=output, stderr=subprocess.STDOUT,
                                   env=env, creationflags=subprocess.CREATE_NEW_PROCESS_GROUP if os.name == "nt" else 0,
                                   start_new_session=os.name != "nt")
        timed_out = False
        termination = None
        try:
            code = process.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            timed_out = True
            termination = terminate_tree(process)
            code = 124
    return {"startUTC": start_utc, "endUTC": datetime.now(timezone.utc).isoformat(),
            "wallSeconds": time.perf_counter() - start, "command": command,
            "returnCode": code, "timeout": timed_out, "termination": termination,
            "log": str(log), "status": "TIMEOUT" if timed_out else ("PASS" if code == 0 else "FAIL")}


def load_lines(root: Path) -> tuple[list[str], int]:
    sources = source_files(root)
    lines = ['print("MOSAIC_MSL=" + String(loadModel(Modelica, {"4.0.0"})) + "\\n");',
             'print("MOSAIC_MSL_VERSION=" + getVersion(Modelica) + "\\n");',
             'print("MOSAIC_MSL_SOURCE=" + getSourceFile(Modelica) + "\\n");',
             'print("MOSAIC_OMC_VERSION=" + getVersion() + "\\n");']
    package = mos_string((root / "package.mo").resolve())
    lines.append(f'print("MOSAIC_DIRECT_LOAD=" + String(loadFile({package})) + "\\n");')
    lines.append('print("MOSAIC_LOAD_ERRORS_BEGIN\\n" + getErrorString() + "\\nMOSAIC_LOAD_ERRORS_END\\n");')
    return lines, len(sources)


def stage_script(root: Path, stage: str, config: dict, variable_filter: str) -> tuple[str, int]:
    lines, count = load_lines(root)
    model = config["entryModel"]
    if stage == "CHECK":
        lines.append(f'print("MOSAIC_CHECK=" + checkModel({model}) + "\\n");')
        lines.append('print("MOSAIC_CHECK_ERRORS_BEGIN\\n" + getErrorString() + "\\nMOSAIC_CHECK_ERRORS_END\\n");')
    elif stage == "BUILD":
        value = config["effective"]
        options = (f'startTime={value["startTime"]}, stopTime={value["stopTime"]}, '
                   f'numberOfIntervals={config["numberOfIntervals"]}, tolerance={value["tolerance"]}, '
                   f'method={mos_string(value["solver"])}, fileNamePrefix="CompleteMission", '
                   f'options={mos_string(config["compileOptions"])}, outputFormat="mat", '
                   f'variableFilter={mos_regex(variable_filter)}')
        lines.append(f'buildResult := buildModel({model}, {options});')
        lines.append('print("MOSAIC_BUILD_EXE=" + buildResult[1] + "\\n");')
        lines.append('print("MOSAIC_BUILD_INIT=" + buildResult[2] + "\\n");')
        lines.append('print("MOSAIC_BUILD_ERRORS_BEGIN\\n" + getErrorString() + "\\nMOSAIC_BUILD_ERRORS_END\\n");')
    return "\n".join(lines) + "\n", count


def markers(log: Path) -> dict[str, str]:
    text = log.read_text(encoding="utf-8", errors="replace")
    return {key: value.strip() for key, value in re.findall(r"^MOSAIC_([A-Z0-9_]+)=(.*)$", text, re.MULTILINE)}


def validate_load(log: Path, expected_sources: int) -> dict:
    found = markers(log)
    if found.get("MSL") != "true" or "4.0.0" not in found.get("MSL_VERSION", ""):
        raise RuntimeError("LOAD failed: exact MSL 4.0.0 was not loaded")
    if found.get("DIRECT_LOAD") != "true":
        raise RuntimeError("LOAD failed: OneSatSim/package.mo direct load was rejected")
    if "MOSAIC_LOAD_ERRORS_BEGIN" not in log.read_text(encoding="utf-8", errors="replace"):
        raise RuntimeError("LOAD failed: OMC diagnostic boundary absent")
    return {"omcVersion": found.get("OMC_VERSION"), "mslVersion": found.get("MSL_VERSION"),
            "mslSource": found.get("MSL_SOURCE"), "sourceCount": expected_sources}


def validate_check(log: Path) -> dict:
    raw = log.read_text(encoding="utf-8", errors="replace")
    message = markers(log).get("CHECK", "")
    if not re.search(r"Check of .* completed successfully", message, flags=re.IGNORECASE):
        raise RuntimeError(f"CHECK failed: {message or 'missing checkModel result'}")
    count = re.search(r"(\d+) equation\(s\) and (\d+) variable\(s\)", raw)
    if not count:
        raise RuntimeError("CHECK failed: equation/variable balance was not reported")
    equations, variables = int(count[1]), int(count[2])
    if equations != variables:
        raise RuntimeError(f"CHECK failed: {equations} equations for {variables} variables")
    return {"message": message, "equations": equations, "variables": variables}


def validate_build(log: Path, build_dir: Path) -> dict:
    found = markers(log)
    if not found.get("BUILD_EXE") or not found.get("BUILD_INIT"):
        raise RuntimeError("BUILD failed: buildModel did not return executable and init paths")
    def local(name: str) -> Path:
        path = Path(name)
        return path.resolve() if path.is_absolute() else (build_dir / path).resolve()
    exe = local(found["BUILD_EXE"])
    init = local(found["BUILD_INIT"])
    if not exe.is_file() and os.name == "nt":
        # buildModel returns an extensionless executable stem on this OMC.
        # Resolve it through the platform's declared executable extensions.
        extensions = [suffix.lower() for suffix in os.environ.get("PATHEXT", "").split(";") if suffix]
        candidates = [Path(str(exe) + suffix) for suffix in extensions]
        matches = [path for path in candidates if path.is_file()]
        def is_native_pe(path: Path) -> bool:
            with path.open("rb") as stream:
                return stream.read(2) == b"MZ"
        native = [path for path in matches if is_native_pe(path)]
        if len(native) == 1:
            exe = native[0]
    if not exe.is_relative_to(build_dir.resolve()) or not init.is_relative_to(build_dir.resolve()):
        raise RuntimeError("BUILD returned artifacts outside this fresh build directory")
    if not exe.is_file() or not init.is_file():
        raise RuntimeError(f"BUILD returned missing artifact: {exe}, {init}")
    return {"executable": str(exe), "initialization": str(init),
            "executableSHA256": sha256(exe), "initializationSHA256": sha256(init)}


def runtime_command(exe: Path, result: Path, config: dict) -> list[str]:
    value = config["effective"]
    override = f'-override=startTime={value["startTime"]},stopTime={value["stopTime"]},stepSize={value["outputInterval"]}'
    return [str(exe), override, f'-s={value["solver"]}',
            f'-idaLS={value["idaLinearSolver"]}', f'-jacobian={value["jacobian"]}',
            f'-r={result}']


def verify_inventory(expected: dict, root: Path, config: dict, omc: Path, msl: Path, at: str) -> None:
    changes = compare(expected, inventory(root, config, omc=omc, msl_package=msl))
    if changes:
        raise RuntimeError(f"CANDIDATE_DRIFT at {at}: " + "; ".join(changes[:12]))


def verify_native_filter(raw_path: Path, filtered_path: Path, saved_paths: list[str]) -> dict:
    """Require native filtering to preserve every saved bit and raw event row."""
    raw = MatV4(raw_path)
    filtered = MatV4(filtered_path)
    if set(filtered.names) != set(saved_paths) or len(filtered.names) != len(saved_paths):
        missing = sorted(set(saved_paths) - set(filtered.names))
        extra = sorted(set(filtered.names) - set(saved_paths))
        raise RuntimeError(f"Native MAT filter changed saved names: missing={missing}, extra={extra}")
    if raw.time.shape != filtered.time.shape or not np.array_equal(
            raw.time.view(np.uint64), filtered.time.view(np.uint64)):
        raise RuntimeError("Native MAT filter changed time or event rows")
    for name in saved_paths:
        if name not in raw.lookup:
            raise RuntimeError(f"Raw MAT lacks contracted signal {name}")
        before = np.asarray(raw.read(name, allow_parameter_end_change=True), dtype=np.float64)
        after = np.asarray(filtered.read(name, allow_parameter_end_change=True), dtype=np.float64)
        if before.shape != after.shape or not np.array_equal(
                before.view(np.uint64), after.view(np.uint64)):
            raise RuntimeError(f"Native MAT filter changed bits for {name}")
    summary = filtered.summary()
    return {"savedSignalCount": len(saved_paths), "timePoints": summary["timePoints"],
            "duplicateEventPoints": summary["duplicateEventPoints"],
            "dynamicRowsOnDisk": summary["dynamicRowsOnDisk"],
            "timeBitwiseEqual": True, "savedSignalsBitwiseEqual": True}


def filter_oversize_formal_mat(result: Path, work: Path, build_dir: Path, result_dir: Path,
                               contract: dict, config: dict, omc: Path, env: dict[str, str],
                               manifest: dict, persist) -> None:
    """Use OMC's no-resampling filter only after an oversized full run."""
    maximum = int(contract["outputPolicy"]["maximumBytes"])
    if config["runKind"] != "NOMINAL_FULL" or result.stat().st_size <= maximum:
        return
    saved_paths = [row["path"] for row in contract["signals"] if row["save"]]
    if saved_paths.count("time") != 1:
        raise RuntimeError("Native MAT filter requires exactly one contracted time path")
    # OpenModelica adds time automatically. Passing it in vars duplicates its
    # metadata name, so the selected array contains only non-time paths.
    variables = "{" + ",".join(mos_string(name) for name in saved_paths if name != "time") + "}"
    raw_path = work / "raw_complete_mission.mat"
    filtered_path = work / "filtered_complete_mission.mat"
    raw_sha = sha256(result)
    shutil.copy2(result, raw_path)
    if sha256(raw_path) != raw_sha:
        raise RuntimeError("Raw MAT archive differs from simulated result")
    expression = (f"filterSimulationResults({mos_string(raw_path)},"
                  f"{mos_string(filtered_path)},{variables},0,false,true)")
    script = build_dir / "filter_lossless.mos"
    script.write_text('print("MOSAIC_FILTER=" + String(' + expression + ') + "\\n");\n'
                      'print("MOSAIC_FILTER_ERRORS_BEGIN\\n" + getErrorString() + '
                      '"\\nMOSAIC_FILTER_ERRORS_END\\n");\n', encoding="utf-8")
    log = result_dir / "filter.log"
    state = run_process([str(omc), str(script)], cwd=build_dir, log=log,
                        timeout=config["supervision"]["buildSeconds"], env=env)
    manifest["stages"]["NATIVE_FILTER"] = state
    manifest["nativeFilter"] = {"method": "OpenModelica filterSimulationResults",
                                "numberOfIntervals": 0, "removeDescription": False,
                                "hintReadAllVars": True, "call": expression,
                                "script": str(script), "scriptSHA256": sha256(script),
                                "raw": {"path": str(raw_path), "bytes": raw_path.stat().st_size,
                                        "sha256": raw_sha}, "log": str(log)}
    persist()
    if state["status"] != "PASS" or markers(log).get("FILTER") != "true" or not filtered_path.is_file():
        raise RuntimeError("Native MAT filter failed; raw result retained in work and results")
    proof = verify_native_filter(raw_path, filtered_path, saved_paths)
    filtered_sha = sha256(filtered_path)
    filtered_bytes = filtered_path.stat().st_size
    os.replace(filtered_path, result)
    manifest["nativeFilter"]["output"] = {"path": str(result), "bytes": filtered_bytes,
                                           "sha256": filtered_sha}
    manifest["nativeFilter"]["verification"] = proof
    persist()


def execute(args: argparse.Namespace) -> int:
    contract = load_contract()
    config = resolve(ROOT, contract, run_kind=args.run_kind, stop=args.stop,
                     output_interval=args.output_interval, reason=args.reason,
                     build_timeout=args.build_timeout, simulation_timeout=args.simulation_timeout)
    omc = locate_omc()
    env, toolchain = tool_environment(omc)
    variable_filter = filter_regex(contract)
    config["variableFilter"] = variable_filter
    config["variableFilterSHA256"] = hashlib.sha256(variable_filter.encode()).hexdigest()
    config["omcExecutable"] = str(omc)
    config["toolchain"] = toolchain
    preliminary = inventory(ROOT, config, omc=omc)
    timestamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    run_id = f"MOSAIC12U-v1.1.4-{timestamp}-{preliminary['BuildFingerprint'][:8]}-{config['runKind']}-{random.getrandbits(16):04x}"
    work = WORK / run_id
    result_dir = RESULTS / run_id
    if work.exists() or result_dir.exists():
        raise RuntimeError("RunId collision; refusing to reuse prior build/results")
    build_dir = work / "build"
    build_dir.mkdir(parents=True)
    result_dir.mkdir(parents=True)
    config_path = result_dir / "ResolvedRunConfig.json"
    config_path.write_text(json.dumps(config, ensure_ascii=False, indent=2), encoding="utf-8")
    manifest = {"schemaVersion": "1.0", "RunId": run_id, "entryModel": config["entryModel"],
                "runKind": config["runKind"], "status": "RUNNING", "runStatus": "NOT_RUN",
                "projectVersion": config["projectVersion"], "platform": platform.platform(),
                "python": sys.version, "stages": {}, "resolvedConfig": str(config_path),
                "resultAudit": None, "mat": None, "provenance": None}
    manifest_path = result_dir / "RunManifest.json"
    def persist():
        manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=2), encoding="utf-8")
    persist()
    msl_source = None
    frozen = None
    try:
        for stage in ("LOAD", "CHECK", "BUILD"):
            if frozen is not None:
                verify_inventory(frozen, ROOT, config, omc, msl_source, "before-" + stage)
            elif compare(preliminary, inventory(ROOT, config, omc=omc)):
                raise RuntimeError("CANDIDATE_DRIFT before " + stage)
            script_text, count = stage_script(ROOT, stage, config, variable_filter)
            script = build_dir / (stage.lower() + ".mos")
            script.write_text(script_text, encoding="utf-8")
            log = result_dir / (stage.lower() + ".log")
            state = run_process([str(omc), str(script)], cwd=build_dir, log=log,
                                timeout=config["supervision"]["buildSeconds"], env=env)
            manifest["stages"][stage] = state
            persist()
            if state["status"] != "PASS":
                raise RuntimeError(f"{stage} process {state['status']} exit={state['returnCode']}")
            identity = validate_load(log, count)
            manifest["stages"][stage]["loadIdentity"] = identity
            if msl_source is None:
                msl_source = Path(identity["mslSource"].replace("/", os.sep))
                if not msl_source.is_file():
                    raise RuntimeError(f"MSL source path not readable: {msl_source}")
                frozen = inventory(ROOT, config, omc=omc, msl_package=msl_source)
                manifest["CandidateId"] = frozen["CandidateId"]
                manifest["BuildFingerprint"] = frozen["BuildFingerprint"]
                provenance_path = result_dir / "CandidateFiles.json"
                provenance_path.write_text(json.dumps(frozen, ensure_ascii=False, indent=2), encoding="utf-8")
                manifest["provenance"] = str(provenance_path)
            if stage == "CHECK":
                manifest["stages"][stage]["checkModel"] = validate_check(log)
            if stage == "BUILD":
                manifest["stages"][stage]["buildModel"] = validate_build(log, build_dir)
                verify_inventory(frozen, ROOT, config, omc, msl_source, "after-BUILD")
            persist()
        verify_inventory(frozen, ROOT, config, omc, msl_source, "before-RUN")
        built = manifest["stages"]["BUILD"]["buildModel"]
        exe = Path(built["executable"])
        if sha256(exe) != built["executableSHA256"]:
            raise RuntimeError("Built executable drift before RUN")
        result = result_dir / (run_id + ".mat")
        state = run_process(runtime_command(exe, result, config), cwd=build_dir,
                            log=result_dir / "run.log", timeout=config["supervision"]["simulationSeconds"], env=env)
        manifest["stages"]["RUN"] = state
        manifest["runStatus"] = "TIMEOUT" if state["timeout"] else ("COMPLETED" if state["returnCode"] == 0 else "ERROR")
        persist()
        if state["status"] != "PASS" or not result.is_file():
            raise RuntimeError("RUN failed or did not produce its own MAT")
        verify_inventory(frozen, ROOT, config, omc, msl_source, "after-RUN")
        filter_oversize_formal_mat(result, work, build_dir, result_dir, contract, config,
                                   omc, env, manifest, persist)
        audited = audit(result, contract, config)
        audit_path = result_dir / "ResultAudit.json"
        audit_path.write_text(json.dumps(audited, ensure_ascii=False, indent=2), encoding="utf-8")
        manifest["stages"]["RESULT_AUDIT"] = {"status": audited["status"], "checks": audited["checks"],
                                                  "path": str(audit_path)}
        manifest["resultAudit"] = str(audit_path)
        manifest["mat"] = {"path": str(result), "bytes": result.stat().st_size,
                           "sha256": audited.get("sha256"), "structure": audited.get("mat")}
        persist()
        short_run = config["runKind"] != "NOMINAL_FULL"
        if audited.get("matIntegrityStatus", "FAIL") != "PASS" or audited["status"] == "FAIL":
            raise RuntimeError("RESULT_AUDIT failed; candidate MAT retained only in results")
        if not short_run and audited["status"] != "PASS":
            raise RuntimeError("RESULT_AUDIT physics acceptance incomplete; candidate MAT retained only in results")
        if args.output:
            if audited["status"] != "PASS":
                raise RuntimeError("Cannot publish copy while physics acceptance remains open")
            output = args.output.resolve()
            output.parent.mkdir(parents=True, exist_ok=True)
            temporary = output.with_name(output.name + ".partial-" + run_id)
            shutil.copy2(result, temporary)
            if sha256(temporary) != audited["sha256"]:
                temporary.unlink(missing_ok=True)
                raise RuntimeError("Copied MAT hash mismatch")
            os.replace(temporary, output)
            manifest["publishedCopy"] = {"path": str(output), "sha256": sha256(output)}
        manifest["status"] = ("RUN_AND_RESULT_AUDIT_PASS" if audited["status"] == "PASS"
                              else "RUN_AND_MAT_INTEGRITY_PASS_PH_OPEN")
        persist()
        print(f"[PASS] RunId={run_id} MAT={result} bytes={result.stat().st_size}")
        return 0
    except Exception as exc:
        manifest["status"] = "FAILED"
        manifest["error"] = str(exc)
        persist()
        print(f"[FAIL] RunId={run_id}: {exc}", file=sys.stderr)
        return 1


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--run-kind", choices=("NOMINAL_FULL", "LOCAL_TEST", "SMOKE", "DIAGNOSTIC"), default="NOMINAL_FULL")
    parser.add_argument("--stop", type=float, default=None)
    parser.add_argument("--output-interval", type=float, default=None)
    parser.add_argument("--reason", default=None)
    parser.add_argument("--build-timeout", type=int, default=900)
    parser.add_argument("--simulation-timeout", type=int, default=3600)
    parser.add_argument("--output", type=Path, default=None, help="Copy only a fully audited MAT to this path")
    return execute(parser.parse_args())


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ValueError, FileNotFoundError) as exc:
        print(f"[FAIL] PRECHECK: {exc}", file=sys.stderr)
        raise SystemExit(1)
