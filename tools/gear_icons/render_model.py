#!/usr/bin/env python3
"""
Renders an MLOD model's first LOD with a texture, to check UVs and geometry without
Object Builder. Orthographic, flat-shaded, painter's algorithm: good enough to see which
part of the texture lands where, not a substitute for a look in-game.

Cigarettes are drawn from the side with the mouth end on the right; anything else from
the front. Several models are stacked, left-aligned at their mouth end, at one scale.

    python tools/gear_icons/render_model.py addons/base/data/cig0.p3d addons/base/data/cig4.p3d --texture addons/kosmos/data/texture.paa --out .hemttout/icons/kosmos_models.png
"""

import argparse
import math
import os
import tempfile

from PIL import Image, ImageDraw

from cig_models import Cig
from gear_icons import hemtt_convert
from mlod import load

BG = (40, 42, 38)


def view_basis(lod):
    # x along the cigarette (to the mouth), y up the screen, z towards the viewer
    cig = Cig(lod)
    x = cig.axis
    up = [0.0, 1.0, 0.0] if abs(x[1]) < 0.9 else [1.0, 0.0, 0.0]
    z = [x[1] * up[2] - x[2] * up[1], x[2] * up[0] - x[0] * up[2], x[0] * up[1] - x[1] * up[0]]
    n = math.sqrt(sum(c * c for c in z))
    z = [c / n for c in z]
    y = [z[1] * x[2] - z[2] * x[1], z[2] * x[0] - z[0] * x[2], z[0] * x[1] - z[1] * x[0]]
    return cig, x, y, z


def render(lod, tex, px_mm, mouth_x, height):
    cig, bx, by, bz = view_basis(lod)
    mouth = [a + k * cig.length / 1000 for a, k in zip(cig.a, cig.axis)]
    dot = lambda p, b: sum((pc - mc) * bc for pc, mc, bc in zip(p, mouth, b)) * 1000
    pts = [(mouth_x + dot(p["pos"], bx) * px_mm, height / 2 - dot(p["pos"], by) * px_mm, dot(p["pos"], bz)) for p in lod["points"]]
    img = Image.new("RGB", (mouth_x + 20, height), BG)
    tw, th = tex.size
    tris = []
    for f in lod["faces"]:
        vs = f["verts"]
        for tri in ([vs[0], vs[1], vs[2]], [vs[0], vs[2], vs[3]]) if len(vs) == 4 else [vs]:
            p = [pts[v[0]] for v in tri]
            # screen-space winding tells front from back; Arma faces are clockwise
            area = (p[1][0] - p[0][0]) * (p[2][1] - p[0][1]) - (p[2][0] - p[0][0]) * (p[1][1] - p[0][1])
            tris.append((sum(q[2] for q in p) / 3, area, p, [(v[2] * tw, v[3] * th) for v in tri]))
    front = [t for t in tris if t[1] < 0] or tris
    for depth, area, p, uv in sorted(front, key=lambda t: t[0]):
        # affine map from screen to texture for this triangle
        (x0, y0, _), (x1, y1, _), (x2, y2, _) = p
        det = (x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0)
        if abs(det) < 1e-6:
            continue
        (u0, v0), (u1, v1), (u2, v2) = uv
        a = ((u1 - u0) * (y2 - y0) - (u2 - u0) * (y1 - y0)) / det
        b = ((u2 - u0) * (x1 - x0) - (u1 - u0) * (x2 - x0)) / det
        d = ((v1 - v0) * (y2 - y0) - (v2 - v0) * (y1 - y0)) / det
        e = ((v2 - v0) * (x1 - x0) - (v1 - v0) * (x2 - x0)) / det
        warped = tex.transform(img.size, Image.AFFINE, (a, b, u0 - a * x0 - b * y0, d, e, v0 - d * x0 - e * y0), Image.BICUBIC)
        # light from above-front: shade by how much the face points up the screen
        ny = ((p[1][1] - p[0][1]) * 0 + 1)
        cy = sum(q[1] for q in p) / 3
        light = 0.62 + 0.38 * max(0.0, min(1.0, 1 - abs(cy - height / 2 + height * 0.12) / (height * 0.5))) * ny
        warped = warped.point(lambda c: int(c * light))
        mask = Image.new("L", img.size, 0)
        ImageDraw.Draw(mask).polygon([(q[0], q[1]) for q in p], fill=255)
        img.paste(warped, (0, 0), mask)
    return img


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("models", nargs="+", help="MLOD .p3d files")
    parser.add_argument("--texture", required=True, help="texture to put on every face (.paa or .png)")
    parser.add_argument("--out", required=True, help="PNG to write")
    parser.add_argument("--px-mm", type=float, default=12, help="scale in pixels per mm (default 12)")
    args = parser.parse_args()

    src = args.texture
    if src.lower().endswith(".paa"):
        src = os.path.join(tempfile.mkdtemp(prefix="render_model_"), "texture.png")
        hemtt_convert(args.texture, src)
    tex = Image.open(src).convert("RGB")
    lods = [load(m)["lods"][0] for m in args.models]
    longest = max(Cig(l).length for l in lods)
    mouth_x = int(longest * args.px_mm) + 20
    height = int(12 * args.px_mm)
    rows = [render(l, tex, args.px_mm, mouth_x, height) for l in lods]
    sheet = Image.new("RGB", (mouth_x + 20, len(rows) * height), BG)
    d = ImageDraw.Draw(sheet)
    for i, (row, path) in enumerate(zip(rows, args.models)):
        sheet.paste(row, (0, i * height))
        d.text((6, i * height + 4), f"{os.path.basename(path)}  {Cig(lods[i]).length:.1f} mm", fill=(220, 220, 210))
    os.makedirs(os.path.dirname(args.out) or ".", exist_ok=True)
    sheet.save(args.out)
    print(f"wrote {args.out}")


if __name__ == "__main__":
    main()
