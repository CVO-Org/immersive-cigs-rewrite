#!/usr/bin/env python3
"""
Small texture fixes, done on the PAA directly (converted to PNG and back with hemtt).

  rotate     turn a region of the texture by 180 degrees, e.g. a pack face that is
             upside down on the model. Default region: the pack's top flap.
  move-logo  move what is printed in a box on the cigarette paper by dx pixels along
             the strip, and cover the old spot with clean paper from the same rows.

    python tools/gear_icons/texture_fix.py rotate morley
    python tools/gear_icons/texture_fix.py move-logo savage --box 268 88 341 162 --dx 48

Add --dry-run to only write the PNG to .hemttout/icons/_edit and leave the PAA alone.
Re-encoding keeps the PAA format (DXT1/DXT5) but compresses it anew, so expect a small
size change. Re-render the icons afterwards with gear_icons.py.
"""

import argparse
import os

from PIL import Image, ImageChops, ImageFilter

from gear_icons import PACK_TOP, hemtt_convert

OUT = os.path.join(".hemttout", "icons", "_edit")


def rotate(tex, box):
    tex.paste(tex.crop(box).rotate(180), box[:2])
    return tex


def move_logo(tex, box, dx, paper_from=-120):
    # the mask covers only the print itself (grown a little and feathered), so the paper
    # grain around it stays untouched
    rgb = tex.convert("RGB")
    logo = rgb.crop(box)
    paper = rgb.crop((100, 60, 250, 200)).resize((1, 1), Image.BOX).getpixel((0, 0))
    diff = ImageChops.difference(logo, Image.new("RGB", logo.size, paper)).convert("L")
    mask = diff.point(lambda v: 255 if v > 18 else 0).filter(ImageFilter.MaxFilter(5)).filter(ImageFilter.GaussianBlur(1.5))
    clean = rgb.crop((box[0] + paper_from, box[1], box[2] + paper_from, box[3]))
    rgb.paste(clean, box[:2], mask)
    rgb.paste(logo, (box[0] + dx, box[1]), mask)
    if tex.mode == "RGBA":
        rgb.putalpha(tex.getchannel("A"))
    return rgb


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="cmd", required=True)
    r = sub.add_parser("rotate", help="turn a region by 180 degrees")
    r.add_argument("--box", type=int, nargs=4, default=PACK_TOP, metavar=("U0", "V0", "U1", "V1"), help="default: the pack's top flap")
    m = sub.add_parser("move-logo", help="move a print on the cigarette paper")
    m.add_argument("--box", type=int, nargs=4, required=True, metavar=("U0", "V0", "U1", "V1"), help="the print, with a few px margin (strips.py prints it)")
    m.add_argument("--dx", type=int, required=True, help="pixels to move along the strip, positive towards the filter")
    m.add_argument("--paper-from", type=int, default=-120, help="where to take clean paper from, relative to the box (default -120)")
    for p in (r, m):
        p.add_argument("addon")
        p.add_argument("--texture", help="texture inside addons/<addon>/data (default texture.paa)", default="texture.paa")
        p.add_argument("--dry-run", action="store_true", help="only write the PNG")
    args = parser.parse_args()

    paa = os.path.join("addons", args.addon, "data", args.texture)
    os.makedirs(OUT, exist_ok=True)
    name = f"{args.addon}_{os.path.splitext(args.texture)[0]}"
    src = os.path.join(OUT, name + "_orig.png")
    hemtt_convert(paa, src)
    tex = Image.open(src)
    tex = rotate(tex, tuple(args.box)) if args.cmd == "rotate" else move_logo(tex, tuple(args.box), args.dx, args.paper_from)
    png = os.path.join(OUT, name + ".png")
    tex.save(png)
    print(f"wrote {png} (original in {src})")
    if not args.dry_run:
        hemtt_convert(png, paa)
        print(f"converted it to {paa}")


if __name__ == "__main__":
    main()
