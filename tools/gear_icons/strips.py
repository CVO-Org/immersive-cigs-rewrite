#!/usr/bin/env python3
"""
Puts the cigarette strips (top of the texture) of several brands on one sheet, with a
v ruler every 20 px, and prints where each brand's paper logo sits. Use it to pick a
--logo-v for gear_icons.py, or to line logos up across brands.

    python tools/gear_icons/strips.py kosmos baja_blast savage --out .hemttout/icons/strips.png

A brand can also be a texture path, e.g. addons/eckstein/data/cigs/cig2.paa.
"""

import argparse
import os
import tempfile

from PIL import Image, ImageChops, ImageDraw

from gear_icons import PAPER_U, hemtt_convert

STRIP_H = 280


def load_texture(brand, tmp):
    paa = brand if brand.endswith(".paa") else os.path.join("addons", brand, "data", "texture.paa")
    png = os.path.join(tmp, os.path.basename(os.path.dirname(paa)) + "_" + os.path.basename(paa) + ".png")
    hemtt_convert(paa, png)
    return Image.open(png).convert("RGB")


def logo_box(tex):
    # bounding box of whatever is printed on the paper, ignoring full-height seam lines
    paper = tex.crop((100, 60, 250, 200)).resize((1, 1), Image.BOX).getpixel((0, 0))
    u0, v0 = 20, 30
    region = tex.crop((u0, v0, PAPER_U[1], 250))
    hit = ImageChops.difference(region, Image.new("RGB", region.size, paper)).convert("L").point(lambda v: 255 if v > 40 else 0)
    px = hit.load()
    w, h = hit.size
    d = ImageDraw.Draw(hit)
    for x in range(w):
        if sum(px[x, y] > 0 for y in range(h)) > h * 0.6:
            d.line((x, 0, x, h), fill=0)
    box = hit.getbbox()
    return box and (box[0] + u0, box[1] + v0, box[2] + u0, box[3] + v0)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("brands", nargs="+", help="addon folder names or .paa paths")
    parser.add_argument("--out", default=".hemttout/icons/strips.png", help="sheet to write")
    parser.add_argument("--width", type=int, default=1024, help="how much of the strip to show, in u pixels")
    args = parser.parse_args()

    tmp = tempfile.mkdtemp(prefix="strips_")
    sheet = Image.new("RGB", (args.width + 40, len(args.brands) * (STRIP_H + 10)), (255, 0, 255))
    d = ImageDraw.Draw(sheet)
    for i, brand in enumerate(args.brands):
        tex = load_texture(brand, tmp)
        y = i * (STRIP_H + 10)
        sheet.paste(tex.crop((0, 0, args.width, STRIP_H)), (0, y))
        for v in range(0, STRIP_H, 20):
            d.line((args.width, y + v, args.width + 10, y + v), fill=(200, 0, 0))
            d.text((args.width + 12, y + v - 5), str(v), fill=(0, 0, 0))
        d.text((PAPER_U[1] + 50, y + 4), brand, fill=(200, 0, 0))
        box = logo_box(tex)
        print(f"{brand}: paper logo at u {box[0]}-{box[2]}, v {box[1]}-{box[3]}" if box else f"{brand}: no logo on the paper (it may be on the filter band)")
    os.makedirs(os.path.dirname(args.out) or ".", exist_ok=True)
    sheet.save(args.out)
    print(f"wrote {args.out}")


if __name__ == "__main__":
    main()
