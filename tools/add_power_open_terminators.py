#!/usr/bin/env python3
"""Add visible MSL zero-conductance terminations to every unused PowerPort rail.

A PowerPort exposes 12 V, 5 V and 3.3 V pins so system engineers can connect a
single graphical interface.  At device level, rails not owned by that device
must still have i=0 constitutive equations; otherwise their connector flow
variables make the assembled electrical network under-determined.
"""
from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
COMP = ROOT / "NISSA_12UCubeSat" / "Components"

RAILS = {
    "12": ("p12", "n12", "{{-98,-94},{-86,-82}}", "{-98,-88}", "{-86,-88}"),
    "5": ("p5", "n5", "{{-78,-94},{-66,-82}}", "{-78,-88}", "{-66,-88}"),
    "33": ("p33", "n33", "{{-58,-94},{-46,-82}}", "{-58,-88}", "{-46,-88}"),
}


def main() -> None:
    touched = 0
    terminations = 0
    for path in sorted(COMP.glob("*.mo")):
        text = path.read_text(encoding="utf-8-sig")
        if "Foundation.Interfaces.PowerPort power" not in text:
            continue
        original = text
        declarations: list[str] = []
        connections: list[str] = []
        for rail, (p, n, extent, ppoint, npoint) in RAILS.items():
            name = f"unused{rail}Rail"
            used = bool(re.search(rf"power\.(?:{p}|{n})\b", text))
            if used or name in text:
                continue
            declarations.append(
                f"  Modelica.Electrical.Analog.Basic.Conductor {name}(G=0) "
                f"annotation(Placement(transformation(extent={extent})));"
            )
            connections.extend([
                f"  connect(power.{p},{name}.p) annotation(Line(points={{{{-102,0}},{ppoint}}},color={{0,0,255}}));",
                f"  connect({name}.n,power.{n}) annotation(Line(points={{{npoint},{{-102,0}}}},color={{0,0,255}}));",
            ])
            terminations += 1
        if not declarations:
            continue
        marker = re.search(r"^\s*Foundation\.Interfaces\.PowerPort power.*?;\s*$", text, re.M)
        if not marker:
            raise RuntimeError(f"PowerPort declaration not found in {path}")
        text = text[:marker.end()] + "\n" + "\n".join(declarations) + text[marker.end():]
        text = text.replace("equation\n", "equation\n" + "\n".join(connections) + "\n", 1)
        if text != original:
            path.write_text(text, encoding="utf-8")
            touched += 1
    print(f"power open terminators: {terminations} rails across {touched} component files")


if __name__ == "__main__":
    main()
