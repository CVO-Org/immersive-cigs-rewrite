#!/usr/bin/env python3
"""
Reads unbinarized Arma models (MLOD .p3d, as saved by Object Builder): points, faces with
UVs, textures, materials and named selections. Read-only; it never writes a model.

As a script it summarises each model's first LOD; --faces lists every face.

    python tools/gear_icons/mlod.py addons/base/data/cig0.p3d
    python tools/gear_icons/mlod.py addons/base/data/cigpack.p3d --faces
"""

import argparse
import struct


def _asciiz(d, o):
    e = d.index(b"\0", o)
    return d[o:e].decode("latin1"), e + 1


def read(path):
    """Returns a list of LODs: dict(res, pts, faces, sels).
    pts: [(x, y, z)] in metres. faces: [(verts, texture, material)], each vert
    (point index, normal index, u, v) with u, v in 0..1. sels: {name: [face indices]}."""
    d = open(path, "rb").read()
    if d[:4] != b"MLOD":
        raise ValueError(f"{path}: not an MLOD model ({d[:4]!r}), binarized models are not supported")
    nlods = struct.unpack_from("<i", d, 8)[0]
    o = 12
    lods = []
    for _ in range(nlods):
        assert d[o:o + 4] == b"P3DM", (path, o, d[o:o + 4])
        npts, nnrm, nfac = struct.unpack_from("<3i", d, o + 12)
        o += 28
        pts = [struct.unpack_from("<3fI", d, o + i * 16)[:3] for i in range(npts)]
        o += npts * 16 + nnrm * 12
        faces = []
        for _ in range(nfac):
            n = struct.unpack_from("<i", d, o)[0]
            verts = [struct.unpack_from("<iiff", d, o + 4 + k * 16) for k in range(4)][:n]
            o += 4 + 64 + 4
            tex, o = _asciiz(d, o)
            mat, o = _asciiz(d, o)
            faces.append((verts, tex, mat))
        assert d[o:o + 4] == b"TAGG"
        o += 4
        sels = {}
        while True:
            o += 1
            name, o = _asciiz(d, o)
            size = struct.unpack_from("<i", d, o)[0]
            o += 4
            data = d[o:o + size]
            o += size
            if name == "#EndOfFile#":
                break
            # named selections hold one weight byte per point, then one per face
            if not name.startswith("#") and size == npts + nfac:
                sels[name] = [i for i in range(nfac) if data[npts + i]]
        res = struct.unpack_from("<f", d, o)[0]
        o += 4
        lods.append(dict(res=res, pts=pts, faces=faces, sels=sels))
    return lods


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("models", nargs="+", help="MLOD .p3d files")
    parser.add_argument("--faces", action="store_true", help="list every face of the first LOD: UVs in texture pixels and positions in mm")
    parser.add_argument("--size", type=int, default=1024, help="texture size for the pixel UVs (default 1024)")
    args = parser.parse_args()

    for path in args.models:
        lods = read(path)
        lod = lods[0]
        pts = lod["pts"]
        print(f"== {path}: {len(lods)} LODs {[round(l['res'], 3) for l in lods]}, {len(pts)} points, {len(lod['faces'])} faces")
        ext = [(min(p[i] for p in pts) * 1000, max(p[i] for p in pts) * 1000) for i in range(3)]
        print("   extents mm  " + "  ".join(f"{a}: {lo:.1f}..{hi:.1f}" for a, (lo, hi) in zip("xyz", ext)))
        groups = {}
        for verts, tex, mat in lod["faces"]:
            groups.setdefault((tex, mat), []).append(verts)
        for (tex, mat), fl in groups.items():
            us = [v[2] * args.size for vs in fl for v in vs]
            vs_ = [v[3] * args.size for vs in fl for v in vs]
            print(f"   {len(fl):4d} faces  u {min(us):.0f}-{max(us):.0f}  v {min(vs_):.0f}-{max(vs_):.0f}  texture {tex or '-'}  material {mat or '-'}")
        print("   selections " + (", ".join(f"{k} ({len(v)} faces)" for k, v in lod["sels"].items()) or "-"))
        if args.faces:
            for i, (verts, tex, mat) in enumerate(lod["faces"]):
                uv = [(round(u * args.size), round(v * args.size)) for _, _, u, v in verts]
                xyz = [tuple(round(c * 1000, 1) for c in pts[p]) for p, _, _, _ in verts]
                print(f"   face {i:3d}  uv {uv}  xyz {xyz}")


if __name__ == "__main__":
    main()
