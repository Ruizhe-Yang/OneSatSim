#!/usr/bin/env python3
"""Generate ASRTU-1 telemetry catalog, byte helpers, and traceability.

The normalized decoder schema and packet cross-check CSVs are the only source of
packet names, identifiers, lengths and field coordinates.  The generated
Modelica code has no runtime dependency on Python or on an external file.
"""
from __future__ import annotations

import csv
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
REF = ROOT / "work" / "asrtu_refactor" / "references" / "ASRTU_Codex_Reference_Assets"
CATALOG = REF / "ASRTU_PACKET_CATALOG_CROSSCHECK.csv"
FIELDS = REF / "ASRTU_REAL_TELEMETRY_FIELDS_NORMALIZED.csv"
TYPES = ROOT / "Foundation" / "Types"
FUNCS = ROOT / "Foundation" / "Functions"
DOCS = ROOT / "docs"


def read_csv(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def integer(text: str) -> int:
    text = (text or "0").strip()
    if text.lower().startswith("0x"):
        return int(text, 16)
    if re.fullmatch(r"[0-9A-Fa-f]{2,8}", text) and re.search(r"[A-Fa-f]", text):
        return int(text, 16)
    return int(float(text))


def quote(text: str) -> str:
    return '"' + (text or "").replace("\\", "\\\\").replace('"', '\\"') + '"'


def write(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text.replace("\n", "\r\n"), encoding="utf-8")


def generate_catalog(rows: list[dict[str, str]]) -> None:
    names = [r["packet_code"] for r in rows]
    nid = [integer(r["nID_hex"]) for r in rows]
    ptype = [integer(r["protocol_type_hex"]) for r in rows]
    payload = [integer(r["schema_payload_bytes"]) for r in rows]
    ground = [integer(r["ground_packet_bytes_if_7B_header"]) for r in rows]
    schema_only = {"SAT-S6", "SAT-S7", "SAT-S8", "SAT-S9", "TTC-S1", "TTC-S2"}
    opaque_names = {"NVE-S0", "SPT-S0", "FAM-S0"}
    scheduled = ["false" if r["packet_code"] in schema_only | opaque_names else "true" for r in rows]
    opaque = ["true" if r["packet_code"] in opaque_names else "false" for r in rows]
    content = f'''within OneSatSim.Foundation.Types;
package TelemetryCatalog "ASRTU-1真实遥测包目录（生成文件）"
  constant Integer packetCount={len(rows)};
  constant String packetCode[packetCount]={{{','.join(map(quote, names))}}};
  constant Integer nID[packetCount]={{{','.join(map(str, nid))}}};
  constant Integer packetType[packetCount]={{{','.join(map(str, ptype))}}};
  constant Integer payloadLength[packetCount]={{{','.join(map(str, payload))}}};
  constant Integer groundLength[packetCount]={{{','.join(map(str, ground))}}};
  constant Boolean scheduled[packetCount]={{{','.join(scheduled)}}};
  constant Boolean obcOnlyOpaque[packetCount]={{{','.join(opaque)}}};
  annotation(Documentation(info="<html><p>由真实地面解码CSV与OBC组包源码交叉核对生成。SAT-S6..S9、TTC-S1/S2仅保留模式定义；NVE/SPT/FAM为OBC侧不透明包。</p></html>"));
end TelemetryCatalog;
'''
    write(TYPES / "TelemetryCatalog.mo", content)


FUNCTIONS: dict[str, str] = {
"encodeUInt8.mo": '''within OneSatSim.Foundation.Functions;
function encodeUInt8
  input Integer value;
  output Integer byte;
algorithm
  byte := mod(max(0, min(255, value)), 256);
end encodeUInt8;
''',
"decodeUInt8.mo": '''within OneSatSim.Foundation.Functions;
function decodeUInt8
  input Integer byte;
  output Integer value;
algorithm
  value := mod(byte, 256);
end decodeUInt8;
''',
"encodeInt8.mo": '''within OneSatSim.Foundation.Functions;
function encodeInt8
  input Integer value;
  output Integer byte;
algorithm
  byte := if value < 0 then 256 + max(-128, value) else min(127, value);
end encodeInt8;
''',
"decodeInt8.mo": '''within OneSatSim.Foundation.Functions;
function decodeInt8
  input Integer byte;
  output Integer value;
algorithm
  value := if mod(byte, 256) >= 128 then mod(byte, 256) - 256 else mod(byte, 256);
end decodeInt8;
''',
"encodeUInt16BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeUInt16BE
  input Integer value;
  output Integer bytes[2];
protected
  Integer v;
algorithm
  v := max(0, min(65535, value));
  bytes := {div(v,256), mod(v,256)};
end encodeUInt16BE;
''',
"decodeUInt16BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeUInt16BE
  input Integer bytes[2];
  output Integer value;
algorithm
  value := 256*mod(bytes[1],256) + mod(bytes[2],256);
end decodeUInt16BE;
''',
"encodeInt16BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeInt16BE
  input Integer value;
  output Integer bytes[2];
protected
  Integer v;
algorithm
  v := if value < 0 then 65536 + max(-32768,value) else min(32767,value);
  bytes := OneSatSim.Foundation.Functions.encodeUInt16BE(v);
end encodeInt16BE;
''',
"decodeInt16BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeInt16BE
  input Integer bytes[2];
  output Integer value;
protected
  Integer u;
algorithm
  u := OneSatSim.Foundation.Functions.decodeUInt16BE(bytes);
  value := if u >= 32768 then u - 65536 else u;
end decodeInt16BE;
''',
"encodeUInt24BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeUInt24BE
  input Integer value;
  output Integer bytes[3];
protected Integer v;
algorithm
  v := min(16777215,max(0,value));
  bytes := {mod(div(v,65536),256),mod(div(v,256),256),mod(v,256)};
end encodeUInt24BE;
''',
"decodeUInt24BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeUInt24BE
  input Integer bytes[3];
  output Integer value;
algorithm
  value := mod(bytes[1],256)*65536+mod(bytes[2],256)*256+mod(bytes[3],256);
end decodeUInt24BE;
''',
"encodeInt24BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeInt24BE
  input Integer value;
  output Integer bytes[3];
protected Integer limited; Integer raw;
algorithm
  limited := min(8388607,max(-8388608,value));
  raw := if limited < 0 then 16777216+limited else limited;
  bytes := OneSatSim.Foundation.Functions.encodeUInt24BE(raw);
end encodeInt24BE;
''',
"decodeInt24BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeInt24BE
  input Integer bytes[3];
  output Integer value;
protected Integer raw;
algorithm
  raw := OneSatSim.Foundation.Functions.decodeUInt24BE(bytes);
  value := if raw >= 8388608 then raw-16777216 else raw;
end decodeInt24BE;
''',
"encodeUInt32BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeUInt32BE
  input Integer value;
  output Integer bytes[4];
protected
  Integer v;
algorithm
  v := max(0,value);
  bytes := {mod(div(v,16777216),256),mod(div(v,65536),256),mod(div(v,256),256),mod(v,256)};
end encodeUInt32BE;
''',
"decodeUInt32BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeUInt32BE
  input Integer bytes[4];
  output Integer value;
algorithm
  value := 16777216*mod(bytes[1],256) + 65536*mod(bytes[2],256) + 256*mod(bytes[3],256) + mod(bytes[4],256);
end decodeUInt32BE;
''',
"encodeInt32BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeInt32BE
  input Integer value;
  output Integer bytes[4];
protected
  Integer v;
algorithm
  v := if value < 0 then 4294967296 + max(-2147483648,value) else min(2147483647,value);
  bytes := OneSatSim.Foundation.Functions.encodeUInt32BE(v);
end encodeInt32BE;
''',
"decodeInt32BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeInt32BE
  input Integer bytes[4];
  output Integer value;
protected
  Integer u;
algorithm
  u := OneSatSim.Foundation.Functions.decodeUInt32BE(bytes);
  value := if u >= 2147483648 then u - 4294967296 else u;
end decodeInt32BE;
''',
"encodeFloat32BE.mo": '''within OneSatSim.Foundation.Functions;
function encodeFloat32BE "IEEE-754 binary32, big-endian"
  input Real value;
  output Integer bytes[4];
protected
  Real a;
  Integer signBit;
  Integer exponent;
  Integer mantissa;
  Integer word;
algorithm
  if value == 0 then
    word := 0;
  else
    signBit := if value < 0 then 1 else 0;
    a := abs(value);
    exponent := integer(floor(log(a)/log(2)));
    mantissa := integer(floor((a/2.0^exponent - 1.0)*8388608.0 + 0.5));
    if mantissa >= 8388608 then
      mantissa := 0;
      exponent := exponent + 1;
    end if;
    word := signBit*2147483648 + (exponent + 127)*8388608 + mantissa;
  end if;
  bytes := OneSatSim.Foundation.Functions.encodeUInt32BE(word);
end encodeFloat32BE;
''',
"decodeFloat32BE.mo": '''within OneSatSim.Foundation.Functions;
function decodeFloat32BE "IEEE-754 binary32, big-endian"
  input Integer bytes[4];
  output Real value;
protected
  Integer word;
  Integer signBit;
  Integer exponentBits;
  Integer mantissa;
algorithm
  word := OneSatSim.Foundation.Functions.decodeUInt32BE(bytes);
  signBit := div(word,2147483648);
  exponentBits := mod(div(word,8388608),256);
  mantissa := mod(word,8388608);
  if exponentBits == 0 then
    value := (if signBit == 1 then -1.0 else 1.0)*(mantissa/8388608.0)*2.0^(-126);
  else
    value := (if signBit == 1 then -1.0 else 1.0)*(1.0 + mantissa/8388608.0)*2.0^(exponentBits - 127);
  end if;
end decodeFloat32BE;
''',
}


def generate_functions() -> None:
    for name, text in FUNCTIONS.items():
        write(FUNCS / name, text)


SCHEMA_ONLY = {"SAT-S6", "SAT-S7", "SAT-S8", "SAT-S9", "TTC-S1", "TTC-S2"}
OBC_ONLY = {"NVE-S0", "SPT-S0", "FAM-S0"}


def in_range(offset: int, ranges: list[tuple[int, int]]) -> bool:
    return any(lo <= offset <= hi for lo, hi in ranges)


def implemented_field(packet: str, offset: int) -> bool:
    ranges = {
        "SAT-S0": [(0, 54), (200, 200)],
        "SAT-S1": [(0, 11), (52, 193), (200, 200)],
        "SAT-S2": [(0, 163), (200, 200)],
        "SAT-S3": [(0, 11), (49, 52), (68, 71), (194, 195), (200, 200)],
        "PDB-S0": [(0, 62), (73, 109), (118, 118)],
        "TCB-S0": [(0, 62), (64, 123), (134, 134)],
    }
    if packet in ranges:
        return in_range(offset, ranges[packet])
    if packet == "ZGK-S0":
        if in_range(offset, [(0, 11), (197, 197)]):
            return True
        for wheel in range(4):
            base = 12 + 15 * wheel
            if offset in {base, base + 1, base + 6, base + 10}:
                return True
        return False
    # For other current-flight packets only the real packet envelope and tail
    # are produced; unpublished/private values remain zero by design.
    return False


def modelica_source(packet: str, field_cn: str, offset: int) -> str:
    rules = [
        ("配电开关", "state.pdState"), ("热控开关", "state.tcState"),
        ("母线电压", "state.busVoltage"), ("母线电流", "state.busCurrent"),
        ("MPPT", "state.mpptVoltage/state.mpptCurrent"),
        ("分阵", "state.mpptVoltage"), ("充电器", "state.chargerVoltage/state.chargerCurrent"),
        ("配电", "state.pdCurrent/state.pdState"), ("热控", "state.tcCurrent/state.tcState"),
        ("热敏", "state.thermistorTemperature"), ("温度上限", "state.heaterUpper"),
        ("温度下限", "state.heaterLower"), ("飞轮", "state.wheelSpeed/state.wheelCurrent"),
        ("星敏", "state.starQuaternion/state.starAngularVelocity/state.starStatus"),
        ("光纤陀螺", "state.yh50Rate"), ("GPS", "state.gnssPosition/state.gnssVelocity"),
        ("GNSS", "state.gnssPosition/state.gnssVelocity"), ("磁强计", "state.magneticField"),
        ("MEMS", "state.mems"), ("太敏", "state.sunAngle"),
        ("OBC时间", "state.bootSeconds/state.milliseconds"), ("UTC时间", "state.bootSeconds"),
        ("CPU温度", "state.cpuTemperature"), ("板温", "state.boardTemperature"),
    ]
    for token, source in rules:
        if token in field_cn:
            return source
    if offset == 0:
        return "schedule.nID or device payload byte 0"
    if offset == 1:
        return "schedule.packetType or device payload byte 1"
    return ""


def encoder_for(row: dict[str, str]) -> str:
    width = integer(row["bit_width"])
    conv = row.get("conversion", "")
    raw = row.get("raw_type_hint", "")
    signed = "SX" in conv or raw.upper().startswith("S")
    if width < 8:
        return "bit-pack"
    if "FX" in conv or raw.upper().startswith("F"):
        return "encodeFloat32BE"
    if width == 8:
        return "encodeInt8" if signed else "encodeUInt8"
    if width == 16:
        return "encodeInt16BE" if signed else "encodeUInt16BE"
    if width == 24:
        return "encodeInt24BE" if signed else "encodeUInt24BE"
    if width == 32:
        return "encodeInt32BE" if signed else "encodeUInt32BE"
    return "raw-byte-array"


def generate_traceability(fields: list[dict[str, str]], catalog: list[dict[str, str]]) -> None:
    cat = {r["packet_code"]: r for r in catalog}
    out_path = DOCS / "ASRTU_TM_TRACEABILITY.csv"
    out_path.parent.mkdir(parents=True, exist_ok=True)
    columns = [
        "packet", "component", "nID", "type", "payloadLength", "byteOffset",
        "bitPosition", "bitWidth", "fieldCN", "fieldEN", "conversion", "rawType",
        "unit", "enumDefinition", "OBCSourceVariable", "OBCSourceExpression",
        "ModelicaSourceVariable", "encoderFunction", "implemented", "validationStatus",
        "scheduleStatus", "evidence", "notes"
    ]
    with out_path.open("w", encoding="utf-8-sig", newline="") as f:
        w = csv.DictWriter(f, fieldnames=columns)
        w.writeheader()
        for row in fields:
            packet = row["packet_code"]
            c = cat.get(packet, {})
            offset = integer(row.get("byte_offset", "0"))
            is_impl = implemented_field(packet, offset)
            issue = row.get("schema_issue", "")
            if packet in SCHEMA_ONLY:
                validation = "SCHEMA_ONLY"
                schedule = "not_scheduled_version_reference"
            elif packet in OBC_ONLY:
                validation = "OBC_ONLY"
                schedule = "not_scheduled_opaque"
            elif issue:
                validation = "CONFLICT"
                schedule = "scheduled_or_slow_arbitrated"
            elif is_impl:
                validation = "IMPLEMENTED"
                schedule = "scheduled_or_slow_arbitrated"
            else:
                validation = "PROTOCOL_PLACEHOLDER"
                schedule = "scheduled_or_slow_arbitrated"
            source = modelica_source(packet, row.get("field_cn", ""), offset) if is_impl else ""
            record = {
                "packet": packet, "component": row.get("component", ""),
                "nID": c.get("nID_hex", ""), "type": c.get("protocol_type_hex", ""),
                "payloadLength": c.get("schema_payload_bytes", ""),
                "byteOffset": row.get("byte_offset", ""), "bitPosition": row.get("start_bit_msb", ""),
                "bitWidth": row.get("bit_width", ""), "fieldCN": row.get("field_cn", ""),
                "fieldEN": row.get("field_en", ""), "conversion": row.get("conversion", ""),
                "rawType": row.get("raw_type_hint", ""), "unit": row.get("unit_hint", ""),
                "enumDefinition": row.get("enum_definition", ""),
                "OBCSourceVariable": "LOS global/device state (exact symbol not proven)" if is_impl else "",
                "OBCSourceExpression": "LOS_TM_Pack* byte position cross-check" if is_impl else "",
                "ModelicaSourceVariable": source, "encoderFunction": encoder_for(row),
                "implemented": "TRUE" if is_impl else "FALSE", "validationStatus": validation,
                "scheduleStatus": schedule,
                "evidence": "ground decoder CSV + LOS_TM.c + LOS_TASK.c",
                "notes": (issue + ("; " if issue else "") +
                          ("Raw bytes/scale implemented" if is_impl else
                           "Schema retained; unresolved value is zero, not invented")),
            }
            w.writerow(record)


def package_order() -> None:
    names = [Path(name).stem for name in FUNCTIONS]
    order = ["clamp", *names]
    write(FUNCS / "package.order", "\n".join(order) + "\n")


def main() -> None:
    catalog = read_csv(CATALOG)
    fields = read_csv(FIELDS)
    generate_catalog(catalog)
    generate_functions()
    generate_traceability(fields, catalog)
    package_order()
    print(f"generated {len(catalog)} packets and {len(fields)} field traceability rows")


if __name__ == "__main__":
    main()
