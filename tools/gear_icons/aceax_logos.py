#!/usr/bin/env python3
"""
Cuts each cigarette and cigar brand's flat pack or box front out of its texture, for the
brand buttons of ACE Arsenal Extended (addons/base/aceax.hpp and addons/cigars/aceax.hpp,
centerImage).

- aceax_logo_ca: 256x256, the pack / box front, centered on a transparent square

Reads the texture of every brand in the models' values[]: addons/<brand>/data/texture.paa
for cigarettes, addons/<brand>/data/cigarbox_5/cigarbox_5_co.paa for cigars.
Without --apply it only writes PNGs and a preview sheet (the buttons as AAE draws them);
with --apply it also converts them to PAA in addons/<brand>/data/UI/.

Requires Pillow (pip install pillow) and hemtt on PATH.
"""

import argparse
import os
import re
import sys
import tempfile

from PIL import Image, ImageDraw, ImageFont

from gear_icons import PACK_FRONT, hemtt_convert

SIZE = 256
BOX_FRONT = (10, 440, 368, 1014)  # cigarbox_5.p3d's front face in texture pixels (cigar_icons.py layout)

# kind: (model file, texture inside addons/<brand>/data, front face of 1024 px)
KINDS = {
    "cigarette": (os.path.join("addons", "base", "aceax.hpp"), "texture.paa", PACK_FRONT),
    "cigar": (os.path.join("addons", "cigars", "aceax.hpp"), os.path.join("cigarbox_5", "cigarbox_5_co.paa"), BOX_FRONT),
}
SKIP = {"savage"}  # its pack is S.O.G.'s (no texture here); its button keeps a text label


def brands(model):
    with open(model, encoding="utf-8") as f:
        text = f.read()
    values = re.search(r'class brand \{.*?values\[\] = \{([^}]*)\}', text, re.S).group(1)
    return [v for v in re.findall(r'"(\w+)"', values) if v not in SKIP]


def logo(tex, face):
    k = tex.width / 1024
    u0, v0, u1, v1 = (round(c * k) for c in face)
    front = tex.crop((u0, v0, u1, v1)).convert("RGBA")
    scale = SIZE / max(front.size)
    front = front.resize((round(front.width * scale), round(front.height * scale)), Image.LANCZOS)
    out = Image.new("RGBA", (SIZE, SIZE), (0, 0, 0, 0))
    out.paste(front, ((SIZE - front.width) // 2, (SIZE - front.height) // 2))
    return out


def preview_sheet(logos, path, cols=4):
    # an AAE value button is 20x10 grid units, the centered image a square of its height
    bw, bh, gap = 240, 120, 6
    rows = max(1, (len(logos) + cols - 1) // cols)
    sheet = Image.new("RGB", (cols * (bw + gap) + gap, rows * (bh + gap) + gap), (24, 24, 24))
    draw = ImageDraw.Draw(sheet)
    try:
        font = ImageFont.truetype("arial.ttf", 13)
    except OSError:
        font = ImageFont.load_default()
    for i, (name, img) in enumerate(logos):
        x = gap + (i % cols) * (bw + gap)
        y = gap + (i // cols) * (bh + gap)
        draw.rectangle((x, y, x + bw, y + bh), fill=(40, 40, 40))
        icon = img.resize((bh, bh), Image.LANCZOS)
        sheet.paste(icon, (x + (bw - bh) // 2, y), icon)
        draw.text((x + 4, y + bh - 16), name, fill=(150, 150, 150), font=font)
    sheet.save(path)


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--out", default=os.path.join(".hemttout", "aceax_logos"), help="where the PNGs and the sheet go")
    ap.add_argument("--apply", action="store_true", help="also write addons/<brand>/data/UI/aceax_logo_ca.paa")
    ap.add_argument("--only", nargs="+", metavar="BRAND", help="only these brands (default: every brand in the models)")
    args = ap.parse_args()
    for model, _, _ in KINDS.values():
        if not os.path.exists(model):
            sys.exit(f"{model} not found (run this from the repository root)")
    os.makedirs(args.out, exist_ok=True)

    todo = [(brand, kind) for kind, (model, _, _) in KINDS.items() for brand in brands(model)]
    if args.only:
        missing = set(args.only) - {b for b, _ in todo}
        if missing:
            sys.exit(f"not in any model's values[]: {', '.join(sorted(missing))}")
        todo = [(b, k) for b, k in todo if b in args.only]

    logos = []
    with tempfile.TemporaryDirectory() as tmp:
        for brand, kind in todo:
            _, tex_rel, face = KINDS[kind]
            tex_paa = os.path.join("addons", brand, "data", tex_rel)
            if not os.path.exists(tex_paa):
                print(f"skip {brand}: no {tex_paa}")
                continue
            tex_png = os.path.join(tmp, brand + ".png")
            hemtt_convert(tex_paa, tex_png)
            img = logo(Image.open(tex_png), face)
            png = os.path.join(args.out, f"{brand}_aceax_logo_ca.png")
            img.save(png)
            logos.append((brand, img))
            if args.apply:
                hemtt_convert(png, os.path.join("addons", brand, "data", "UI", "aceax_logo_ca.paa"))

    sheet = os.path.join(args.out, "preview.png")
    preview_sheet(logos, sheet)
    print(f"{len(logos)} logos, preview: {sheet}")


if __name__ == "__main__":
    main()
