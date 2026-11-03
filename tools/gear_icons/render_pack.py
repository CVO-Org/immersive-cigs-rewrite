#!/usr/bin/env python3
"""
Renders the 3/4 pack icon from any texture that uses the cigarette pack's UV layout,
for packs that don't follow the brand layout of gear_icons.py (e.g. the crayon pack).
Check the model's UVs first with: python tools/gear_icons/mlod.py <model>.p3d --faces

    python tools/gear_icons/render_pack.py addons/crayons/data/crayonpack/crayonpack.paa .hemttout/icons/crayons/gear_crayonpack_ca.png
    python tools/gear_icons/render_pack.py addons/crayons/data/crayonpack/crayonpack.paa .hemttout/icons/crayons/gear_crayonpack_ca.png --paa addons/crayons/data/UI/gear_crayonpack_ca.paa
"""

import argparse
import os
import tempfile

from PIL import Image

from gear_icons import hemtt_convert, pack_icon


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("texture", help="the pack's texture (.paa or .png)")
    parser.add_argument("out", help="PNG to write (512 x 512)")
    parser.add_argument("--paa", help="also convert the icon to this PAA")
    args = parser.parse_args()

    src = args.texture
    if src.lower().endswith(".paa"):
        src = os.path.join(tempfile.mkdtemp(prefix="render_pack_"), "texture.png")
        hemtt_convert(args.texture, src)
    os.makedirs(os.path.dirname(args.out) or ".", exist_ok=True)
    pack_icon(Image.open(src).convert("RGB")).save(args.out)
    print(f"wrote {args.out}")
    if args.paa:
        hemtt_convert(args.out, args.paa)
        print(f"converted it to {args.paa}")


if __name__ == "__main__":
    main()
