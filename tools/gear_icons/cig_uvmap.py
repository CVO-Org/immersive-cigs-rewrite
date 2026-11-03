#!/usr/bin/env python3
"""
Shows how a cigarette model maps the texture strip along its length: every side section
as "mm from the burnt end -> u pixel" at both ends, with its scale in pixels per mm.
Use it to check which part of the strip (and so which logo) a stage really shows.

    python tools/gear_icons/cig_uvmap.py addons/base/data/cig0.p3d addons/base/data/cig1.p3d
"""

import argparse
import math

from mlod import read


def sections(path, size=1024):
    """Returns (length mm, [(mm0, u0, mm1, u1, lit, v0, v1)]) for the first LOD."""
    lod = read(path)[0]
    pts = lod["pts"]
    # the cigarette's axis runs between the two points farthest apart; a is the burnt end
    a, b = max(((p, q) for p in pts for q in pts), key=lambda pq: math.dist(*pq))
    if a[2] > b[2]:
        a, b = b, a
    length = math.dist(a, b)
    axis = [(y - x) / length for x, y in zip(a, b)]

    def along(p):
        return sum((pc - ac) * k for pc, ac, k in zip(p, a, axis)) * 1000

    merged = {}
    for verts, tex, mat in lod["faces"]:
        ends = sorted((round(along(pts[pi]), 1), round(u * size), round(v * size)) for pi, _, u, v in verts)
        if ends[-1][0] - ends[0][0] < 1.5:
            continue  # an end cap, not a side face
        lo = next(e for e in ends if e[0] == ends[0][0])
        hi = next(e for e in ends if e[0] == ends[-1][0])
        key = (ends[0][0], lo[1], ends[-1][0], hi[1], "lit" in mat.lower())
        v0, v1 = merged.get(key, (size, 0))
        merged[key] = (min(v0, *(e[2] for e in ends)), max(v1, *(e[2] for e in ends)))
    return length * 1000, [k + v for k, v in sorted(merged.items())]


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("models", nargs="+", help="cigarette MLOD .p3d files")
    parser.add_argument("--size", type=int, default=1024, help="texture size (default 1024)")
    args = parser.parse_args()
    for path in args.models:
        length, secs = sections(path, args.size)
        print(f"== {path}: {length:.1f} mm")
        for m0, u0, m1, u1, lit, v0, v1 in secs:
            scale = abs(u1 - u0) / max(0.1, m1 - m0)
            print(f"   {m0:5.1f}-{m1:5.1f} mm  u {u0:4d} -> {u1:4d}  ({scale:.2f} px/mm)  v {v0}-{v1}{'  lit material' if lit else ''}")


if __name__ == "__main__":
    main()
