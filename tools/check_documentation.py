from __future__ import annotations

import argparse
import re
from collections import Counter
from datetime import datetime
from pathlib import Path


DEFAULT_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_OUTPUT = Path(__file__).resolve().parents[1] / "outputs" / "documentation" / "Documentation覆盖检查结果.txt"

CLASS_RE = re.compile(
    r"(?m)^\s*(model|record|function|package|type|(?:expandable\s+)?connector)\s+([A-Za-z_]\w*)\s*(?:\"([^\"]*)\")?"
)
DOC_RE = re.compile(
    r"Documentation\s*\(\s*info\s*=\s*\"(<html>.*?</html>)\"\s*\)", re.S
)
STRING_RE = re.compile(r'\"((?:[^\"\\]|\\.)*)\"')
FORBIDDEN = {
    "特定卫星缩写": re.compile(r"ASRTU|Fenix|阿斯图", re.I),
    "来源/实物化措辞": re.compile(r"实星|真实(?:OBC|遥测|地面|卫星)|real satellite|real telemetry", re.I),
    "确认/校准来源措辞": re.compile(
        r"CONFIRMED|CALIBRATED|ASSUMPTION|confirmed from|confirmed by|calibrated from|reference snapshot|telemetry reference snapshot",
        re.I,
    ),
    "外部资料措辞": re.compile(r"用户提供(?:资料|数据)|参考资料|所给源码|given source|provided source", re.I),
}


def main() -> int:
    parser = argparse.ArgumentParser(description="检查OneSatSim的Documentation覆盖率和中性措辞")
    parser.add_argument("--root", type=Path, default=DEFAULT_ROOT)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    args = parser.parse_args()

    files = sorted(args.root.rglob("*.mo"), key=lambda p: p.as_posix().lower())
    missing: list[str] = []
    short_docs: list[str] = []
    invalid_html: list[str] = []
    forbidden_hits: list[str] = []
    class_types: Counter[str] = Counter()
    docs: list[str] = []

    for path in files:
        rel = path.relative_to(args.root).as_posix()
        text = path.read_text(encoding="utf-8-sig")
        class_match = CLASS_RE.search(text)
        if not class_match:
            missing.append(f"{rel}（未找到顶层类声明）")
            continue
        class_kind = class_match.group(1)
        class_types["connector" if class_kind.endswith("connector") else class_kind] += 1
        doc_match = DOC_RE.search(text)
        if not doc_match:
            missing.append(rel)
        else:
            doc = doc_match.group(1)
            docs.append(doc)
            plain = re.sub(r"<[^>]+>", "", doc).strip()
            if len(plain) < 140:
                short_docs.append(f"{rel}（正文{len(plain)}字符）")
            if not (doc.startswith("<html>") and doc.endswith("</html>")):
                invalid_html.append(rel)

        # Only quoted strings are human-visible in this package: class/variable
        # descriptions, Documentation HTML, and Icon/Diagram textString values.
        for match in STRING_RE.finditer(text):
            value = match.group(1)
            line = text.count("\n", 0, match.start()) + 1
            for label, pattern in FORBIDDEN.items():
                if pattern.search(value):
                    excerpt = re.sub(r"\s+", " ", value)[:120]
                    forbidden_hits.append(f"{rel}:{line} [{label}] {excerpt}")

    duplicate_count = len(docs) - len(set(docs))
    total = len(files)
    with_docs = total - len([m for m in missing if "未找到" not in m])
    coverage = 100.0 * with_docs / total if total else 0.0
    # Coverage and valid HTML are hard requirements.  Short or intentionally
    # shared text is advisory for compact connectors, types and generated
    # configuration records; domain names in inactive compatibility classes are
    # likewise reported for review rather than misclassified as missing docs.
    passed = not missing and not invalid_html

    lines = [
        "12U CubeSat Modelica Documentation覆盖检查",
        f"检查时间: {datetime.now().isoformat(timespec='seconds')}",
        f"扫描根目录: {args.root}",
        f"MO文件总数: {total}",
        f"类类型统计: package={class_types['package']}, model={class_types['model']}, connector={class_types['connector']}, function={class_types['function']}",
        f"含Documentation文件数: {with_docs}",
        f"缺少Documentation文件数: {len(missing)}",
        f"Documentation覆盖率: {coverage:.1f}%",
        f"简短Documentation提示数量: {len(short_docs)}",
        f"HTML结构异常数量: {len(invalid_html)}",
        f"共享Documentation提示数量: {duplicate_count}",
        f"术语复核提示数量: {len(forbidden_hits)}",
        f"最终结论: {'PASS' if passed else 'FAIL'}",
    ]
    for title, items in (
        ("缺失项", missing),
        ("简短项（提示）", short_docs),
        ("HTML异常", invalid_html),
        ("术语复核（提示）", forbidden_hits),
    ):
        if items:
            lines.extend(["", title + ":", *["- " + item for item in items]])

    report = "\n".join(lines) + "\n"
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(report, encoding="utf-8")
    print(report, end="")
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
