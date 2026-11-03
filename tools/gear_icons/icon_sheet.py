#!/usr/bin/env python3
"""
Lays out icons side by side on a dark background, to compare brands or review a batch.

  overview  one row per brand: pack + cig0..4, from the PNGs gear_icons.py wrote to
            .hemttout/icons/<brand>/
  files     any PAA or PNG icons in a grid, with their names and sizes

    python tools/gear_icons/icon_sheet.py overview apollo kosmos voron --out .hemttout/icons/overview.png
    python tools/gear_icons/icon_sheet.py files addons/cigars/data/UI/*.paa --out .hemttout/icons/cigars.png
"""

import argparse
import glob
import os
import tempfile

from PIL import Image, ImageDraw, ImageFont

from gear_icons import hemtt_convert

BG = (28, 30, 27, 255)
TILE = (44, 46, 42, 255)
TEXT = (225, 225, 215)
ICONS = ["gear_cigpack_x_ca"] + [f"gear_cig{i}_x_ca" for i in range(5)]


def font(size):
    try:
        return ImageFont.truetype("bahnschrift.ttf", size)
    except OSError:
        return ImageFont.load_default()


def overview(brands, root, cell=160):
    f = font(20)
    label_w = 170
    sheet = Image.new("RGBA", (label_w + 6 * (cell + 8) + 8, 40 + len(brands) * (cell + 8) + 8), BG)
    d = ImageDraw.Draw(sheet)
    for j, name in enumerate(["pack"] + [f"cig{i}" for i in range(5)]):
        d.text((label_w + 8 + j * (cell + 8) + cell / 2, 22), name, font=f, fill=TEXT, anchor="mm")
    for i, brand in enumerate(brands):
        y = 40 + i * (cell + 8)
        d.text((12, y + cell / 2), brand, font=f, fill=TEXT, anchor="lm")
        for j, icon in enumerate(ICONS):
            x = label_w + 8 + j * (cell + 8)
            d.rectangle((x, y, x + cell - 1, y + cell - 1), fill=TILE)
            path = os.path.join(root, brand, icon + ".png")
            if os.path.exists(path):
                sheet.alpha_composite(Image.open(path).convert("RGBA").resize((cell, cell), Image.LANCZOS), (x, y))
            else:
                d.text((x + cell / 2, y + cell / 2), "-", font=f, fill=(120, 120, 110), anchor="mm")
    return sheet


def files(paths, cell=150, cols=6):
    f = font(13)
    tmp = tempfile.mkdtemp(prefix="icon_sheet_")
    rows = (len(paths) + cols - 1) // cols
    sheet = Image.new("RGBA", (cols * (cell + 8) + 8, rows * (cell + 26) + 8), BG)
    d = ImageDraw.Draw(sheet)
    for i, path in enumerate(paths):
        if path.lower().endswith(".paa"):
            png = os.path.join(tmp, f"{i}.png")
            hemtt_convert(path, png)
        else:
            png = path
        im = Image.open(png).convert("RGBA")
        x, y = 8 + (i % cols) * (cell + 8), 8 + (i // cols) * (cell + 26)
        name = os.path.splitext(os.path.basename(path))[0]
        d.text((x, y), f"{name} {im.width}x{im.height}", font=f, fill=TEXT)
        d.rectangle((x, y + 18, x + cell - 1, y + 18 + cell - 1), fill=TILE)
        sheet.alpha_composite(im.resize((cell, cell), Image.LANCZOS), (x, y + 18))
    return sheet


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="cmd", required=True)
    o = sub.add_parser("overview", help="rows = brands, columns = pack + cig0..4")
    o.add_argument("brands", nargs="+")
    o.add_argument("--root", default=os.path.join(".hemttout", "icons"), help="where gear_icons.py wrote the PNGs")
    fl = sub.add_parser("files", help="any icons in a grid")
    fl.add_argument("paths", nargs="+", help="PAA or PNG files (wildcards are expanded)")
    for p in (o, fl):
        p.add_argument("--out", required=True, help="PNG to write")
    args = parser.parse_args()

    if args.cmd == "overview":
        sheet = overview(args.brands, args.root)
    else:
        sheet = files(sorted(p for pat in args.paths for p in (glob.glob(pat) or [pat])))
    os.makedirs(os.path.dirname(args.out) or ".", exist_ok=True)
    sheet.save(args.out)
    print(f"wrote {args.out}")


if __name__ == "__main__":
    main()
