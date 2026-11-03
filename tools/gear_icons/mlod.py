#!/usr/bin/env python3
"""
Reads and writes unbinarized Arma models (MLOD .p3d, as saved by Object Builder).

load() keeps everything in the file, so save() writes it back byte for byte. Points and
faces carry their own selection weights, so adding or removing them keeps every named
selection, #SharpEdges# and #UVSet# in step.

As a script it summarises each model's first LOD; --faces lists every face.

    python tools/gear_icons/mlod.py addons/base/data/cig0.p3d
    python tools/gear_icons/mlod.py addons/base/data/cigpack.p3d --faces
    python tools/gear_icons/mlod.py --roundtrip addons/base/data/*.p3d
    python tools/gear_icons/mlod.py addons/mybrand/data/cigpack.p3d --rename addons\\morley\\ addons\\mybrand\\
"""

import argparse
import glob
import struct


def _asciiz(d, o):
    e = d.index(b"\0", o)
    return d[o:e].decode("latin1"), e + 1


# ---------- full model ----------

def load(path):
    """Returns dict(version, lods). Each LOD: dict(res, version, flags, points, normals,
    faces, tags).
    points: [dict(pos=[x, y, z], flag, sel={name: weight byte}, mass)]
    faces:  [dict(verts=[[point, normal, u, v] * n], flags, tex, mat, sel={name: byte}, uv2)]
    tags:   [(active, name, kind, raw)] in file order; kind says how save() rebuilds it."""
    d = open(path, "rb").read()
    if d[:4] != b"MLOD":
        raise ValueError(f"{path}: not an MLOD model ({d[:4]!r}), binarized models are not supported")
    version, nlods = struct.unpack_from("<2i", d, 4)
    o = 12
    lods = []
    for _ in range(nlods):
        assert d[o:o + 4] == b"P3DM", (path, o, d[o:o + 4])
        major, minor, npts, nnrm, nfac, flags = struct.unpack_from("<6i", d, o + 4)
        o += 28
        points = []
        for i in range(npts):
            x, y, z, f = struct.unpack_from("<3fI", d, o + i * 16)
            points.append(dict(pos=[x, y, z], flag=f, sel={}, mass=None))
        o += npts * 16
        normals = [list(struct.unpack_from("<3f", d, o + i * 12)) for i in range(nnrm)]
        o += nnrm * 12
        faces = []
        for _ in range(nfac):
            n = struct.unpack_from("<i", d, o)[0]
            verts = [list(struct.unpack_from("<iiff", d, o + 4 + k * 16)) for k in range(4)]
            fflags = struct.unpack_from("<i", d, o + 68)[0]
            o += 72
            tex, o = _asciiz(d, o)
            mat, o = _asciiz(d, o)
            # the unused 4th vertex of a triangle is kept so the file round-trips
            faces.append(dict(verts=verts[:n], spare=verts[n:], flags=fflags, tex=tex, mat=mat, sel={}, uv2=None))
        assert d[o:o + 4] == b"TAGG", (path, o)
        o += 4
        tags = []
        while True:
            active = d[o]
            o += 1
            name, o = _asciiz(d, o)
            size = struct.unpack_from("<i", d, o)[0]
            o += 4
            raw = d[o:o + size]
            o += size
            if name == "#EndOfFile#":
                kind = "eof"
            elif name == "#UVSet#":
                kind = "uvset"
                p = 4
                for f in faces:
                    f["uv2"] = [list(struct.unpack_from("<2f", raw, p + k * 8)) for k in range(len(f["verts"]))]
                    p += 8 * len(f["verts"])
                if p != size:
                    kind = "raw"
            elif name == "#SharpEdges#":
                kind = "edges"
            elif name == "#Mass#" and size == 4 * npts:
                kind = "mass"
                for i, pt in enumerate(points):
                    pt["mass"] = struct.unpack_from("<f", raw, i * 4)[0]
            elif size == npts + nfac and name not in ("#Property#",):
                kind = "sel"
                for i, pt in enumerate(points):
                    pt["sel"][name] = raw[i]
                for i, f in enumerate(faces):
                    f["sel"][name] = raw[npts + i]
            else:
                kind = "raw"
            tags.append((active, name, kind, raw))
            if kind == "eof":
                break
        res = struct.unpack_from("<f", d, o)[0]
        o += 4
        lods.append(dict(res=res, version=(major, minor), flags=flags, points=points, normals=normals, faces=faces, tags=tags))
    assert o == len(d), f"{path}: {len(d) - o} trailing bytes"
    return dict(version=version, lods=lods)


def save(model, path):
    out = [b"MLOD", struct.pack("<2i", model["version"], len(model["lods"]))]
    for lod in model["lods"]:
        pts, faces = lod["points"], lod["faces"]
        out.append(b"P3DM" + struct.pack("<6i", *lod["version"], len(pts), len(lod["normals"]), len(faces), lod["flags"]))
        out += [struct.pack("<3fI", *p["pos"], p["flag"]) for p in pts]
        out += [struct.pack("<3f", *n) for n in lod["normals"]]
        for f in faces:
            verts = f["verts"] + f.get("spare", [[0, 0, 0.0, 0.0]] * (4 - len(f["verts"])))
            out.append(struct.pack("<i", len(f["verts"])) + b"".join(struct.pack("<iiff", *v) for v in verts))
            out.append(struct.pack("<i", f["flags"]) + f["tex"].encode("latin1") + b"\0" + f["mat"].encode("latin1") + b"\0")
        out.append(b"TAGG")
        for active, name, kind, raw in lod["tags"]:
            if kind == "sel":
                raw = bytes(p["sel"].get(name, 0) for p in pts) + bytes(f["sel"].get(name, 0) for f in faces)
            elif kind == "mass":
                raw = b"".join(struct.pack("<f", p["mass"] or 0.0) for p in pts)
            elif kind == "uvset":
                raw = raw[:4] + b"".join(struct.pack("<2f", *uv) for f in faces for uv in (f["uv2"] or [v[2:] for v in f["verts"]]))
            out.append(bytes([active]) + name.encode("latin1") + b"\0" + struct.pack("<i", len(raw)) + raw)
        out.append(struct.pack("<f", lod["res"]))
    with open(path, "wb") as fh:
        fh.write(b"".join(out))


def sharp_edges(lod):
    """#SharpEdges# as a list of [point a, point b] pairs (a live view: edit, then set_sharp_edges)."""
    for active, name, kind, raw in lod["tags"]:
        if kind == "edges":
            return [list(struct.unpack_from("<2i", raw, i * 8)) for i in range(len(raw) // 8)]
    return []


def set_sharp_edges(lod, edges):
    lod["tags"] = [(a, n, k, b"".join(struct.pack("<2i", *e) for e in edges) if k == "edges" else r) for a, n, k, r in lod["tags"]]


def add_selection(lod, name, faces):
    """Adds (or replaces) the named selection: the given face indices and every point they
    use. It goes before the first #Property# tag, where Object Builder keeps selections."""
    used = {v[0] for i in faces for v in lod["faces"][i]["verts"]}
    for i, p in enumerate(lod["points"]):
        p["sel"][name] = 1 if i in used else 0
    for i, f in enumerate(lod["faces"]):
        f["sel"][name] = 1 if i in set(faces) else 0
    tags = [t for t in lod["tags"] if t[1] != name]
    at = next((i for i, t in enumerate(tags) if t[1] == "#Property#"), len(tags) - 1)
    tags.insert(at, (1, name, "sel", b""))
    lod["tags"] = tags


def remove_points(lod, drop):
    """Removes the points in `drop` (indices) and re-indexes faces and sharp edges. Faces
    that still use a dropped point must be removed or re-pointed first."""
    drop = set(drop)
    remap, kept = {}, []
    for i, p in enumerate(lod["points"]):
        if i not in drop:
            remap[i] = len(kept)
            kept.append(p)
    for f in lod["faces"]:
        for v in f["verts"]:
            assert v[0] not in drop, "a face still uses a removed point"
            v[0] = remap[v[0]]
    set_sharp_edges(lod, [[remap[a], remap[b]] for a, b in sharp_edges(lod) if a not in drop and b not in drop])
    lod["points"] = kept


# ---------- read-only view, used by the other scripts ----------

def read(path):
    """Returns a list of LODs: dict(res, pts, faces, sels).
    pts: [(x, y, z)] in metres. faces: [(verts, texture, material)], each vert
    (point index, normal index, u, v) with u, v in 0..1. sels: {name: [face indices]}."""
    lods = []
    for lod in load(path)["lods"]:
        sels = {}
        for active, name, kind, raw in lod["tags"]:
            if kind == "sel" and not name.startswith("#"):
                sels[name] = [i for i, f in enumerate(lod["faces"]) if f["sel"].get(name)]
        lods.append(dict(
            res=lod["res"],
            pts=[tuple(p["pos"]) for p in lod["points"]],
            faces=[([tuple(v) for v in f["verts"]], f["tex"], f["mat"]) for f in lod["faces"]],
            sels=sels,
        ))
    return lods


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("models", nargs="+", help="MLOD .p3d files (wildcards are expanded)")
    parser.add_argument("--faces", action="store_true", help="list every face of the first LOD: UVs in texture pixels and positions in mm")
    parser.add_argument("--size", type=int, default=1024, help="texture size for the pixel UVs (default 1024)")
    parser.add_argument("--roundtrip", action="store_true", help="only check that load() and save() reproduce each file exactly")
    parser.add_argument("--rename", nargs=2, metavar=("OLD", "NEW"), help="replace OLD with NEW in every texture and material path (all LODs) and save the model in place")
    args = parser.parse_args()
    paths = [p for pat in args.models for p in (sorted(glob.glob(pat, recursive=True)) or [pat])]

    if args.rename:
        old, new = args.rename
        for path in paths:
            model = load(path)
            n = 0
            for lod in model["lods"]:
                for f in lod["faces"]:
                    for key in ("tex", "mat"):
                        if old.lower() in f[key].lower():
                            i = f[key].lower().index(old.lower())
                            f[key] = f[key][:i] + new + f[key][i + len(old):]
                            n += 1
            save(model, path)
            print(f"{path}: {n} paths renamed")
        return

    if args.roundtrip:
        import os
        import tempfile
        bad = 0
        tmp = os.path.join(tempfile.mkdtemp(prefix="mlod_"), "out.p3d")
        for path in paths:
            save(load(path), tmp)
            same = open(tmp, "rb").read() == open(path, "rb").read()
            bad += not same
            print(f"{'ok  ' if same else 'DIFF'} {path}")
        print(f"{len(paths) - bad}/{len(paths)} identical")
        raise SystemExit(1 if bad else 0)

    for path in paths:
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
