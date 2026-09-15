#!/usr/bin/env python3
"""Derive whole-spacecraft mass properties from the resolved component design.

The resolved parameter snapshot is the only numeric input.  Physical locations
come from MultiBody connections, Body/BodyBox data and FixedTranslation paths;
Diagram/Icon coordinates are never used.
"""

from __future__ import annotations

import argparse
import ast
import csv
import json
import math
import re
from dataclasses import dataclass
from pathlib import Path

import numpy as np


PACKAGE_ROOT = Path(__file__).resolve().parents[1]


@dataclass
class RigidBody:
    component: str
    instance: str
    class_name: str
    mass: float
    com: np.ndarray
    inertia: np.ndarray


def balanced(text: str, open_index: int) -> str:
    depth = 0
    in_string = False
    escaped = False
    for index in range(open_index, len(text)):
        char = text[index]
        if in_string:
            if escaped:
                escaped = False
            elif char == "\\":
                escaped = True
            elif char == '"':
                in_string = False
        elif char == '"':
            in_string = True
        elif char == "(":
            depth += 1
        elif char == ")":
            depth -= 1
            if depth == 0:
                return text[open_index + 1:index]
    raise ValueError("unbalanced Modelica parentheses")


def split_top(text: str) -> list[str]:
    parts, start, depth = [], 0, 0
    in_string = False
    for index, char in enumerate(text):
        if char == '"':
            in_string = not in_string
        elif not in_string and char in "({[":
            depth += 1
        elif not in_string and char in ")} ]".replace(" ", ""):
            depth -= 1
        elif not in_string and char == "," and depth == 0:
            parts.append(text[start:index].strip())
            start = index + 1
    parts.append(text[start:].strip())
    return [part for part in parts if part]


def modifications(text: str) -> dict[str, str]:
    result = {}
    for part in split_top(text):
        if "=" in part:
            key, value = part.split("=", 1)
            result[key.strip()] = value.strip()
    return result


def evaluate(expression: str, symbols: dict[str, object]) -> object:
    expression = expression.strip().replace("Modelica.Constants.pi", repr(math.pi))
    expression = re.sub(r"\{([^{}]*)\}", r"[\1]", expression)
    tree = ast.parse(expression, mode="eval")

    def visit(node: ast.AST) -> object:
        if isinstance(node, ast.Expression):
            return visit(node.body)
        if isinstance(node, ast.Constant) and isinstance(node.value, (int, float)):
            return float(node.value)
        if isinstance(node, ast.Name) and node.id in symbols:
            return symbols[node.id]
        if isinstance(node, ast.List):
            return np.array([float(visit(item)) for item in node.elts], dtype=float)
        if isinstance(node, ast.UnaryOp) and isinstance(node.op, (ast.UAdd, ast.USub)):
            value = visit(node.operand)
            return value if isinstance(node.op, ast.UAdd) else -value
        if isinstance(node, ast.BinOp) and isinstance(node.op, (ast.Add, ast.Sub, ast.Mult, ast.Div, ast.Pow)):
            left, right = visit(node.left), visit(node.right)
            return {
                ast.Add: lambda: left + right,
                ast.Sub: lambda: left - right,
                ast.Mult: lambda: left * right,
                ast.Div: lambda: left / right,
                ast.Pow: lambda: left**right,
            }[type(node.op)]()
        raise ValueError(f"unsupported expression {expression!r}")

    return visit(tree)


def lower_alias(parameter: str) -> str:
    converted = re.sub(r"^([A-Z]+)(?=[A-Z][a-z]|_)", lambda match: match.group(1).lower(), parameter)
    return converted[:1].lower() + converted[1:]


def load_snapshot(path: Path) -> tuple[dict[str, dict[str, object]], float]:
    document = json.loads(path.read_text(encoding="utf-8"))
    by_model: dict[str, dict[str, object]] = {}
    primary_structure_mass = None
    for row in document.get("parameters", []):
        if row.get("Kind") != "Component":
            continue
        model = str(row.get("ComponentModel") or "")
        if not model.startswith("Components."):
            continue
        alias = "cellCapacity" if row.get("Parameter") == "CellCapacity_Ah" else lower_alias(str(row.get("Parameter")))
        by_model.setdefault(model.split(".")[-1], {})[alias] = row.get("ResolvedSIValue")
        if row.get("Parameter") == "PrimaryStructureMass":
            primary_structure_mass = float(row["ResolvedSIValue"])
    if primary_structure_mass is None:
        raise ValueError("resolved snapshot has no Structure.PrimaryStructureMass")
    return by_model, primary_structure_mass


def declarations(text: str, names: tuple[str, ...]) -> list[tuple[str, str, dict[str, str]]]:
    pattern = re.compile(
        r"Modelica\.Mechanics\.MultiBody\.Parts\.(" + "|".join(names) + r")\s+(\w+)\s*\("
    )
    found = []
    for match in pattern.finditer(text):
        found.append((match.group(1), match.group(2), modifications(balanced(text, match.end() - 1))))
    return found


def resolve_parameters(text: str, seed: dict[str, object]) -> dict[str, object]:
    symbols = dict(seed)
    pattern = re.compile(
        r"(?:final\s+)?parameter\s+[A-Za-z0-9_.]+(?:\[[^\]]+\])?\s+(\w+)(?:\([^;=]*\))?\s*=\s*([^;]+);",
        re.DOTALL,
    )
    pending = [(match.group(1), match.group(2).strip()) for match in pattern.finditer(text)]
    for _ in range(len(pending) + 1):
        remainder = []
        progress = False
        for name, expression in pending:
            if expression.startswith("config."):
                continue
            try:
                symbols[name] = evaluate(expression, symbols)
                progress = True
            except (ValueError, SyntaxError, TypeError, KeyError):
                remainder.append((name, expression))
        pending = remainder
        if not progress:
            break
    return symbols


def active_components() -> dict[str, tuple[str, Path]]:
    active = {}
    pattern = re.compile(r"\bComponents\.(\w+)\s+(\w+)(?:\s*\(|\s+annotation)")
    for system_file in sorted((PACKAGE_ROOT / "Systems" / "N_systems").glob("*.mo")):
        text = system_file.read_text(encoding="utf-8")
        for class_name, instance in pattern.findall(text):
            path = PACKAGE_ROOT / "Components" / f"{class_name}.mo"
            if not path.is_file():
                raise FileNotFoundError(f"active component class has no source: {class_name}")
            active[f"{system_file.stem}.{instance}:{class_name}"] = (class_name, path)
    if not active:
        raise RuntimeError("no active component instances found")
    return active


def graph_origins(text: str, translations: dict[str, np.ndarray]) -> dict[str, np.ndarray]:
    graph: dict[str, list[tuple[str, np.ndarray]]] = {}

    def add(left: str, right: str, offset: np.ndarray) -> None:
        graph.setdefault(left, []).append((right, offset))
        graph.setdefault(right, []).append((left, -offset))

    for left, right in re.findall(r"connect\(\s*([^,]+?)\s*,\s*([^\)]+?)\s*\)", text, re.DOTALL):
        add(left.strip(), right.strip(), np.zeros(3))
    for instance, offset in translations.items():
        add(f"{instance}.frame_a", f"{instance}.frame_b", offset)
    origins = {"mechanical": np.zeros(3)}
    queue = ["mechanical"]
    while queue:
        node = queue.pop(0)
        for neighbor, offset in graph.get(node, []):
            candidate = origins[node] + offset
            if neighbor in origins and not np.allclose(origins[neighbor], candidate, atol=1e-10):
                raise ValueError(f"inconsistent mechanical path at {neighbor}")
            if neighbor not in origins:
                origins[neighbor] = candidate
                queue.append(neighbor)
    return origins


def box_inertia(direction: np.ndarray, mass: float, length: float, width: float, height: float) -> np.ndarray:
    ex = direction / np.linalg.norm(direction)
    trial = np.array([0.0, 1.0, 0.0])
    if abs(float(ex @ trial)) > 0.999:
        trial = np.array([1.0, 0.0, 0.0])
    ey = trial - ex * float(ex @ trial)
    ey /= np.linalg.norm(ey)
    ez = np.cross(ex, ey)
    rotation = np.column_stack((ex, ey, ez))
    local = np.diag([
        mass * (width**2 + height**2) / 12,
        mass * (length**2 + height**2) / 12,
        mass * (length**2 + width**2) / 12,
    ])
    return rotation @ local @ rotation.T


def audit_bodies(snapshot: Path) -> tuple[list[RigidBody], float]:
    seeds, primary_structure_mass = load_snapshot(snapshot)
    bodies = []
    for component_key, (class_name, path) in active_components().items():
        text = path.read_text(encoding="utf-8")
        if "Modelica.Mechanics.MultiBody.Parts.FixedRotation" in text:
            raise ValueError(f"unsupported FixedRotation in {component_key}")
        symbols = resolve_parameters(text, seeds.get(class_name, {}))
        translations = {}
        for _, instance, mods in declarations(text, ("FixedTranslation", "BodyBox")):
            translations[instance] = np.asarray(evaluate(mods["r"], symbols), dtype=float)
        origins = graph_origins(text, translations)
        for kind, instance, mods in declarations(text, ("Body", "BodyBox")):
            frame = f"{instance}.frame_a"
            if frame not in origins:
                raise ValueError(f"unresolved mechanical path for {component_key}.{frame}")
            if kind == "Body":
                required = ("m", "r_CM", "I_11", "I_22", "I_33")
                if any(name not in mods for name in required):
                    raise ValueError(f"{component_key}.{instance} lacks explicit mass properties")
                mass = float(evaluate(mods["m"], symbols))
                local_com = np.asarray(evaluate(mods["r_CM"], symbols), dtype=float)
                inertia = np.array([
                    [float(evaluate(mods["I_11"], symbols)), float(evaluate(mods.get("I_21", "0"), symbols)), float(evaluate(mods.get("I_31", "0"), symbols))],
                    [float(evaluate(mods.get("I_21", "0"), symbols)), float(evaluate(mods["I_22"], symbols)), float(evaluate(mods.get("I_32", "0"), symbols))],
                    [float(evaluate(mods.get("I_31", "0"), symbols)), float(evaluate(mods.get("I_32", "0"), symbols)), float(evaluate(mods["I_33"], symbols))],
                ])
            else:
                direction = np.asarray(evaluate(mods["r"], symbols), dtype=float)
                length = float(evaluate(mods["length"], symbols))
                width = float(evaluate(mods["width"], symbols))
                height = float(evaluate(mods["height"], symbols))
                density = float(evaluate(mods["density"], symbols))
                mass = density * length * width * height
                local_com = direction / np.linalg.norm(direction) * length / 2
                inertia = box_inertia(direction, mass, length, width, height)
            if mass <= 0 or np.any(np.linalg.eigvalsh(inertia) <= 0):
                raise ValueError(f"non-physical mass/inertia for {component_key}.{instance}")
            bodies.append(RigidBody(component_key, instance, kind, mass, origins[frame] + local_com, inertia))
    if not bodies:
        raise RuntimeError("no active Body/BodyBox found")
    return bodies, primary_structure_mass


def vector(values: np.ndarray) -> str:
    return "{" + ",".join(f"{value:.12g}" for value in values) + "}"


def matrix(values: np.ndarray) -> str:
    return "{" + ",".join(vector(row) for row in values) + "}"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--resolved-snapshot", type=Path, required=True)
    parser.add_argument("--output-dir", type=Path, required=True)
    parser.add_argument("--generate-record", action="store_true")
    args = parser.parse_args()
    bodies, primary_structure_mass = audit_bodies(args.resolved_snapshot)
    total_mass = sum(body.mass for body in bodies)
    com = sum((body.mass * body.com for body in bodies), np.zeros(3)) / total_mass
    total_inertia = np.zeros((3, 3))
    rows = []
    for body in bodies:
        offset = body.com - com
        parallel = body.mass * ((offset @ offset) * np.eye(3) - np.outer(offset, offset))
        total_inertia += body.inertia + parallel
        rows.append({
            "component": body.component, "instance": body.instance, "class": body.class_name,
            "mass_kg": body.mass, "absolute_com_m": vector(body.com),
            "local_inertia_kg_m2": matrix(body.inertia),
            "parallel_axis_contribution_kg_m2": matrix(parallel),
        })
    if not math.isfinite(total_mass) or total_mass <= 0:
        raise ValueError("invalid total mass")
    if not np.allclose(total_inertia, total_inertia.T, atol=1e-10) or np.any(np.linalg.eigvalsh(total_inertia) <= 0):
        raise ValueError("whole-spacecraft inertia tensor is not symmetric positive definite")
    args.output_dir.mkdir(parents=True, exist_ok=True)
    csv_path = args.output_dir / "mass_properties_audit.csv"
    with csv_path.open("w", encoding="utf-8-sig", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    md_path = args.output_dir / "mass_properties_audit.md"
    md_path.write_text("\n".join([
        "# 整星质量属性自动审计", "",
        "数值输入来自本次 resolved parameter snapshot；位置来自MultiBody机械连接、Body/BodyBox和FixedTranslation。Diagram/Icon坐标不参与计算。", "",
        f"- 活动刚体：{len(bodies)}", f"- 总质量：{total_mass:.12g} kg",
        f"- 质心：`{vector(com)}` m", f"- 惯量张量：`{matrix(total_inertia)}` kg·m²",
        f"- 最小惯量特征值：{float(np.min(np.linalg.eigvalsh(total_inertia))):.12g} kg·m²", "",
        "状态：PASS", "",
    ]), encoding="utf-8")
    if args.generate_record:
        record = PACKAGE_ROOT / "Scenarios" / "GeneratedMassProperties.mo"
        record.write_text(f'''within OneSatSim.Scenarios;
record GeneratedMassProperties "由机械组件离线汇总的整星质量特性"
  extends OneSatSim.Foundation.Types.MassProperties(
    modeledRigidBodyMass={total_mass:.12g},
    wheelHousingAllowance=0,
    centerOfMass={vector(com)},
    inertiaTensor={matrix(total_inertia)},
    primaryStructureMass={primary_structure_mass:.12g});
  annotation(Documentation(info="<html><p>由tools/generate_mass_properties.py从本次解析后的组件参数、活动Body/BodyBox和静态机械安装路径生成。运行时只读取常数，不执行矩阵汇总。</p></html>"));
end GeneratedMassProperties;
''', encoding="utf-8")
    print(f"mass_properties=PASS bodies={len(bodies)} mass={total_mass:.9f} kg")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
