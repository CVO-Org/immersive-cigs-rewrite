#!/usr/bin/env python3
"""
Renders a cigarette brand's gear icons from its texture, so every brand looks the same
in the inventory. See docs/gear-icons.md.

- gear_cigpack_x_ca: 512x512, the pack in 3/4 view (front, right side, top flap)
- gear_cig0..4_x_ca: 128x128, the cigarette at each burn stage, 45 degrees, filter top right

Reads addons/<addon>/data/texture.paa. Without --apply it only writes PNGs and a preview
sheet; with --apply it also converts them to PAA in addons/<addon>/data/UI/.

Requires Pillow (pip install pillow) and hemtt on PATH (for PAA conversion).
"""

import argparse
import math
import os
import shutil
import subprocess
import sys
import tempfile

from PIL import Image, ImageChops, ImageDraw, ImageFilter, ImageFont, ImageStat

# Pack faces in texture pixels (u0, v0, u1, v1). Every brand's cigpack.p3d shares these UVs.
PACK_FRONT = (512, 451, 873, 1015)
PACK_SIDE = (873, 451, 1024, 1015)  # right side when looking at the front
PACK_TOP = (512, 300, 873, 451)

# Cigarette strip, shared by the base models addons/base/data/cig0..4.p3d
PAPER_U = (10, 389)     # u389 meets the filter
FILTER_U = (391, 585)
CHAR_U = (0, 10)        # charred paper edge at the burnt end
ASH_UV = (836, 70, 994, 96)
STRIP_PX_MM = 6.57      # strip pixels per mm along the cigarette
STRIP_V = (20, 260)     # where the strip's artwork can be

# Lengths in mm, from the base models
FILTER_MM = 30.5
DIAM_MM = 7.6
TIP_MM = 6.5
STAGES = [(83.9, False), (83.8, True), (69.1, True), (55.4, True), (42.6, True)]

SS = 8                  # supersampling for the cigarette icons
PX_MM = 1.78            # 84 mm cigarette spans ~150 px of diagonal in a 128 px icon
ANGLE = 45              # degrees, rising to the right
FILTER_END = (118, 11)  # where the filter's end sits in every stage


def hemtt_convert(src, dest):
    # hemtt refuses to overwrite, so convert next to a temp name and move into place
    tmp = dest + ".tmp" + os.path.splitext(dest)[1]
    if os.path.exists(tmp):
        os.remove(tmp)
    subprocess.run(["hemtt", "utils", "paa", "convert", src, tmp], check=True, capture_output=True)
    shutil.move(tmp, dest)


# ---------- pack ----------

def solve(A, B):
    n = len(B)
    M = [list(map(float, r)) + [float(b)] for r, b in zip(A, B)]
    for i in range(n):
        p = max(range(i, n), key=lambda r: abs(M[r][i]))
        M[i], M[p] = M[p], M[i]
        for r in range(n):
            if r != i:
                k = M[r][i] / M[i][i]
                M[r] = [a - k * b for a, b in zip(M[r], M[i])]
    return [M[i][n] / M[i][i] for i in range(n)]


def warp(img, quad, size):
    # map img onto quad (TL, TR, BR, BL) with a perspective transform
    w, h = img.size
    src = [(0, 0), (w, 0), (w, h), (0, h)]
    A, B = [], []
    for (x, y), (u, v) in zip(quad, src):
        A += [[x, y, 1, 0, 0, 0, -u * x, -u * y], [0, 0, 0, x, y, 1, -v * x, -v * y]]
        B += [u, v]
    out = img.transform(size, Image.PERSPECTIVE, tuple(solve(A, B)), Image.BICUBIC)
    mask = Image.new("L", size, 0)
    ImageDraw.Draw(mask).polygon(quad, fill=255)
    return out, mask


def pack_icon(tex):
    ss = 2
    n = 512 * ss
    fh = 430 * ss
    fw = round(fh * 361 / 564)
    sd = round(fh * 151 / 564)
    dx, dy = sd * 0.62, -sd * 0.42
    x0 = (n - fw - dx) / 2
    y0 = (n - fh - dy) / 2 - dy
    front = [(x0, y0), (x0 + fw, y0), (x0 + fw, y0 + fh), (x0, y0 + fh)]
    side = [(x0 + fw, y0), (x0 + fw + dx, y0 + dy), (x0 + fw + dx, y0 + fh + dy), (x0 + fw, y0 + fh)]
    top = [(x0 + dx, y0 + dy), (x0 + fw + dx, y0 + dy), (x0 + fw, y0), (x0, y0)]
    img = Image.new("RGBA", (n, n), (0, 0, 0, 0))
    for box, quad, light in ((PACK_FRONT, front, 1.0), (PACK_SIDE, side, 0.7), (PACK_TOP, top, 0.85)):
        face, mask = warp(tex.crop(box), quad, (n, n))
        if light != 1.0:
            face = face.point(lambda v: int(v * light))
        img.paste(face.convert("RGBA"), (0, 0), mask)
    return img.resize((512, 512), Image.LANCZOS)


# ---------- cigarettes ----------

def find_logo_v(tex):
    # Centre of whatever is printed next to the filter: on the paper's end or on the white
    # band where the filter starts (u 400-428). Skips the seam line around u 395. Each
    # channel counts on its own so pale gold or pink prints still show up.
    paper = tex.crop((100, 60, 250, 200)).resize((1, 1), Image.BOX).getpixel((0, 0))
    band = ImageStat.Stat(tex.crop((FILTER_U[0] + 10, 60, FILTER_U[0] + 37, 200))).median
    band_is_white = max(abs(a - b) for a, b in zip(band, paper)) < 30
    u0, u1 = PAPER_U[1] - 190, FILTER_U[0] + 37 if band_is_white else PAPER_U[1]
    region = tex.crop((u0, STRIP_V[0], u1, STRIP_V[1]))
    diff = ImageChops.difference(region, Image.new("RGB", region.size, paper))
    hit = ImageChops.lighter(ImageChops.lighter(*diff.split()[:2]), diff.split()[2]).point(lambda v: 255 if v > 28 else 0)
    ImageDraw.Draw(hit).rectangle((PAPER_U[1] - u0 - 1, 0, FILTER_U[0] + 8 - u0, hit.height), fill=0)
    # drop stripes: columns lit in most rows (printed lines) and rows lit in most columns
    # (the strip's own top and bottom edges)
    px = hit.load()
    w, h = hit.size
    cols = [x for x in range(w) if sum(px[x, y] > 0 for y in range(h)) > h * 0.5]
    rows = [y for y in range(h) if sum(px[x, y] > 0 for x in range(w)) > w * 0.5]
    d = ImageDraw.Draw(hit)
    for x in cols:
        d.line((x, 0, x, h), fill=0)
    for y in rows:
        d.line((0, y, w, y), fill=0)
    box = hit.getbbox()
    if not box:
        return None, None
    return STRIP_V[0] + (box[1] + box[3]) / 2, (STRIP_V[0] + box[1], STRIP_V[0] + box[3])


def wrap(tex, u0, u1, w, h, v_centre):
    # Side view of a cylinder: the visible half circumference, pi*d/2, folds onto the
    # diameter. Blend that arcsine mapping with a flat one so the logo's top and bottom
    # stay readable instead of squeezing to a line at the edges.
    half = STRIP_PX_MM * math.pi * DIAM_MM / 4
    v0 = int(v_centre - half - 1)
    src = tex.crop((u0, v0, u1, int(v_centre + half + 2)))
    src = src.resize((max(1, w), src.height * 8), Image.LANCZOS)
    out = Image.new("RGB", (max(1, w), h))
    for y in range(h):
        t = (y + 0.5) / h * 2 - 1
        k = 0.5 * t + 0.5 * math.asin(t) / (math.pi / 2)
        row = min(src.height - 1, round((v_centre - v0 + k * half) * 8))
        out.paste(src.crop((0, row, src.width, row + 1)), (0, y))
    return out


def shade(img):
    # cylindrical light from above: bright band near the top, darker underside
    w, h = img.size
    g = Image.new("L", (1, h))
    for y in range(h):
        t = (y + 0.5) / h * 2 - 1
        lum = 0.68 + 0.32 * math.sqrt(max(0.0, 1 - t * t))
        lum += 0.12 * math.exp(-((t + 0.45) ** 2) / 0.03)
        lum *= 1 - 0.14 * max(0.0, t)
        g.putpixel((0, y), max(0, min(255, int(255 * lum))))
    return ImageChops.multiply(img, g.resize((w, h)).convert("RGB"))


def cigarette(tex, length, lit, v_centre):
    s = PX_MM * SS
    L = round(length * s)
    D = round(DIAM_MM * s)
    fl = round(FILTER_MM * s)
    tip = round(TIP_MM * s) if lit else 0
    pl = L - fl - tip
    body = Image.new("RGB", (L, D))
    # paper keeps its end next to the filter (with the logo); a shorter one loses strip
    # from the burnt end
    u0 = max(PAPER_U[0], PAPER_U[1] - round(pl / s * STRIP_PX_MM))
    body.paste(wrap(tex, u0, PAPER_U[1], pl, D, v_centre), (tip, 0))
    if lit:
        body.paste(wrap(tex, *CHAR_U, round(1.5 * s), D, v_centre), (tip, 0))
    body.paste(wrap(tex, *FILTER_U, fl, D, v_centre), (L - fl, 0))
    mask = Image.new("L", (L, D), 0)
    md = ImageDraw.Draw(mask)
    md.rounded_rectangle((tip, 0, L - 1, D - 1), radius=SS, fill=255)
    if lit:
        ash = tex.crop(ASH_UV).resize((tip + SS, D), Image.LANCZOS)
        body.paste(ash.convert("L").point(lambda v: int(70 + v * 0.45)).convert("RGB"), (0, 0))
        md.rounded_rectangle((0, round(D * 0.08), tip + 2 * SS, D - 1 - round(D * 0.08)), radius=round(D * 0.38), fill=255)
        glow = Image.new("RGB", (L, D), (0, 0, 0))
        ImageDraw.Draw(glow).rectangle((tip - round(1.0 * s), D * 0.05, tip + round(0.3 * s), D * 0.95), fill=(230, 60, 10))
        body = ImageChops.add(body, glow.filter(ImageFilter.GaussianBlur(SS * 0.8)))
    img = shade(body).convert("RGBA")
    img.putalpha(mask)
    return img


def cig_icon(tex, length, lit, v_centre):
    cig = cigarette(tex, length, lit, v_centre)
    # soft dark rim so the icon reads on light inventory backgrounds
    pad = 4 * SS
    rim = Image.new("RGBA", (cig.width + 2 * pad, cig.height + 2 * pad), (0, 0, 0, 0))
    halo = Image.new("L", rim.size, 0)
    halo.paste(cig.getchannel("A"), (pad, pad))
    rim.putalpha(halo.filter(ImageFilter.MaxFilter(2 * (SS // 2) + 1)).point(lambda v: v * 0.55))
    rim.alpha_composite(cig, (pad, pad))
    rot = rim.rotate(ANGLE, expand=True, resample=Image.BICUBIC)
    # place it so the filter end lands on FILTER_END
    dx, dy = rim.width / 2 - pad - 1, 0
    a = math.radians(ANGLE)
    rx, ry = dx * math.cos(a) + dy * math.sin(a), -dx * math.sin(a) + dy * math.cos(a)
    canvas = Image.new("RGBA", (128 * SS, 128 * SS), (0, 0, 0, 0))
    canvas.alpha_composite(rot, (round(FILTER_END[0] * SS - rot.width / 2 - rx), round(FILTER_END[1] * SS - rot.height / 2 - ry)))
    return canvas.resize((128, 128), Image.LANCZOS)


# ---------- preview ----------

def preview_sheet(icons, path):
    font = ImageFont.truetype("bahnschrift.ttf", 18) if os.name == "nt" else ImageFont.load_default()
    cell, small = 200, 64
    names = list(icons)
    sheet = Image.new("RGBA", (len(names) * (cell + 10) + 10, 2 * (cell + 10) + small + 50), (236, 232, 226, 255))
    d = ImageDraw.Draw(sheet)
    for i, name in enumerate(names):
        x = 10 + i * (cell + 10)
        d.text((x + cell / 2, 14), name.replace("gear_", "").replace("_x_ca", ""), font=font, fill=(40, 40, 40), anchor="mm")
        for j, bg in enumerate(((40, 42, 38, 255), (150, 150, 140, 255))):
            tile = Image.new("RGBA", (cell, cell), bg)
            tile.alpha_composite(icons[name].resize((cell, cell), Image.LANCZOS))
            sheet.alpha_composite(tile, (x, 28 + j * (cell + 10)))
        tile = Image.new("RGBA", (small, small), (40, 42, 38, 255))
        tile.alpha_composite(icons[name].resize((small, small), Image.LANCZOS))
        sheet.alpha_composite(tile, (x + (cell - small) // 2, 28 + 2 * (cell + 10)))
    sheet.save(path)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("addon", help="addon folder name, e.g. voron")
    parser.add_argument("--out", help="folder for the PNGs and preview.png (default: a temp folder)")
    parser.add_argument("--apply", action="store_true", help="also write the PAAs to addons/<addon>/data/UI/")
    parser.add_argument("--logo-v", type=float, help="v centre of the paper's logo, when auto-detection picks the wrong spot")
    args = parser.parse_args()

    data = os.path.join("addons", args.addon, "data")
    tex_paa = os.path.join(data, "texture.paa")
    if not os.path.exists(tex_paa):
        sys.exit(f"{tex_paa} not found (run this from the repository root)")
    out = args.out or tempfile.mkdtemp(prefix=f"gear_icons_{args.addon}_")
    os.makedirs(out, exist_ok=True)

    tex_png = os.path.join(out, "_texture.png")
    hemtt_convert(tex_paa, tex_png)
    tex = Image.open(tex_png).convert("RGB")

    v_centre, logo = (args.logo_v, None) if args.logo_v else find_logo_v(tex)
    if v_centre is None:
        v_centre = sum(STRIP_V) / 2
        print(f"no logo found on the paper, wrapping around v {v_centre:.0f}")
    elif logo:
        print(f"logo at v {logo[0]}-{logo[1]}, wrapping around v {v_centre:.0f}")
    visible = STRIP_PX_MM * math.pi * DIAM_MM / 2
    if logo and logo[1] - logo[0] > visible:
        print(f"warning: the logo is {logo[1] - logo[0]} px tall, only {visible:.0f} px of it fits on the visible side")

    icons = {}
    if os.path.exists(os.path.join(data, "cigpack.p3d")):
        icons["gear_cigpack_x_ca"] = pack_icon(tex)
    for i, (length, lit) in enumerate(STAGES):
        icons[f"gear_cig{i}_x_ca"] = cig_icon(tex, length, lit, v_centre)

    for name, img in icons.items():
        img.save(os.path.join(out, name + ".png"))
    preview_sheet(icons, os.path.join(out, "preview.png"))
    print(f"wrote {len(icons)} icons and preview.png to {out}")

    if args.apply:
        ui = os.path.join(data, "UI")
        for name in icons:
            hemtt_convert(os.path.join(out, name + ".png"), os.path.join(ui, name + ".paa"))
        print(f"converted them to PAA in {ui}")


if __name__ == "__main__":
    main()
