#!/usr/bin/env python3
"""Generate the read-only native Modelica dashboard from its saved-signal dictionary."""

from __future__ import annotations

import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent
ENTRIES = json.loads((HERE / "dashboard_signals.json").read_text(encoding="utf-8"))
OUT = ROOT / "Simulation" / "OnboardTelemetry.mo"


def quoted(value: str) -> str:
    return '"' + value.replace('\\', '\\\\').replace('"', '\\"') + '"'


def main() -> None:
    names = [entry["name"] for entry in ENTRIES]
    if len(names) != len(set(names)):
        raise ValueError("duplicate dashboard output")
    lines = [
        "within OneSatSim.Simulation;",
        'model OnboardTelemetry "只读星上工程遥测"',
        "  OneSatSim.Foundation.Interfaces.OnboardTelemetryPort telemetry",
        "    annotation(Placement(visible=true, transformation(origin={-100,0}, extent={{-2,-2},{2,2}}, rotation=0),",
        "      iconVisible=true, iconTransformation(origin={-100,0}, extent={{-2,-2},{2,2}}, rotation=0)));",
    ]
    for item in ENTRIES:
        unit = f'(each unit={quoted(item["unit"])})' if item.get("size") and item["unit"] else (
            f'(unit={quoted(item["unit"])})' if item["unit"] else ""
        )
        size = f'[{item["size"]}]' if item.get("size") else ""
        lines.append(f'  output {item["type"]} {item["name"]}{size}{unit} {quoted(item["label"])};')
    lines.append("equation")
    for item in ENTRIES:
        lines.append(f'  {item["name"]}=telemetry.{item["source"]};')

    graphics = [
        "Rectangle(extent={{-84,-43},{84,72}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=3)",
        "Rectangle(extent={{-70,-29},{70,58}}, lineColor={0,102,255}, fillColor={0,102,255}, fillPattern=FillPattern.Solid, radius=0)",
        "Line(points={{-49,8},{-30,8},{-17,32},{1,-10},{17,17},{49,17}}, color={255,255,255}, thickness=2, pattern=LinePattern.Solid, smooth=Smooth.None)",
        "Rectangle(extent={{-10,-70},{10,-43}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid)",
        "Rectangle(extent={{-47,-81},{47,-70}}, lineColor={35,45,65}, fillColor={35,45,65}, fillPattern=FillPattern.Solid, radius=2)",
        "Ellipse(extent={{58,-39},{65,-32}}, lineColor={0,200,83}, fillColor={0,200,83}, fillPattern=FillPattern.Solid)",
    ]
    common = "coordinateSystem(extent={{-100,-100},{100,100}}, preserveAspectRatio=true)"
    lines.extend([
        "  annotation(Documentation(info=\"<html><p>只读遥测计算机。全部输出来自星上信息总线的唯一遥测出口；图形不改变方程、状态或时钟。</p></html>\"),",
        f"    Icon({common}, graphics={{",
        "      " + ",\n      ".join(graphics),
        "    }),",
        f"    Diagram({common}, graphics={{",
        "      " + ",\n      ".join(graphics),
        "    }));",
        "end OnboardTelemetry;",
    ])
    from DocumentationSupport import enrich_generated
    OUT.write_text(enrich_generated("\n".join(lines) + "\n", str(OUT)), encoding="utf-8")
    scalar_count = sum(item.get("size", 1) for item in ENTRIES)
    print(f"{OUT}: {len(ENTRIES)} fields, {scalar_count} scalars")


if __name__ == "__main__":
    main()
