#!/usr/bin/env python3
"""
Renders a cigar brand's gear icons from the models, so they match what the game shows.

  stages  gear_cigar0..4_x_ca, 256 x 256: the shared cigars addons/base/data/cigar0..4.p3d
          with the brand's data/cigars/cigar_co.paa, at 45 degrees, mouth end top right,
          burning down from the bottom left. The cigar is turned so its band's print
          faces you; --logo-v picks another spot.
  box     gear_cigarbox_5_x_ca, 512 x 512: the brand's data/cigarbox_5/cigarbox_5.p3d in
          3/4 view from the front right and slightly above, with the textures its faces
          name (so run mlod.py --rename first).
  layout  draws the UV layout over the brand's textures: cigar_layout.png (wrapper, head,
          foot, ash, ember) and box_layout.png (the box's faces by the way they face).
          Use it to see where to paint before retexturing.

    python tools/gear_icons/cigar_icons.py stages papa_schultz --out .hemttout/icons/papa_schultz
    python tools/gear_icons/cigar_icons.py box papa_schultz --out .hemttout/icons/papa_schultz
    python tools/gear_icons/cigar_icons.py all papa_schultz --out .hemttout/icons/papa_schultz --apply

Without --apply it only writes PNGs and preview.png; with --apply it also writes the PAAs
into addons/<addon>/data/UI/. The renderer is a z-buffered rasteriser with smooth
shading, lit from the top left; the lit tip (cigar_lit material) glows unshaded.

Requires Pillow and numpy (pip install pillow numpy) and hemtt on PATH.
"""

import argparse
import math
import os
import shutil
import tempfile

import numpy as np
from PIL import Image, ImageDraw

from gear_icons import hemtt_convert
from mlod import load

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
MAINPREFIX = "zrn\\cigs\\"

STAGE_SIZE = 256
BOX_SIZE = 512
SS = 4                      # supersampling
MOUTH_AT = (232, 24)        # where the mouth end sits in every stage, in icon pixels
FIT = 0.84                  # cigar0 spans this much of the icon's diagonal
BOX_YAW = 28                # degrees: turn to show the right side
BOX_PITCH = 16              # degrees: look down onto the top
LIGHT = (-0.45, 0.65, -0.6)  # towards the light: left, up, towards the viewer
TILT = 22                   # degrees: the burning end leans towards you, so its ember shows


def norm(v):
    v = np.asarray(v, dtype=float)
    return v / np.linalg.norm(v)


_tex_cache = {}


def texture(path):
    """A texture as an RGBA float array; .paa is converted with hemtt."""
    key = os.path.normcase(os.path.abspath(path))
    if key not in _tex_cache:
        src = path
        if path.lower().endswith(".paa"):
            src = os.path.join(tempfile.mkdtemp(prefix="cigar_icons_"), "t.png")
            hemtt_convert(path, src)
        _tex_cache[key] = np.asarray(Image.open(src).convert("RGBA"), dtype=float)
    return _tex_cache[key]


def game_path(p):
    """zrn\\cigs\\addons\\x\\data\\y.paa -> the file in this repository."""
    if not p or p == "-":
        return None
    low = p.lower().lstrip("\\")
    if low.startswith(MAINPREFIX):
        p = p.lstrip("\\")[len(MAINPREFIX):]
    local = os.path.join(ROOT, *p.split("\\"))
    return local if os.path.exists(local) else None


class Mesh:
    """Triangles of a model's first LOD with positions in mm, UVs, smooth normals and a texture slot each."""

    def __init__(self, path, default_tex=None):
        lod = load(path)["lods"][0]
        self.pos = np.array([p["pos"] for p in lod["points"]], dtype=float) * 1000
        tris, uvs, slots, glow = [], [], [], []
        self.textures = []
        names = {}
        for f in lod["faces"]:
            tex = game_path(f["tex"]) or default_tex
            if tex is None:
                continue
            if tex not in names:
                names[tex] = len(self.textures)
                self.textures.append(texture(tex))
            vs = f["verts"]
            for tri in ([vs[0], vs[1], vs[2]], [vs[0], vs[2], vs[3]]) if len(vs) == 4 else [vs]:
                tris.append([v[0] for v in tri])
                uvs.append([(v[2], v[3]) for v in tri])
                slots.append(names[tex])
                glow.append("_lit" in f["mat"].lower())
        self.tris = np.array(tris)
        self.uvs = np.array(uvs, dtype=float)
        self.slots = np.array(slots)
        self.glow = np.array(glow)
        self.normals = self._smooth_normals()

    def _smooth_normals(self, angle=50):
        p = self.pos[self.tris]
        fn = np.cross(p[:, 1] - p[:, 0], p[:, 2] - p[:, 0])
        fn /= np.maximum(np.linalg.norm(fn, axis=1, keepdims=True), 1e-12)
        # corners at the same spot share normals with neighbours less than `angle` apart
        key = [tuple(np.round(self.pos[i], 3)) for i in range(len(self.pos))]
        groups = {}
        for t, tri in enumerate(self.tris):
            for c, i in enumerate(tri):
                groups.setdefault(key[i], []).append((t, c))
        out = np.zeros((len(self.tris), 3, 3))
        cos = math.cos(math.radians(angle))
        for corners in groups.values():
            for t, c in corners:
                acc = np.zeros(3)
                for t2, _ in corners:
                    if fn[t] @ fn[t2] >= cos:
                        acc += fn[t2]
                out[t, c] = acc / max(np.linalg.norm(acc), 1e-12)
        return out


def render(mesh, right, up, size, place):
    """Orthographic render. right/up: model-space unit vectors for the screen axes.
    place(xy) -> (scale, offset) maps the projected mm to icon pixels."""
    right, up = norm(right), norm(up)
    into = np.cross(right, up)          # Arma is left-handed: x right, y up, z into the screen
    sx, sy = mesh.pos @ right, mesh.pos @ up
    scale, off = place(np.stack([sx, -sy], axis=1))
    n = size * SS
    xy = (np.stack([sx, -sy], axis=1) * scale + off) * SS
    depth = mesh.pos @ into
    light = norm(right * LIGHT[0] + up * LIGHT[1] - into * LIGHT[2])

    zbuf = np.full((n, n), np.inf)
    rgb = np.zeros((n, n, 3))
    cov = np.zeros((n, n))
    for t, tri in enumerate(mesh.tris):
        p = xy[tri]
        x0, y0 = np.floor(p.min(axis=0)).astype(int)
        x1, y1 = np.ceil(p.max(axis=0)).astype(int)
        x0, y0, x1, y1 = max(x0, 0), max(y0, 0), min(x1, n - 1), min(y1, n - 1)
        if x1 < x0 or y1 < y0:
            continue
        gx, gy = np.meshgrid(np.arange(x0, x1 + 1) + 0.5, np.arange(y0, y1 + 1) + 0.5)
        (ax, ay), (bx, by), (cx, cy) = p
        det = (bx - ax) * (cy - ay) - (cx - ax) * (by - ay)
        if abs(det) < 1e-9:
            continue
        w1 = ((gx - ax) * (cy - ay) - (cx - ax) * (gy - ay)) / det
        w2 = ((bx - ax) * (gy - ay) - (gx - ax) * (by - ay)) / det
        w0 = 1 - w1 - w2
        inside = (w0 >= -1e-6) & (w1 >= -1e-6) & (w2 >= -1e-6)
        if not inside.any():
            continue
        d = depth[tri]
        z = w0 * d[0] + w1 * d[1] + w2 * d[2]
        sub = zbuf[y0:y1 + 1, x0:x1 + 1]
        hit = inside & (z < sub - 1e-6)
        if not hit.any():
            continue
        tex = mesh.textures[mesh.slots[t]]
        th, tw = tex.shape[:2]
        uv = mesh.uvs[t]
        u = (w0 * uv[0, 0] + w1 * uv[1, 0] + w2 * uv[2, 0])[hit]
        v = (w0 * uv[0, 1] + w1 * uv[1, 1] + w2 * uv[2, 1])[hit]
        col = tex[np.clip((v * th).astype(int), 0, th - 1), np.clip((u * tw).astype(int), 0, tw - 1), :3]
        if mesh.glow[t]:
            shade = np.full(len(u), 1.15)
        else:
            nm = mesh.normals[t]
            nn = w0[hit, None] * nm[0] + w1[hit, None] * nm[1] + w2[hit, None] * nm[2]
            nn /= np.maximum(np.linalg.norm(nn, axis=1, keepdims=True), 1e-12)
            nn[(nn @ into) > 0] *= -1   # face the viewer: two-sided lighting
            lam = np.clip(nn @ light, 0, 1)
            rim = np.clip(1 + (nn @ into), 0, 1) ** 3   # edges seen side-on get a little darker
            shade = (0.62 + 0.62 * lam) * (1 - 0.3 * rim)
        ys, xs = np.nonzero(hit)
        ys += y0
        xs += x0
        zbuf[ys, xs] = z[hit]
        rgb[ys, xs] = np.clip(col * shade[:, None], 0, 255)
        cov[ys, xs] = 1
    img = Image.fromarray(np.dstack([rgb * cov[..., None], cov * 255]).astype(np.uint8), "RGBA")
    # downsample with premultiplied alpha, so edges don't pick up black
    small = img.resize((size, size), Image.BOX)
    a = np.asarray(small, dtype=float)
    alpha = a[..., 3:] / 255
    a[..., :3] = np.where(alpha > 0, a[..., :3] / np.maximum(alpha, 1e-6), 0)
    return Image.fromarray(np.clip(a, 0, 255).astype(np.uint8), "RGBA")


# ---------- cigars ----------

def cigar_axis(mesh):
    """Unit axis pointing to the mouth end, the mouth end's centre, and the length in mm."""
    c = mesh.pos.mean(axis=0)
    d = mesh.pos - c
    w, vecs = np.linalg.eigh(d.T @ d)
    axis = vecs[:, -1]
    if axis[2] < 0:
        axis = -axis
    t = d @ axis
    return axis, c + axis * t.max(), t.max() - t.min()


def find_logo_v(tex, v0, v1):
    """v (0..1) of the print on the band: the rows where more of the body differs from its row's
    typical colour than elsewhere. The band itself runs through every row, so it cancels out."""
    th, tw = tex.shape[:2]
    rows = tex[int(v0 * th):int(v1 * th), :, :3]
    med = np.median(rows, axis=1, keepdims=True)
    score = (np.abs(rows - med).max(axis=2) > 45).sum(axis=1).astype(float)
    base = np.median(score)
    hot = score > base + 0.5 * (score.max() - base)
    if score.max() - base < 6 or not hot.any():
        return None
    idx = np.nonzero(hot)[0]
    return (int(v0 * th) + idx.mean()) / th


def stage_views(meshes, logo_v):
    """The screen basis for the cigars: axis at 45 degrees, rising to the right, rolled so the
    body faces with v near logo_v look at the viewer."""
    m0 = meshes[0]
    axis, mouth, _ = cigar_axis(m0)
    # the body's sides: faces that run along the axis (not the end caps or the lit tip)
    span = np.ptp(m0.pos[m0.tris] @ axis, axis=1)
    body = ~m0.glow & (span > 3)
    tv = m0.uvs[body, :, 1].mean(axis=1)
    if logo_v is None:
        logo_v = find_logo_v(m0.textures[0], m0.uvs[body, :, 1].min(), m0.uvs[body, :, 1].max())
    if logo_v is None:
        towards = norm(np.cross(axis, [1.0, 0, 0]))
        print("no print found on the band: pass --logo-v to choose the side")
    else:
        # the body's side faces closest to that v, pushed off the axis
        sides = np.nonzero(body)[0][np.argsort(np.abs(tv - logo_v))[:4]]
        cen = m0.pos[m0.tris[sides]].mean(axis=(0, 1))
        r = cen - m0.pos.mean(axis=0)
        towards = norm(r - axis * (r @ axis))
        print(f"band print at v {logo_v * 1024:.0f} (of 1024)")
    # lean the burning end towards the viewer
    tilt = math.radians(TILT)
    into = norm(-towards * math.cos(tilt) + axis * math.sin(tilt))
    axis_s = norm(axis - into * (axis @ into))   # the axis as seen on screen
    a = math.radians(45)
    # screen right/up: the axis lies along (cos45, sin45) on screen
    perp = np.cross(into, axis_s)        # on screen, 90 degrees from the axis
    right = axis_s * math.cos(a) - perp * math.sin(a)
    up = axis_s * math.sin(a) + perp * math.cos(a)
    return right, up, mouth, axis


def render_stages(addon, logo_v):
    tex = os.path.join(ROOT, "addons", addon, "data", "cigars", "cigar_co.paa")
    if not os.path.exists(tex):
        raise SystemExit(f"{tex} not found")
    meshes = [Mesh(os.path.join(ROOT, "addons", "base", "data", f"cigar{i}.p3d"), tex) for i in range(5)]
    right, up, mouth, axis = stage_views(meshes, logo_v)
    _, _, length0 = cigar_axis(meshes[0])
    diag = math.hypot(MOUTH_AT[0] - (STAGE_SIZE - MOUTH_AT[0]), (STAGE_SIZE - MOUTH_AT[1]) - MOUTH_AT[1])
    scale = diag * FIT / length0
    mx, my = mouth @ right, -(mouth @ up)

    def place(_xy):
        return scale, np.array([MOUTH_AT[0] - mx * scale, MOUTH_AT[1] - my * scale])

    return [render(m, right, up, STAGE_SIZE, place) for m in meshes]


# ---------- box ----------

def render_box(addon):
    model = os.path.join(ROOT, "addons", addon, "data", "cigarbox_5", "cigarbox_5.p3d")
    if not os.path.exists(model):
        raise SystemExit(f"{model} not found")
    mesh = Mesh(model)
    lod = load(model)["lods"][0]
    wrong = sorted({f["tex"] for f in lod["faces"] if f["tex"] and f"\\{addon}\\" not in f["tex"].lower() and "\\base\\" not in f["tex"].lower()})
    if wrong:
        print("warning: the box still uses textures of another addon - run mlod.py --rename:\n  " + "\n  ".join(wrong))
    yaw, pitch = math.radians(BOX_YAW), math.radians(BOX_PITCH)
    # the box's front looks along -z; turn it to show its right side, then look down a little
    right = np.array([math.cos(yaw), 0, math.sin(yaw)])
    fwd = np.array([-math.sin(yaw), 0, math.cos(yaw)])
    up = np.array([0, math.cos(pitch), 0]) + fwd * math.sin(pitch)

    def place(xy):
        lo, hi = xy.min(axis=0), xy.max(axis=0)
        scale = BOX_SIZE * 0.9 / (hi - lo).max()
        return scale, BOX_SIZE / 2 - (lo + hi) / 2 * scale

    return render(mesh, right, up, BOX_SIZE, place)


# ---------- layout ----------

COLOURS = {
    "wrapper": (255, 210, 60), "head (mouth end)": (80, 200, 255), "foot, unlit (cigar0)": (120, 255, 120),
    "foot, ash (cigar1-4)": (200, 200, 200), "ember (lit tip)": (255, 90, 40),
    "front": (255, 70, 70), "back": (70, 255, 120), "right side": (70, 190, 255), "left side": (200, 120, 255),
    "top / lid": (255, 210, 60), "bottom": (255, 130, 200),
}


def poly_area(poly):
    return abs(sum(u0 * v1 - u1 * v0 for (u0, v0), (u1, v1) in zip(poly, poly[1:] + poly[:1]))) / 2


def draw_layout(tex_path, groups, out, title, largest=False):
    """groups: {label: [uv polygons in 0..1]} drawn over the texture, with a legend that gives
    each group's extent, or with largest=True the extent of its biggest face."""
    tex = Image.fromarray(texture(tex_path).astype(np.uint8), "RGBA").convert("RGB")
    size = tex.size[0]
    sheet = Image.new("RGB", (size + 300, max(size, 400)), (30, 30, 30))
    sheet.paste(tex, (0, 0))
    over = Image.new("RGBA", tex.size, (0, 0, 0, 0))
    d = ImageDraw.Draw(over)
    for label, polys in groups.items():
        c = COLOURS[label]
        for poly in polys:
            pts = [(u * size, v * size) for u, v in poly]
            d.polygon(pts, fill=c + (60,), outline=c + (255,))
    sheet.paste(over, (0, 0), over)
    d = ImageDraw.Draw(sheet)
    d.text((size + 14, 12), title, fill=(240, 240, 240))
    y = 40
    for label, polys in groups.items():
        if not polys:
            continue
        pick = [max(polys, key=poly_area)] if largest else polys
        us = [u for p in pick for u, _ in p]
        vs = [v for p in pick for _, v in p]
        d.rectangle((size + 14, y, size + 30, y + 16), fill=COLOURS[label])
        d.text((size + 38, y), label, fill=(240, 240, 240))
        d.text((size + 38, y + 16), ("biggest face: " if largest else "") + f"u {min(us) * size:.0f}-{max(us) * size:.0f}  v {min(vs) * size:.0f}-{max(vs) * size:.0f}", fill=(170, 170, 170))
        y += 44
    sheet.save(out)
    print(f"wrote {out}")


def polys(mesh, sel):
    return [[tuple(uv) for uv in mesh.uvs[t]] for t in np.nonzero(sel)[0]]


def layout(addon, out):
    tex = os.path.join(ROOT, "addons", addon, "data", "cigars", "cigar_co.paa")
    groups = {k: [] for k in ("wrapper", "head (mouth end)", "foot, unlit (cigar0)", "foot, ash (cigar1-4)", "ember (lit tip)")}
    for i in (0, 1):
        m = Mesh(os.path.join(ROOT, "addons", "base", "data", f"cigar{i}.p3d"), tex)
        axis, mouth, _ = cigar_axis(m)
        t = (m.pos[m.tris] - mouth) @ axis
        side = np.ptp(t, axis=1) > 3
        near_mouth = t.mean(axis=1) > -10
        if i == 0:
            groups["wrapper"] += polys(m, side & ~m.glow)
            groups["head (mouth end)"] += polys(m, ~side & near_mouth)
            groups["foot, unlit (cigar0)"] += polys(m, ~side & ~near_mouth)
        else:
            groups["foot, ash (cigar1-4)"] += polys(m, ~side & ~near_mouth & ~m.glow)
            groups["ember (lit tip)"] += polys(m, m.glow)
    draw_layout(tex, groups, os.path.join(out, "cigar_layout.png"), f"{addon}: data/cigars/cigar_co.paa")

    model = os.path.join(ROOT, "addons", addon, "data", "cigarbox_5", "cigarbox_5.p3d")
    if not os.path.exists(model):
        return
    m = Mesh(model)
    p = m.pos[m.tris]
    n = np.cross(p[:, 1] - p[:, 0], p[:, 2] - p[:, 0])
    n /= np.maximum(np.linalg.norm(n, axis=1, keepdims=True), 1e-12)
    out_dir = p.mean(axis=1) - m.pos.mean(axis=0)
    n[(n * out_dir).sum(axis=1) < 0] *= -1   # point outwards
    names = {(2, -1): "front", (2, 1): "back", (0, 1): "right side", (0, -1): "left side", (1, 1): "top / lid", (1, -1): "bottom"}
    # the box's own texture, not the cigar_co of the cigars inside it
    lod = load(model)["lods"][0]
    box_tex = next(game_path(f["tex"]) for f in lod["faces"] if "cigarbox" in f["tex"].lower())
    box_slot = [i for i, t in enumerate(m.textures) if t is texture(box_tex)][0]
    groups = {k: [] for k in ("front", "back", "right side", "left side", "top / lid", "bottom")}
    for t in np.nonzero(m.slots == box_slot)[0]:
        ax = int(np.argmax(np.abs(n[t])))
        groups[names[(ax, int(np.sign(n[t][ax])))]].append([tuple(uv) for uv in m.uvs[t]])
    draw_layout(box_tex, groups, os.path.join(out, "box_layout.png"), f"{addon}: data/cigarbox_5/cigarbox_5_co.paa", largest=True)


# ---------- output ----------

def preview(icons, out):
    names = list(icons)
    cell = 200
    sheet = Image.new("RGB", (cell * len(names) + 10, cell * 2 + 110), (236, 233, 226))
    d = ImageDraw.Draw(sheet)
    for i, name in enumerate(names):
        x = 10 + i * cell
        d.text((x, 4), name, fill=(40, 40, 40))
        for row, bg in enumerate(((40, 42, 38), (150, 150, 142))):
            tile = Image.new("RGB", (cell - 10, cell - 10), bg)
            icon = icons[name].resize((cell - 10, cell - 10), Image.LANCZOS)
            tile.paste(icon, (0, 0), icon)
            sheet.paste(tile, (x, 20 + row * cell))
        small = Image.new("RGB", (64, 64), (40, 42, 38))
        icon = icons[name].resize((64, 64), Image.LANCZOS)
        small.paste(icon, (0, 0), icon)
        sheet.paste(small, (x + 63, 30 + 2 * cell))
    sheet.save(out)


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("what", choices=["stages", "box", "all", "layout"], help="which icons to render, or layout: draw the textures' UV layout")
    ap.add_argument("addon", help="addon folder name, e.g. papa_schultz")
    ap.add_argument("--out", help="folder for the PNGs and preview.png (default: a temp folder)")
    ap.add_argument("--apply", action="store_true", help="also write the PAAs to addons/<addon>/data/UI/")
    ap.add_argument("--logo-v", type=float, help="v pixel (of 1024) on the cigar texture to turn towards the viewer")
    args = ap.parse_args()

    out = args.out or tempfile.mkdtemp(prefix="cigar_icons_")
    os.makedirs(out, exist_ok=True)
    if args.what == "layout":
        layout(args.addon, out)
        return
    icons = {}
    if args.what in ("box", "all"):
        icons["gear_cigarbox_5_x_ca"] = render_box(args.addon)
    if args.what in ("stages", "all"):
        logo_v = args.logo_v / 1024 if args.logo_v is not None else None
        for i, img in enumerate(render_stages(args.addon, logo_v)):
            icons[f"gear_cigar{i}_x_ca"] = img
    for name, img in icons.items():
        img.save(os.path.join(out, name + ".png"))
    preview(icons, os.path.join(out, "preview.png"))
    print(f"wrote {len(icons)} icons and preview.png to {out}")

    if args.apply:
        ui = os.path.join(ROOT, "addons", args.addon, "data", "UI")
        os.makedirs(ui, exist_ok=True)
        for name in icons:
            hemtt_convert(os.path.join(out, name + ".png"), os.path.join(ui, name + ".paa"))
        print(f"wrote {len(icons)} PAAs to {ui}")


if __name__ == "__main__":
    main()
