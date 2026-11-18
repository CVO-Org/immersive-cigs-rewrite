#!/usr/bin/env python3
"""
Builds a brand's 1024 x 1024 texture from separate pictures, so nobody has to place
artwork on the UV layout by hand. See docs/gear-icons.md for the cigarette layout.

  guide    draws the layout: every pack face and the cigarette strip, labelled, with an
           arrow to where "up" is. Hand it to whoever paints the artwork.
  compose  starts from a clean copy of the base texture (paper, filter, tobacco end and
           ash stay), pastes the pack faces and the paper logo you give it, and writes a
           PNG. --paa also writes the PAA, e.g. addons/<brand>/data/texture.paa.
  cigar    builds a cigar's data/cigars/cigar_co from Papa Schultz' with the band and its
           print removed: tints the wrapper, paints a new band and puts a print on it.
           The foot, the ash and the ember stay. See cigar_icons.py layout for the UVs.

    python tools/gear_icons/texture_compose.py guide --out .hemttout/llm/guide.png
    python tools/gear_icons/texture_compose.py cigar --wrapper "#6b4226" --band "#1c1c1c" --band-print medallion.png --out .hemttout/llm/mybrand/cigar_co.png --paa addons/mybrand/data/cigars/cigar_co.paa
    python tools/gear_icons/texture_compose.py compose --front front.png --back back.png --top top.png --left left.png --right right.png --bottom bottom.png --paper-logo logo.png --filter "#b01818" --out .hemttout/llm/mybrand/texture.png --paa addons/mybrand/data/texture.paa

Pictures are scaled to fill their face and cropped at the edges, so give them the face's
aspect ratio (the guide prints the sizes). Draw every face upright, as you see it on the
pack standing in front of you:
  - front, back, left, right: the pack's top at the top of the picture
  - top flap: the back edge at the top, the edge that meets the front at the bottom
  - bottom: as seen when you tip the pack back, front edge at the top. It is turned
    by 180 degrees for you, because it hangs below the back face in the texture.
A side picture that is wider than tall is turned by 90 degrees, so its text runs along
the side: top to bottom on the right side, bottom to top on the left (as on most packs).

The paper logo is printed on the paper's end next to the filter (u 330-389), which stays
until the stub. It is drawn upright with the filter to its right and fitted into
54 x 72 px, centred on v 127. Render the icons afterwards with
gear_icons.py <addon> --logo-v 127; a tinted paper can fool its logo detection.

Requires Pillow (pip install pillow) and hemtt on PATH (for PAA reading and writing).
"""

import argparse
import os
import shutil
import subprocess
import sys
import tempfile

from PIL import Image, ImageDraw, ImageFont, ImageOps

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
BASE_TEXTURE = os.path.join(ROOT, "addons", "base", "data", "texture.paa")

# Pack faces (u0, v0, u1, v1), shared by every brand's cigpack.p3d
FACES = {
    "front":  (512, 451, 873, 1015),
    "right":  (873, 451, 1024, 1015),
    "top":    (512, 300, 873, 451),
    "back":   (0, 300, 361, 864),
    "left":   (361, 300, 512, 864),
    "bottom": (0, 864, 361, 1015),
}
PACK_AREA = (0, 290, 1024, 1024)

# Cigarette strip, shared by the base models addons/base/data/cig*.p3d
STRIP_V = (30, 230)          # rows cleaned of print
STRIP_ROWS = (41, 217)       # rows of the paper and the filter; the models use v 47-207
PAPER_U = (10, 389)          # u 0-10 is the charred edge
PAPER_SAMPLE_U = (40, 300)   # clean paper in the base texture, no print
FILTER_U = (391, 591)        # base: white band 391-430, ring 431-437, cork 438-591
FILTER_BAND_U = (391, 431)
CORK_U = (437, 592)
LOGO_BOX = (332, 91, 386, 163)  # u0, v0, u1, v1 for the paper logo, centred on v 127
TOBACCO_UV = (722, 85, 788, 155)
ASH_UV = (836, 60, 1010, 200)

# Cigar: addons/base/data/cigar0..4.p3d. u runs along the cigar (foot left, mouth right,
# about 10 px per mm), v 602-1023 round it. The shortest stage still shows u 599-1019.
CIGAR_BASE = os.path.join(ROOT, "addons", "papa_schultz", "data", "cigars", "cigar_co.png")
CIGAR_WRAPPER = (0, 590, 1024, 1024)
CIGAR_HEAD = (140, 459, 272, 591)            # the mouth end's cap, wrapper leaf too
CIGAR_OLD_BAND = (695, 835)                  # Papa Schultz' band and medallion, u
CIGAR_CLEAN_FROM = 555                       # clean wrapper to cover them with, u
CIGAR_BAND_U = 765                           # default band centre
CIGAR_BAND_W = 50
CIGAR_PRINT_V = 820                          # default print centre, v
CIGAR_PRINT_MAX = 130


def paa_to_image(path):
    if not path.lower().endswith(".paa"):
        return Image.open(path).convert("RGBA")
    tmp = tempfile.mkdtemp()
    try:
        png = os.path.join(tmp, "t.png")
        subprocess.run(["hemtt", "utils", "paa", "convert", path, png], check=True, capture_output=True)
        return Image.open(png).convert("RGBA")
    finally:
        shutil.rmtree(tmp, ignore_errors=True)


def image_to_paa(png, paa):
    # hemtt refuses to overwrite, so convert next to a temp name and move into place
    os.makedirs(os.path.dirname(os.path.abspath(paa)), exist_ok=True)
    tmp = paa + ".tmp.paa"
    if os.path.exists(tmp):
        os.remove(tmp)
    subprocess.run(["hemtt", "utils", "paa", "convert", png, tmp], check=True, capture_output=True)
    shutil.move(tmp, paa)


def parse_colour(text):
    text = text.strip().lstrip("#")
    if len(text) != 6:
        sys.exit(f"colour must be #rrggbb, got {text!r}")
    return tuple(int(text[i:i + 2], 16) for i in (0, 2, 4))


def cover(img, size):
    # scale to fill size, crop what sticks out
    return ImageOps.fit(img.convert("RGBA"), size, Image.LANCZOS)


def contain(img, size):
    img = img.convert("RGBA")
    img.thumbnail(size, Image.LANCZOS)
    return img


def tint(region, colour):
    # keep the region's grain, give it the colour: luminance x colour, normalised to its mean
    grey = region.convert("L")
    mean = max(1, sum(i * n for i, n in enumerate(grey.histogram())) / (grey.width * grey.height))
    r, g, b = colour
    out = Image.merge("RGB", [grey.point(lambda p, c=c: max(0, min(255, round(p / mean * c)))) for c in (r, g, b)])
    return out.convert("RGBA")


def clean_base(base):
    """The base texture with every print removed: plain paper strip, plain filter band, plain pack area."""
    tex = base.copy()
    v0, v1 = STRIP_V
    paper = base.crop((PAPER_SAMPLE_U[0], v0, PAPER_SAMPLE_U[1], v1))
    tex.paste(paper.resize((PAPER_U[1] - PAPER_U[0], v1 - v0), Image.LANCZOS), (PAPER_U[0], v0))
    band = base.crop((PAPER_SAMPLE_U[0], v0, PAPER_SAMPLE_U[0] + FILTER_BAND_U[1] - FILTER_BAND_U[0], v1))
    tex.paste(band, (FILTER_BAND_U[0], v0))
    # pack area: neutral card, the faces are pasted on top
    card = base.crop((600, 240, 700, 285)).resize((PACK_AREA[2] - PACK_AREA[0], PACK_AREA[3] - PACK_AREA[1]), Image.LANCZOS)
    tex.paste(card, PACK_AREA[:2])
    return tex


def face_picture(name, img):
    u0, v0, u1, v1 = FACES[name]
    w, h = u1 - u0, v1 - v0
    if name in ("left", "right") and img.width > img.height:
        img = img.rotate(-90 if name == "right" else 90, expand=True)
    img = cover(img, (w, h))
    if name == "bottom":
        img = img.rotate(180)
    return img


def compose(args):
    base = paa_to_image(args.base)
    if base.size != (1024, 1024):
        sys.exit(f"{args.base} is {base.size}, expected 1024 x 1024")
    tex = clean_base(base)

    if args.pack_colour:
        tex.paste(Image.new("RGBA", (PACK_AREA[2] - PACK_AREA[0], PACK_AREA[3] - PACK_AREA[1]),
                            parse_colour(args.pack_colour) + (255,)), PACK_AREA[:2])

    missing = []
    for name in FACES:
        path = getattr(args, name)
        if not path:
            missing.append(name)
            continue
        pic = face_picture(name, Image.open(path))
        tex.alpha_composite(pic, FACES[name][:2])
    if missing:
        print("no picture for: " + ", ".join(missing) + " (left as plain card)")

    v0, v1 = STRIP_ROWS
    if args.paper:
        # the paper and the filter's white band, which is paper too
        for u0, u1 in (PAPER_U, FILTER_BAND_U):
            tex.paste(tint(tex.crop((u0, v0, u1, v1)), parse_colour(args.paper)), (u0, v0))
    if args.filter:
        u0, u1 = FILTER_U
        size = (u1 - u0, v1 - v0)
        if os.path.isfile(args.filter):
            tex.paste(cover(Image.open(args.filter), size), (u0, v0))
        elif args.filter == "white":
            tex.paste(tex.crop((FILTER_BAND_U[0], v0, FILTER_BAND_U[1], v1)).resize(size, Image.LANCZOS), (u0, v0))
        else:
            cork = (CORK_U[0], v0, CORK_U[1], v1)
            tex.paste(tint(base.crop(cork), parse_colour(args.filter)), (cork[0], v0))
    if args.paper_logo:
        lu0, lv0, lu1, lv1 = LOGO_BOX
        logo = Image.open(args.paper_logo)
        if args.paper_logo_rotate:
            logo = logo.convert("RGBA").rotate(args.paper_logo_rotate, expand=True)
        logo = contain(logo, (lu1 - lu0, lv1 - lv0))
        tex.alpha_composite(logo, (lu0 + (lu1 - lu0 - logo.width) // 2, lv0 + (lv1 - lv0 - logo.height) // 2))

    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    tex.convert("RGB").save(args.out)
    print(f"wrote {args.out}")
    if args.paa:
        image_to_paa(args.out, args.paa)
        print(f"wrote {args.paa}")
    if args.paper_logo:
        v = (LOGO_BOX[1] + LOGO_BOX[3]) // 2
        print(f"the paper logo is centred on v {v}: render the icons with gear_icons.py <addon> --logo-v {v}")


def cigar(args):
    base = paa_to_image(args.base)
    if base.size != (1024, 1024):
        sys.exit(f"{args.base} is {base.size}, expected 1024 x 1024")
    tex = base.copy()
    _, v0, _, v1 = CIGAR_WRAPPER
    if args.base == CIGAR_BASE or args.clean_band:
        u0, u1 = CIGAR_OLD_BAND
        tex.paste(base.crop((CIGAR_CLEAN_FROM, v0, CIGAR_CLEAN_FROM + u1 - u0, v1)), (u0, v0))
    if args.wrapper:
        if os.path.isfile(args.wrapper):
            tex.paste(cover(Image.open(args.wrapper), (1024, v1 - v0)), (0, v0))
            head = cover(Image.open(args.wrapper), (CIGAR_HEAD[2] - CIGAR_HEAD[0], CIGAR_HEAD[3] - CIGAR_HEAD[1]))
        else:
            colour = parse_colour(args.wrapper)
            tex.paste(tint(tex.crop(CIGAR_WRAPPER), colour), CIGAR_WRAPPER[:2])
            head = tint(tex.crop(CIGAR_HEAD), colour)
        tex.paste(head, CIGAR_HEAD[:2])
    u = args.band_u
    if args.band:
        bu0, bu1 = u - CIGAR_BAND_W // 2, u + CIGAR_BAND_W // 2
        if os.path.isfile(args.band):
            band = cover(Image.open(args.band), (bu1 - bu0, v1 - v0))
        else:
            band = Image.new("RGBA", (bu1 - bu0, v1 - v0), parse_colour(args.band) + (255,))
            # thin light edges, as on a paper band
            d = ImageDraw.Draw(band)
            edge = tuple(min(255, c + 90) for c in parse_colour(args.band))
            d.rectangle((0, 0, 3, band.height), fill=edge)
            d.rectangle((band.width - 4, 0, band.width, band.height), fill=edge)
        tex.alpha_composite(band, (bu0, v0))
    if args.band_print:
        pic = contain(Image.open(args.band_print), (CIGAR_PRINT_MAX, CIGAR_PRINT_MAX))
        tex.alpha_composite(pic, (u - pic.width // 2, args.print_v - pic.height // 2))

    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    tex.convert("RGB").save(args.out)
    print(f"wrote {args.out}")
    if args.paa:
        image_to_paa(args.out, args.paa)
        print(f"wrote {args.paa}")
    if u < 620 + CIGAR_BAND_W // 2:
        print(f"warning: a band at u {u} burns away before the last stage, which shows u 599-1019")


def guide(args):
    tex = clean_base(paa_to_image(args.base)) if args.over_base else Image.new("RGBA", (1024, 1024), (40, 40, 40, 255))
    draw = ImageDraw.Draw(tex)
    try:
        font = ImageFont.truetype("arial.ttf", 16)
        small = ImageFont.truetype("arial.ttf", 12)
    except OSError:
        font = small = ImageFont.load_default()

    def box(rect, colour, label, up=None, arrow=""):
        u0, v0, u1, v1 = rect
        draw.rectangle((u0, v0, u1 - 1, v1 - 1), outline=colour, width=3)
        draw.text((u0 + 6, v0 + 6), label, fill=colour, font=font)
        draw.text((u0 + 6, v0 + 26), f"{u1 - u0} x {v1 - v0} px", fill=colour, font=small)
        draw.text((u0 + 6, v0 + 42), f"u {u0}-{u1}  v {v0}-{v1}", fill=colour, font=small)
        if up:
            cx, cy = (u0 + u1) // 2, (v0 + v1) // 2
            dy = -1 if up == "up" else 1
            draw.line((cx, cy - dy * 30, cx, cy + dy * 30), fill=colour, width=4)
            ty = cy + dy * 30
            draw.polygon([(cx, ty + dy * 14), (cx - 10, ty), (cx + 10, ty)], fill=colour)
            draw.text((cx + 14, cy - 8), arrow, fill=colour, font=small)

    for name, colour in (("front", "#ff4040"), ("right", "#40c0ff"), ("top", "#ffd040"),
                         ("back", "#40ff80"), ("left", "#c080ff"), ("bottom", "#ff80c0")):
        arrow = {"top": "back edge", "bottom": "front edge (picture turned 180°)"}.get(name, "pack top")
        box(FACES[name], colour, name, "down" if name == "bottom" else "up", arrow)
    v0, v1 = 47, 207
    box((PAPER_U[0], v0, PAPER_U[1], v1), "#ffffff", "paper (burns from u 10)")
    box((FILTER_U[0], v0, FILTER_U[1], v1), "#ffa040", "filter")
    box(LOGO_BOX, "#ff40ff", "logo")
    box(TOBACCO_UV, "#a0a0a0", "tobacco end")
    box(ASH_UV, "#a0a0a0", "ash (keep)")
    draw.text((10, 222), "cigarette strip: u = along the cigarette (burnt end left, mouth right), "
              "v = around it; about 78 px of v are visible from one side", fill="#ffffff", font=small)

    os.makedirs(os.path.dirname(os.path.abspath(args.out)), exist_ok=True)
    tex.convert("RGB").save(args.out)
    print(f"wrote {args.out}")
    for name, (u0, v0, u1, v1) in FACES.items():
        print(f"  {name:6} {u1 - u0:3} x {v1 - v0:3} px  (aspect {(u1 - u0) / (v1 - v0):.3f})")
    print(f"  logo   max {LOGO_BOX[2] - LOGO_BOX[0]} x {LOGO_BOX[3] - LOGO_BOX[1]} px")


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest="cmd", required=True)

    g = sub.add_parser("guide", help="draw the UV layout with labels")
    g.add_argument("--out", required=True, help="PNG to write")
    g.add_argument("--over-base", action="store_true", help="draw over the clean base texture instead of grey")
    g.add_argument("--base", default=BASE_TEXTURE, help=argparse.SUPPRESS)
    g.set_defaults(func=guide)

    c = sub.add_parser("compose", help="build a texture from separate pictures")
    for name in FACES:
        c.add_argument(f"--{name}", help=f"picture for the pack's {name} face")
    c.add_argument("--pack-colour", help="#rrggbb behind faces you leave out")
    c.add_argument("--paper", help="#rrggbb tint for the cigarette paper (default: white)")
    c.add_argument("--paper-logo", help="picture printed on the paper next to the filter (PNG with transparency)")
    c.add_argument("--paper-logo-rotate", type=int, default=0, help="degrees counter-clockwise, e.g. 90 for text along the cigarette")
    c.add_argument("--filter", help="cork tint #rrggbb, 'white', or a picture for u 391-591 (default: the base's cork)")
    c.add_argument("--base", default=BASE_TEXTURE, help="texture to start from (default: addons/base/data/texture.paa)")
    c.add_argument("--out", required=True, help="PNG to write")
    c.add_argument("--paa", help="also write this PAA")
    c.set_defaults(func=compose)

    z = sub.add_parser("cigar", help="build a cigar texture (data/cigars/cigar_co)")
    z.add_argument("--wrapper", help="#rrggbb tint for the wrapper leaf, or a picture for it (1024 x 434)")
    z.add_argument("--band", help="#rrggbb for the band, or a picture for it (50 x 434)")
    z.add_argument("--band-print", help="picture on the band, e.g. a medallion (PNG with transparency, fitted into 130 x 130)")
    z.add_argument("--band-u", type=int, default=CIGAR_BAND_U, help=f"u of the band's centre (default {CIGAR_BAND_U}; keep it above 645)")
    z.add_argument("--print-v", type=int, default=CIGAR_PRINT_V, help=f"v of the print's centre (default {CIGAR_PRINT_V})")
    z.add_argument("--base", default=CIGAR_BASE, help="cigar texture to start from (default: Papa Schultz', band removed)")
    z.add_argument("--clean-band", action="store_true", help="also remove the band at u 695-835 from another --base")
    z.add_argument("--out", required=True, help="PNG to write")
    z.add_argument("--paa", help="also write this PAA, e.g. addons/<brand>/data/cigars/cigar_co.paa")
    z.set_defaults(func=cigar)

    args = ap.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
