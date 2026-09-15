#!/usr/bin/env python3
"""Enforce graphical white-box purity and visible connect annotations."""
from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MODEL = ROOT


def remove_balanced_annotation(text: str) -> str:
    out: list[str] = []
    pos = 0
    while True:
        match = re.search(r"\bannotation\s*\(", text[pos:])
        if not match:
            out.append(text[pos:])
            break
        start = pos + match.start()
        open_at = pos + match.end() - 1
        out.append(text[pos:start])
        depth = 0
        i = open_at
        in_string = False
        while i < len(text):
            char = text[i]
            if char == '"' and (i == 0 or text[i - 1] != "\\"):
                in_string = not in_string
            elif not in_string:
                if char == "(":
                    depth += 1
                elif char == ")":
                    depth -= 1
                    if depth == 0:
                        i += 1
                        if i < len(text) and text[i] == ";":
                            i += 1
                        break
            i += 1
        pos = i
    return "".join(out)


def class_name(text: str) -> str:
    match = re.search(r"\bmodel\s+(\w+)", text)
    return match.group(1) if match else "UNKNOWN"


def whiteboxes() -> list[Path]:
    files = list((MODEL / "Components").glob("*.mo"))
    files += list((MODEL / "Systems").rglob("*.mo"))
    files += [MODEL / "Simulation" / "CompleteMission.mo"]
    return [p for p in files if p.name != "package.mo"]


def main() -> int:
    errors: list[str] = []
    checked = 0
    for path in sorted(whiteboxes()):
        text = path.read_text(encoding="utf-8-sig")
        name = class_name(text)
        checked += 1
        if re.search(r"\bpartial\s+model\b", text):
            errors.append(f"{path}: partial model is forbidden")
        if re.search(r"\bextends\s+[\w.]", text):
            errors.append(f"{path}: white-box model extends another model")
        if "Icon(" not in text:
            errors.append(f"{path}: missing concise Icon annotation")
        eq = re.search(r"\bequation\b(.*)\bend\s+" + re.escape(name) + r"\s*;", text, re.S)
        if not eq:
            errors.append(f"{path}: missing equation section")
            continue
        original = eq.group(1)
        for statement in re.findall(r"\bconnect\s*\(.*?;", original, re.S):
            if "annotation" not in statement or "Line(" not in statement:
                errors.append(f"{path}: connect without visible annotation(Line): {statement[:90]!r}")
        clean = remove_balanced_annotation(original)
        clean = re.sub(r"//.*?$|/\*.*?\*/", "", clean, flags=re.M | re.S)
        statements = [s.strip() for s in clean.split(";") if s.strip()]
        for statement in statements:
            if not re.fullmatch(r"connect\s*\(.*\)", statement, re.S):
                errors.append(f"{path}: non-connect equation statement: {statement[:120]!r}")
        if re.search(r"\b(algorithm|when|for|while|if|der)\b", clean):
            errors.append(f"{path}: procedural/physical equation syntax in white-box equation section")

    global_partial = []
    for path in MODEL.rglob("*.mo"):
        if re.search(r"\bpartial\s+model\b", path.read_text(encoding="utf-8-sig")):
            global_partial.append(str(path))
    errors.extend(f"{p}: global partial model syntax is forbidden" for p in global_partial)

    if errors:
        print(f"WHITEBOX CHECK FAIL ({len(errors)} issues)")
        print("\n".join(errors))
        return 1
    print(f"WHITEBOX CHECK PASS: {checked} graphical models; equations contain connect() only; every connect has annotation(Line).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
