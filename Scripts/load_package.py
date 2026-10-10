#!/usr/bin/env python3
"""Directly load OneSatSim/package.mo in OpenModelica and check its entry model."""

from __future__ import annotations

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ENTRY = "OneSatSim.Simulation.CompleteMission"


def source_files(root: Path) -> list[Path]:
    packages = sorted((p for p in root.rglob("package.mo") if p != root / "package.mo"),
                      key=lambda p: (len(p.relative_to(root).parts), p.as_posix().lower()))
    models = sorted((p for p in root.rglob("*.mo") if p.name != "package.mo"),
                    key=lambda p: p.as_posix().lower())
    return [root / "package.mo", *packages, *models]


def mos_string(value: str | Path) -> str:
    return '"' + str(value).replace("\\", "/").replace('"', '\\"') + '"'


def locate_omc(override: str | None) -> Path:
    for candidate in (override, os.environ.get("OMC_EXE"), shutil.which("omc"),
                      r"F:\OpenModelica1.25.5-64bit\bin\omc.exe"):
        if candidate and Path(candidate).is_file():
            return Path(candidate).resolve()
    raise FileNotFoundError("OpenModelica CLI not found; pass --omc or set OMC_EXE")


def make_script(sources: list[Path], *, check: bool, direct: bool) -> str:
    lines = ['print("MOSAIC_MSL=" + String(loadModel(Modelica, {"4.0.0"})) + "\\n");']
    if direct:
        lines.append(f'print("MOSAIC_DIRECT_LOAD=" + String(loadFile({mos_string(ROOT / "package.mo")})) + "\\n");')
    else:
        for index, source in enumerate(sources):
            path = mos_string(source.resolve())
            lines.append(f'print("MOSAIC_SOURCE_{index:04d}=" + String(loadString(readFile({path}), {path}, merge=true)) + "\\n");')
    lines.append('print("MOSAIC_ROOT=" + String(isPackage(OneSatSim)) + "\\n");')
    if check:
        lines.append(f'print("MOSAIC_CHECK=" + checkModel({ENTRY}) + "\\n");')
    lines.append('print("MOSAIC_ERRORS_BEGIN\\n" + getErrorString() + "\\nMOSAIC_ERRORS_END\\n");')
    return "\n".join(lines) + "\n"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source-fallback", action="store_true", help="Diagnostic only: load each .mo source separately")
    parser.add_argument("--load-only", action="store_true", help="Check package loading without checkModel")
    parser.add_argument("--omc", help="Path to omc.exe")
    parser.add_argument("--timeout", type=int, default=900, help="OMC timeout in seconds")
    parser.add_argument("--verbose", action="store_true", help="Print full OMC output")
    args = parser.parse_args()
    direct = not args.source_fallback
    sources = source_files(ROOT)
    omc = locate_omc(args.omc)
    with tempfile.TemporaryDirectory(prefix="mosaic_load_") as temporary:
        folder = Path(temporary)
        script = folder / "load_package.mos"
        script.write_text(make_script(sources, check=not args.load_only, direct=direct), encoding="utf-8")
        result = subprocess.run([str(omc), str(script)], cwd=folder,
                                capture_output=True, text=True, encoding="utf-8",
                                errors="replace", timeout=args.timeout)
    output = result.stdout + result.stderr
    if args.verbose:
        print(output)
    markers = dict(re.findall(r"^MOSAIC_([A-Z0-9_]+)=(.*)$", output, re.MULTILINE))
    failed = ([] if direct else [str(source.relative_to(ROOT)) for index, source in enumerate(sources)
              if markers.get(f"SOURCE_{index:04d}") != "true"])
    balance = re.search(r"Class .* has (\d+) equation\(s\) and (\d+) variable\(s\)", output)
    check_ok = args.load_only or (
        "completed successfully" in markers.get("CHECK", "") and
        balance is not None and int(balance[1]) == int(balance[2]))
    ok = result.returncode == 0 and markers.get("MSL") == "true" and not failed \
         and (not direct or markers.get("DIRECT_LOAD") == "true") \
         and markers.get("ROOT") == "true" and check_ok
    counts = f"{balance[1]}/{balance[2]}" if balance else "unreported"
    print(f"OMC={omc}; mode={'DIRECT' if direct else 'SOURCE_FALLBACK'}; sources={len(sources)}; loaded={len(sources) if ok else (0 if direct else len(sources)-len(failed))}; "
          f"root={markers.get('ROOT', 'missing')}; check={'SKIPPED' if args.load_only else ('PASS' if check_ok else 'FAIL')}; "
          f"equations/variables={counts}")
    if not ok:
        if failed:
            print("Failed sources: " + ", ".join(failed[:20]), file=sys.stderr)
        error_match = re.search(r"MOSAIC_ERRORS_BEGIN\n(.*?)\nMOSAIC_ERRORS_END", output, re.DOTALL)
        print((error_match.group(1) if error_match else output)[-8000:], file=sys.stderr)
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
