#!/usr/bin/env python3
"""
Stringtable Diagnostic Tool (Enhanced Recursive Version)
--------------------------------------------------------
Scans all addon and sub-addon stringtable.xml files,
detects missing translations, and generates a clean Markdown report
for GitHub issue updates.

Usage:
  python tools/stringtablediag.py
  python tools/stringtablediag.py --markdown
"""

import os
import sys
import traceback
from xml.dom import minidom


def find_stringtable_files(base_path):
    """Recursively find all stringtable.xml files under the given path."""
    stringtables = []
    for root, dirs, files in os.walk(base_path):
        for file in files:
            if file.lower() == "stringtable.xml":
                relpath = os.path.relpath(root, base_path)
                stringtables.append((relpath, os.path.join(root, file)))
    return stringtables


def parse_languages(xmldoc):
    """Extract all language tags from a parsed XML document."""
    languages = set()
    for key in xmldoc.getElementsByTagName("Key"):
        for node in key.childNodes:
            if node.nodeType == node.ELEMENT_NODE:
                languages.add(node.tagName)
    return languages


def analyze_module(module_name, filepath, all_languages):
    """Analyze one module's stringtable and count missing keys."""
    try:
        xmldoc = minidom.parse(filepath)
    except Exception:
        print(f"⚠️  Skipping malformed XML in {module_name}")
        return 0, {lang: {"count": 0, "missing_keys": []} for lang in all_languages}

    keys = xmldoc.getElementsByTagName("Key")
    total_keys = len(keys)
    result = {lang: {"count": 0, "missing_keys": []} for lang in all_languages}

    for key in keys:
        key_id = key.getAttribute("ID") or "UNKNOWN_KEY"
        present_langs = [node.tagName for node in key.childNodes if node.nodeType == node.ELEMENT_NODE]
        for lang in all_languages:
            if lang in present_langs:
                result[lang]["count"] += 1
            else:
                result[lang]["missing_keys"].append(key_id)

    return total_keys, result


def generate_markdown_report(stats, all_languages):
    """Generate Markdown report with collapsible sections per language."""
    total_keys = sum(module["total_keys"] for module in stats.values())

    # --- Summary table ---
    summary = []
    summary.append(f"Total number of keys: {total_keys}\n")
    summary.append("| Language | Missing Entries | Modules Affected | % done |")
    summary.append("|----------|----------------:|------------------|--------|")

    language_missing_totals = {lang: 0 for lang in all_languages}
    language_modules_missing = {lang: [] for lang in all_languages}

    for module, data in stats.items():
        for lang in all_languages:
            missing = data["total_keys"] - data["languages"][lang]["count"]
            if missing > 0:
                language_missing_totals[lang] += missing
                language_modules_missing[lang].append(module)

    for lang in all_languages:
        done_percent = 100
        if total_keys > 0:
            done_percent = round(100 * (total_keys - language_missing_totals[lang]) / total_keys)
        modules_affected = ", ".join(language_modules_missing[lang]) if language_modules_missing[lang] else "-"
        summary.append(f"| {lang} | {language_missing_totals[lang]} | {modules_affected} | {done_percent}% |")

    # --- Per-module coverage table ---
    module_table = []
    module_table.append("\n### Per-Module Coverage")
    header = "| Module | Total Keys | " + " | ".join(all_languages) + " |"
    separator = "|---------|" + "|".join(["------------:" for _ in range(len(all_languages) + 1)]) + "|"
    module_table.append(header)
    module_table.append(separator)

    for module, data in sorted(stats.items()):
        row = [module, str(data["total_keys"])]
        for lang in all_languages:
            row.append(str(data["languages"][lang]["count"]))
        module_table.append("| " + " | ".join(row) + " |")

    # --- Detailed per-language sections ---
    details = ["\n---\n### Missing Translations\n"]

    for lang in all_languages:
        missing_total = language_missing_totals[lang]
        details.append(f"<details>\n<summary>🌐 {lang} – {missing_total} missing</summary>\n")

        # Group by module, show missing keys
        for module, data in sorted(stats.items()):
            missing_keys = data["languages"][lang]["missing_keys"]
            if not missing_keys:
                continue
            details.append(f"- **{module}**")
            for key in missing_keys:
                details.append(f"  - {key}")
            details.append("")  # spacer

        details.append("</details>\n")

    return "\n".join(summary + module_table + details)


def main():
    script_dir = os.path.dirname(os.path.realpath(__file__))
    project_root = os.path.abspath(os.path.join(script_dir, os.pardir))
    addons_path = os.path.join(project_root, "addons")

    if not os.path.isdir(addons_path):
        print("❌ 'addons' directory not found.")
        sys.exit(1)

    stringtables = find_stringtable_files(addons_path)
    if not stringtables:
        print("⚠️ No stringtable.xml files found.")
        sys.exit(0)

    # Collect all languages
    all_languages = set()
    for _, path in stringtables:
        try:
            xmldoc = minidom.parse(path)
            all_languages.update(parse_languages(xmldoc))
        except Exception:
            continue
    all_languages = sorted(all_languages)

    if not all_languages:
        print("⚠️ No languages found in any stringtable.")
        sys.exit(0)

    stats = {}
    for module, path in stringtables:
        total_keys, lang_data = analyze_module(module, path, all_languages)
        if total_keys > 0:
            stats[module] = {"total_keys": total_keys, "languages": lang_data}

    if "--markdown" in sys.argv:
        print(generate_markdown_report(stats, all_languages))
    else:
        print("Languages detected:", ", ".join(all_languages))
        print("\nUse `--markdown` to output the report for GitHub issues.")
        print("\n---\n")
        print(generate_markdown_report(stats, all_languages))


if __name__ == "__main__":
    try:
        main()
    except Exception:
        print("❌ Unexpected error:")
        print(traceback.format_exc())
        sys.exit(1)
