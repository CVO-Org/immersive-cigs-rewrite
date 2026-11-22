#!/usr/bin/env python3
"""Check that every .p3d has its own CfgModels entry in a model.cfg next to it.

A model without one falls back to the engine's global CfgModels >> Default.
Other mods sometimes break that class, and then every such model spams
"No entry 'bin\\config.bin/CfgModels/default.sections'" (issue #343).

Fix a failure by copying the model.cfg from another brand's data folder,
for example addons/morley/data/model.cfg, and naming the model in it.
"""

import os
import re
import sys

ROOT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "addons")


def main():
    errors = []
    for folder, _, files in os.walk(ROOT):
        models = [os.path.splitext(f)[0] for f in files if f.lower().endswith(".p3d")]
        if not models:
            continue
        rel = os.path.relpath(folder, os.path.join(ROOT, ".."))
        cfg = os.path.join(folder, "model.cfg")
        if not os.path.isfile(cfg):
            errors.append(f"{rel}: no model.cfg for {', '.join(sorted(models))}")
            continue
        with open(cfg, encoding="utf-8", errors="ignore") as f:
            text = f.read()
        for model in sorted(models):
            if not re.search(r"\bclass\s+" + re.escape(model) + r"\s*:", text, re.IGNORECASE):
                errors.append(f"{rel}: model.cfg has no 'class {model}: ...' entry")

    for error in errors:
        print(error)
    print(f"model.cfg check: {len(errors)} problem(s)")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
