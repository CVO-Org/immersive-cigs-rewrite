#!/usr/bin/env python3
"""
Syncs the labels of the current repo with .github/labels.yml
Used by .github/workflows/sync_labels.yml

- creates missing labels, updates name case / color / description of existing ones
- if settings.remove_unlisted is true, deletes every label that is not listed
- --dry-run only prints what would happen

Requires the gh cli (preinstalled on github runners, auth via GH_TOKEN) and pyyaml
"""

import argparse
import json
import re
import subprocess
import sys

import yaml

CONFIG = ".github/labels.yml"


def gh(*args):
    return subprocess.run(["gh", *args], check=True, capture_output=True, text=True).stdout


def load_config():
    with open(CONFIG, encoding="utf-8") as f:
        config = yaml.safe_load(f) or {}

    remove_unlisted = (config.get("settings") or {}).get("remove_unlisted", False)
    if not isinstance(remove_unlisted, bool):
        sys.exit(f"❌ settings.remove_unlisted must be true or false, got: {remove_unlisted!r}")

    labels = []
    for entry in config.get("labels") or []:
        name = entry.get("name")
        color = entry.get("color")
        if not name:
            sys.exit(f"❌ Label without name: {entry}")
        if not isinstance(color, str) or not re.fullmatch(r"#?[0-9a-fA-F]{6}", color):
            sys.exit(f"❌ Label '{name}' needs a quoted 6 digit hex color, got: {color!r}")
        labels.append({
            "name": name,
            "color": color.lstrip("#").lower(),
            "description": entry.get("description") or "",
        })

    return labels, remove_unlisted


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--dry-run", action="store_true", help="only print what would change")
    args = parser.parse_args()
    prefix = "[DRY RUN] " if args.dry_run else ""

    labels, remove_unlisted = load_config()
    existing = {
        label["name"].lower(): label
        for label in json.loads(gh("label", "list", "--limit", "1000", "--json", "name,color,description"))
    }

    print(f"📊 {len(labels)} labels listed, {len(existing)} labels in repo, remove_unlisted: {remove_unlisted}")

    for label in labels:
        current = existing.get(label["name"].lower())

        if current is None:
            print(f"{prefix}✅ Create: {label['name']}")
            if not args.dry_run:
                gh("label", "create", label["name"], "--color", label["color"], "--description", label["description"])
            continue

        if (current["name"], current["color"].lower(), current["description"] or "") == (label["name"], label["color"], label["description"]):
            print(f"✔️ Unchanged: {label['name']}")
            continue

        print(f"{prefix}✏️ Update: {label['name']}")
        if not args.dry_run:
            gh("label", "edit", current["name"], "--name", label["name"], "--color", label["color"], "--description", label["description"])

    if remove_unlisted:
        listed = {label["name"].lower() for label in labels}
        for key, current in existing.items():
            if key in listed:
                continue
            print(f"{prefix}🗑️ Delete: {current['name']}")
            if not args.dry_run:
                gh("label", "delete", current["name"], "--yes")


if __name__ == "__main__":
    main()
