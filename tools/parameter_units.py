"""NISSA 设计配置的集中单位转换与 Modelica 字面量格式化。"""

from __future__ import annotations

import math
from typing import Any


class UnitConversionError(ValueError):
    """表示工作簿单位或数值无法转换。"""


_LINEAR_FACTORS = {
    "1": 1.0,
    "-": 1.0,
    "m": 1.0,
    "m/s": 1.0,
    "km": 1000.0,
    "m²": 1.0,
    "m2": 1.0,
    "kg": 1.0,
    "kg/m³": 1.0,
    "kg/m3": 1.0,
    "kg·m²": 1.0,
    "kg*m2": 1.0,
    "s": 1.0,
    "V": 1.0,
    "A": 1.0,
    "W": 1.0,
    "Ω": 1.0,
    "ohm": 1.0,
    "J/K": 1.0,
    "W/K": 1.0,
    "K/W": 1.0,
    "rad": 1.0,
    "deg": math.pi / 180.0,
    "rad/s": 1.0,
    "deg/s": math.pi / 180.0,
    "rpm": 2.0 * math.pi / 60.0,
    "N·m": 1.0,
    "N*m": 1.0,
    "N·m·s/rad": 1.0,
    "N*m*s/rad": 1.0,
    "A·m²/A": 1.0,
    "Ah": 3600.0,
    "byte": 1.0,
    "byte/s": 1.0,
    "B/s": 1.0,
    "MB/s": 1.0e6,
    "GB": 1.0e9,
    "min": 60.0,
    "h": 3600.0,
}


def parse_boolean(value: Any) -> bool:
    """接受 Excel 常见布尔写法并返回 bool。"""
    if isinstance(value, bool):
        return value
    if isinstance(value, (int, float)) and value in (0, 1):
        return bool(value)
    token = str(value or "").strip().lower()
    if token in {"true", "1", "yes", "y", "是", "启用"}:
        return True
    if token in {"false", "0", "no", "n", "否", "禁用"}:
        return False
    raise UnitConversionError(f"expected TRUE/FALSE, got {value!r}")


def parse_number(value: Any) -> float:
    """读取有限实数，拒绝空值、NaN 和无穷大。"""
    if value is None or (isinstance(value, str) and not value.strip()):
        raise UnitConversionError("numeric value is blank")
    try:
        result = float(value)
    except (TypeError, ValueError) as exc:
        raise UnitConversionError(f"expected numeric value, got {value!r}") from exc
    if not math.isfinite(result):
        raise UnitConversionError(f"value must be finite, got {value!r}")
    return result


def to_si(value: Any, unit: str) -> Any:
    """把工作簿工程单位转换为 Modelica 内部 SI/约定单位。"""
    unit = str(unit or "").strip()
    if unit == "Boolean":
        return parse_boolean(value)
    if unit == "degC":
        return parse_number(value) + 273.15
    if unit == "K":
        return parse_number(value)
    if unit not in _LINEAR_FACTORS:
        raise UnitConversionError(f"unsupported unit {unit!r}")
    return parse_number(value) * _LINEAR_FACTORS[unit]


def from_si(value: Any, unit: str) -> Any:
    """把 SI 值换回工作簿单位，仅用于默认值一致性审计。"""
    unit = str(unit or "").strip()
    if unit == "Boolean":
        return bool(value)
    if unit == "degC":
        return float(value) - 273.15
    if unit == "K":
        return float(value)
    if unit not in _LINEAR_FACTORS:
        raise UnitConversionError(f"unsupported unit {unit!r}")
    return float(value) / _LINEAR_FACTORS[unit]


def modelica_literal(value: Any) -> str:
    """返回跨 OpenModelica/MWorks 可读的标量 Modelica 字面量。"""
    if isinstance(value, bool):
        return "true" if value else "false"
    if isinstance(value, int):
        return str(value)
    if isinstance(value, float):
        if not math.isfinite(value):
            raise UnitConversionError("non-finite value cannot be emitted")
        return repr(float(value))
    escaped = str(value).replace("\\", "\\\\").replace('"', '\\"')
    return f'"{escaped}"'


def values_equal(left: Any, right: Any, *, atol: float = 1e-10, rtol: float = 1e-9) -> bool:
    """比较解析后的默认值，布尔/字符串按值比较，数值按容差比较。"""
    if isinstance(left, bool) or isinstance(right, bool):
        return bool(left) is bool(right)
    if isinstance(left, str) or isinstance(right, str):
        return str(left) == str(right)
    return math.isclose(float(left), float(right), abs_tol=atol, rel_tol=rtol)
