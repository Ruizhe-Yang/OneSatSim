#!/usr/bin/env python3
"""Cross-check real ASRTU packet schema, generated traceability and Modelica encoder."""
from __future__ import annotations

import csv
import sys
from collections import Counter, defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
REF = ROOT / "work" / "asrtu_refactor" / "references" / "ASRTU_Codex_Reference_Assets"
CATALOG = REF / "ASRTU_PACKET_CATALOG_CROSSCHECK.csv"
FIELDS = REF / "ASRTU_REAL_TELEMETRY_FIELDS_NORMALIZED.csv"
TRACE = ROOT / "docs" / "ASRTU_TM_TRACEABILITY.csv"
OUT = ROOT / "docs" / "TELEMETRY_SCHEMA_AUDIT.csv"
PACKER = ROOT / "NISSA_12UCubeSat" / "Foundation" / "Models" / "ASRTUTelemetryPacker.mo"
SCHEDULER = ROOT / "NISSA_12UCubeSat" / "Foundation" / "Models" / "ASRTUTelemetryScheduler.mo"
GROUND = ROOT / "NISSA_12UCubeSat" / "Foundation" / "Interfaces" / "GroundTelemetryPort.mo"
DECODER = ROOT / "NISSA_12UCubeSat" / "Foundation" / "Models" / "ASRTUGroundDecoder.mo"


def read(path: Path) -> list[dict[str, str]]:
    with path.open("r", encoding="utf-8-sig", newline="") as f:
        return list(csv.DictReader(f))


def main() -> int:
    catalog, fields, trace = read(CATALOG), read(FIELDS), read(TRACE)
    errors: list[str] = []
    if len(catalog) != 30:
        errors.append(f"packet catalog count {len(catalog)} != 30")
    if len(fields) != 2067 or len(trace) != 2067:
        errors.append(f"field/trace count {len(fields)}/{len(trace)} != 2067/2067")
    source_keys = Counter((r["packet_code"], r["byte_offset"], r["start_bit_msb"], r["field_cn"]) for r in fields)
    trace_keys = Counter((r["packet"], r["byteOffset"], r["bitPosition"], r["fieldCN"]) for r in trace)
    if source_keys != trace_keys:
        errors.append("traceability rows do not exactly cover normalized schema rows")
    valid_status = {"IMPLEMENTED", "PROTOCOL_PLACEHOLDER", "SCHEMA_ONLY", "OBC_ONLY", "CONFLICT", "MISSING"}
    unknown = sorted({r["validationStatus"] for r in trace} - valid_status)
    if unknown:
        errors.append("unknown validation statuses: " + ",".join(unknown))

    by_packet: dict[str, list[dict[str, str]]] = defaultdict(list)
    for row in trace:
        by_packet[row["packet"]].append(row)
    cat_by = {r["packet_code"]: r for r in catalog}
    rows = []
    for packet in [r["packet_code"] for r in catalog]:
        counts = Counter(r["validationStatus"] for r in by_packet.get(packet, []))
        c = cat_by[packet]
        rows.append({
            "packet": packet, "nID": c["nID_hex"], "type": c["protocol_type_hex"],
            "payload_bytes": c["schema_payload_bytes"],
            "ground_packet_bytes": c["ground_packet_bytes_if_7B_header"],
            "schema_fields": len(by_packet.get(packet, [])), "IMPLEMENTED": counts["IMPLEMENTED"],
            "PROTOCOL_PLACEHOLDER": counts["PROTOCOL_PLACEHOLDER"], "MISSING": counts["MISSING"],
            "SCHEMA_ONLY": counts["SCHEMA_ONLY"], "CONFLICT": counts["CONFLICT"],
            "OBC_ONLY": "1" if packet in {"NVE-S0", "SPT-S0", "FAM-S0"} else "0",
        })
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("w", encoding="utf-8-sig", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]))
        writer.writeheader(); writer.writerows(rows)

    packer = PACKER.read_text(encoding="utf-8-sig")
    scheduler = SCHEDULER.read_text(encoding="utf-8-sig")
    ground = GROUND.read_text(encoding="utf-8-sig")
    decoder = DECODER.read_text(encoding="utf-8-sig")
    required_packer = ["packet.rawBytes[1]:=8", "49152+schedule.sequenceCount", "schedule.payloadLength+7", "encodeFloat32BE", "for sensor in 1:32 loop"]
    for token in required_packer:
        if token not in packer:
            errors.append(f"packer missing protocol token: {token}")
    for token in ["sample(0,0.1)", "cycleTick == 5", "cycleTick == 10", "cycleTick == 15", "cycleTick == 0", "mod(pre(packetCounter)+1,16384)"]:
        if token not in scheduler:
            errors.append(f"scheduler missing Task_TM token: {token}")
    allowed_ground = {"rawBytes", "packetLength", "nID", "packetType", "sequenceCount", "sampleCount", "valid"}
    declared = set()
    for line in ground.splitlines():
        line = line.strip()
        if "IntegerSignal " in line or "BooleanSignal " in line or "Modelica.Blocks.Interfaces.IntegerInput " in line or "Modelica.Blocks.Interfaces.BooleanInput " in line:
            name = line.split()[1].split("[")[0].split("(")[0].rstrip(";")
            declared.add(name)
    if declared != allowed_ground:
        errors.append(f"GroundTelemetryPort fields {sorted(declared)} != raw packet metadata {sorted(allowed_ground)}")
    if "SOC" in decoder or "StateOfCharge" in decoder:
        errors.append("ground decoder contains forbidden SOC field")

    totals = Counter(r["validationStatus"] for r in trace)
    print(f"Schema fields={len(fields)} trace={len(trace)} statuses={dict(totals)} OBC_ONLY packets=3")
    print(f"Packet audit={OUT}")
    if errors:
        print("TELEMETRY SCHEMA CHECK FAIL")
        print("\n".join(errors))
        return 1
    print("TELEMETRY SCHEMA CHECK PASS: no untraced or invented ground fields.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
