#!/usr/bin/env python3
"""
Edits the base cigarette models in addons/base/data/.

  fix-base   cig1..4: map the paper so it keeps its filter end (and the logo printed
             there) as the cigarette burns down, at the strip's true scale of 6.57 px/mm.
             Adds a ring 1 mm from the burnt end for the charred edge (u 3-10). Skips a
             model that already has it.
  nofilter   writes cig_nofilter0..4.p3d from the (fixed) cig0..4: the same cigarette
             without the filter, closed with the tobacco end cap, the mouth end where
             the filter's end was. Lengths 56, 56, 44, 32, 20 mm.

    python tools/gear_icons/cig_models.py fix-base
    python tools/gear_icons/cig_models.py nofilter

Check the result with cig_uvmap.py, and in Object Builder or in-game before committing.
"""

import argparse
import copy
import math
import os

from mlod import load, remove_points, save, set_sharp_edges, sharp_edges

DATA = os.path.join("addons", "base", "data")
PX = 1 / 1024           # one texture pixel in UV units
STRIP_PX_MM = 6.57      # strip pixels per mm along the cigarette
CHAR_MM = 1.0           # width of the charred edge ring
CHAR_U = (3, 10)        # charred edge on the strip
PAPER_END_U = 389       # where the paper meets the filter on the strip
FILTER_U = (390, 586)   # filter side faces lie in this u range
FILTER_CAP = (658, 119)     # centre of the filter's end disc on the texture
TOBACCO_CAP = (755, 120)    # centre of the tobacco end disc (the unlit burnt end)
NOFILTER_MM = [56.0, 56.0, 44.0, 32.0, 20.0]


class Cig:
    """The visual LOD of a cigarette, with distances along its axis in mm."""

    def __init__(self, lod):
        self.lod = lod
        pos = [p["pos"] for p in lod["points"]]
        # the axis is the principal direction of all points (power iteration on their
        # covariance), so it runs down the middle of the rings, pointing to the mouth (+z)
        c = [sum(p[i] for p in pos) / len(pos) for i in range(3)]
        d = [[p[i] - c[i] for i in range(3)] for p in pos]
        cov = [[sum(q[i] * q[j] for q in d) for j in range(3)] for i in range(3)]
        axis = [0.0, 0.0, 1.0]
        for _ in range(100):
            axis = [sum(cov[i][j] * axis[j] for j in range(3)) for i in range(3)]
            n = math.sqrt(sum(x * x for x in axis))
            axis = [x / n for x in axis]
        if axis[2] < 0:
            axis = [-x for x in axis]
        ts = [sum(q[i] * axis[i] for i in range(3)) for q in d]
        self.axis = axis
        self.a = [c[i] + axis[i] * min(ts) for i in range(3)]   # burnt end, on the axis
        self.length = (max(ts) - min(ts)) * 1000

    def t(self, i_or_pos):
        p = self.lod["points"][i_or_pos]["pos"] if isinstance(i_or_pos, int) else i_or_pos
        return sum((pc - ac) * k for pc, ac, k in zip(p, self.a, self.axis)) * 1000

    def radial(self, i):
        p = self.lod["points"][i]["pos"]
        t = self.t(i) / 1000
        return [pc - ac - t * k for pc, ac, k in zip(p, self.a, self.axis)]

    def move(self, i, mm):
        p = self.lod["points"][i]
        p["pos"] = [c + k * mm / 1000 for c, k in zip(p["pos"], self.axis)]

    def is_side(self, f):
        ts = [self.t(v[0]) for v in f["verts"]]
        return max(ts) - min(ts) > 1.5

    def paper_faces(self):
        # side faces on the paper part of the strip, without the charred edge ring
        return [f for f in self.lod["faces"] if self.is_side(f) and max(v[2] for v in f["verts"]) <= FILTER_U[0] * PX
                and max(v[2] for v in f["verts"]) > (CHAR_U[1] + 1) * PX]

    def has_char_ring(self):
        return any(all((CHAR_U[0] - 0.5) * PX <= v[2] <= (CHAR_U[1] + 0.5) * PX for v in f["verts"]) for f in self.lod["faces"])


def ends(cig, f):
    """Splits a side face's vertices into (burnt-side, mouth-side) lists, each vertex
    paired with its neighbour on the same line along the cigarette."""
    vs = f["verts"]
    tmin = min(cig.t(v[0]) for v in vs)
    burnt = [k for k, v in enumerate(vs) if cig.t(v[0]) - tmin < 1.0]
    pairs = []
    for k in burnt:
        n = len(vs)
        other = next(j for j in ((k - 1) % n, (k + 1) % n) if j not in burnt)
        pairs.append((k, other))
    return pairs


def remap_paper(cig):
    # the filter-side end shows the strip's end (u 389, next to the filter); the burnt
    # side runs back from there at true scale
    for f in cig.paper_faces():
        for kb, km in ends(cig, f):
            vb, vm = f["verts"][kb], f["verts"][km]
            vm[2] = PAPER_END_U * PX
            vb[2] = vm[2] - (cig.t(vm[0]) - cig.t(vb[0])) * STRIP_PX_MM * PX
        f["uv2"] = None


def add_char_ring(cig):
    lod = cig.lod
    new_point = {}
    for f in list(cig.paper_faces()):
        char = copy.deepcopy(f)
        for kb, km in ends(cig, f):
            pi = f["verts"][kb][0]
            if pi not in new_point:
                p = copy.deepcopy(lod["points"][pi])
                lod["points"].append(p)
                new_point[pi] = len(lod["points"]) - 1
                cig.move(new_point[pi], CHAR_MM)
            q = new_point[pi]
            # paper face now starts at the ring; the char face runs from the burnt end to it
            f["verts"][kb][0] = q
            char["verts"][km] = [q, f["verts"][kb][1], (CHAR_U[0] + CHAR_MM * STRIP_PX_MM) * PX, char["verts"][kb][3]]
            char["verts"][kb][2] = CHAR_U[0] * PX
        char["uv2"] = None
        lod["faces"].append(char)


def fix_base(args):
    for k in range(1, 5):
        path = os.path.join(DATA, f"cig{k}.p3d")
        model = load(path)
        cig = Cig(model["lods"][0])
        if cig.has_char_ring():
            print(f"{path}: already fixed, skipped")
            continue
        add_char_ring(cig)
        remap_paper(cig)
        save(model, path)
        print(f"{path}: added the charred edge ring, paper keeps its filter end")


def nofilter(args):
    for k, target in enumerate(NOFILTER_MM):
        model = load(os.path.join(DATA, f"cig{k}.p3d"))
        lod = model["lods"][0]
        cig = Cig(lod)
        if k and not cig.has_char_ring():
            raise SystemExit(f"cig{k}.p3d is not fixed yet, run fix-base first")
        faces = lod["faces"]
        u_in = lambda f, lo, hi: all(lo * PX <= v[2] <= hi * PX for v in f["verts"])
        filt = [f for f in faces if cig.is_side(f) and u_in(f, *FILTER_U)]
        cap = [f for f in faces if not cig.is_side(f) and u_in(f, 600, 720) and min(cig.t(v[0]) for v in f["verts"]) > cig.length - 3]
        assert len(filt) == 8 and len(cap) == 4, (k, len(filt), len(cap))
        mouth = {v[0] for f in filt for v in f["verts"] if cig.t(v[0]) > cig.length - 3}
        junction = {v[0] for f in filt for v in f["verts"]} - mouth
        to_j = {m: min(junction, key=lambda j: math.dist(cig.radial(j), cig.radial(m))) for m in mouth}
        assert len(set(to_j.values())) == len(junction) == len(mouth) == 8, f"cig{k}: mouth and junction rings don't match up"
        filter_mm = sum(cig.t(m) for m in mouth) / len(mouth) - sum(cig.t(j) for j in junction) / len(junction)

        # the end cap closes the paper at the junction ring and shows tobacco
        for f in cap:
            for v in f["verts"]:
                v[0] = to_j.get(v[0], v[0])
                v[2] += (TOBACCO_CAP[0] - FILTER_CAP[0]) * PX
                v[3] += (TOBACCO_CAP[1] - FILTER_CAP[1]) * PX
            f["uv2"] = None
        set_sharp_edges(lod, [[to_j.get(a, a), to_j.get(b, b)] for a, b in sharp_edges(lod)])
        lod["faces"] = [f for f in faces if not any(f is g for g in filt)]

        # slide everything but the cap centre down the axis so the junction ring sits
        # where the filter's end was, then pull the burnt end in to the stage's length
        centre = {v[0] for f in cap for v in f["verts"]} - set(to_j.values())
        jt = {j: cig.t(m) for m, j in to_j.items()}
        paper_mm = cig.length - filter_mm
        burnt = [i for i in range(len(lod["points"])) if i not in mouth and i not in junction and i not in centre]
        orig_t = {i: cig.t(i) for i in range(len(lod["points"]))}
        for j, t_new in jt.items():
            cig.move(j, t_new - orig_t[j])
        for i in burnt:
            cig.move(i, filter_mm + paper_mm - target)
        remove_points(lod, mouth)

        # shadow LODs: the burnt-end half of the box moves with the burnt end
        for shadow in model["lods"][1:]:
            for p in shadow["points"]:
                if cig.t(p["pos"]) < cig.length / 2:
                    p["pos"] = [c + kx * (cig.length - target) / 1000 for c, kx in zip(p["pos"], cig.axis)]

        remap_paper(Cig(lod))
        out = os.path.join(DATA, f"cig_nofilter{k}.p3d")
        save(model, out)
        print(f"{out}: {Cig(model['lods'][0]).length:.1f} mm")


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="cmd", required=True)
    sub.add_parser("fix-base", help="cig1..4 keep the paper's filter end").set_defaults(run=fix_base)
    sub.add_parser("nofilter", help="write cig_nofilter0..4.p3d").set_defaults(run=nofilter)
    args = parser.parse_args()
    args.run(args)


if __name__ == "__main__":
    main()
