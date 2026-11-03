# Gear icon tools

Scripts for rendering the inventory icons and for checking the models and textures behind them. The full recipe for the icons is in [docs/gear-icons.md](../../docs/gear-icons.md).

## Setup

- Python 3 with Pillow: `pip install pillow`
- `hemtt` on your `PATH` (it converts between PAA and PNG)
- Run every script from the repository root. Write previews and scratch files under `.hemttout/`, which is gitignored.
- The models must be unbinarized (MLOD, as saved by Object Builder). All the `.p3d` files in this repo are.

Every script has `--help`.

## The scripts

| Script | What it does |
| --- | --- |
| [`gear_icons.py`](gear_icons.py) | Renders a cigarette brand's pack icon and cig0..4 icons from its `texture.paa`. |
| [`render_pack.py`](render_pack.py) | Renders the 3/4 pack icon from any texture with the cigarette pack's UV layout, such as the crayon pack. |
| [`icon_sheet.py`](icon_sheet.py) | Puts icons side by side: an overview of brands, or any set of PAA/PNG icons. |
| [`strips.py`](strips.py) | Shows the cigarette strips of several textures on one sheet and prints where each paper logo sits. |
| [`texture_fix.py`](texture_fix.py) | Turns a texture region by 180° or moves a logo along the cigarette paper. |
| [`mlod.py`](mlod.py) | Reads MLOD models: points, faces, UVs, textures, materials and selections. Other scripts import it. |
| [`cig_uvmap.py`](cig_uvmap.py) | Shows which part of the strip a cigarette model maps along its length. |

## Render a brand's icons

```powershell
python tools/gear_icons/gear_icons.py kosmos --out .hemttout/icons/kosmos
```

Open `.hemttout/icons/kosmos/preview.png`. When it looks right, run it again with `--apply` to write the PAAs into `addons/kosmos/data/UI/`. If the logo on the cigarette is off-centre, find the right v with `strips.py` and pass `--logo-v <v>`.

Used so far: `baja_blast --logo-v 91` (centres on "BLAST") and `kosmos --logo-v 112` (the start of "КОСМОС").

## Compare brands

```powershell
python tools/gear_icons/icon_sheet.py overview apollo baja_blast kosmos voron --out .hemttout/icons/overview.png
python tools/gear_icons/icon_sheet.py files "addons/cigars/data/UI/*.paa" --out .hemttout/icons/cigars.png
```

`overview` reads the PNGs that `gear_icons.py` wrote to `.hemttout/icons/<brand>/`, so render those brands first. `files` takes the committed PAAs as they are.

## Look at the cigarette strips

```powershell
python tools/gear_icons/strips.py kosmos baja_blast savage --out .hemttout/icons/strips.png
python tools/gear_icons/strips.py addons/eckstein/data/cigs/cig0.paa addons/eckstein/data/cigs/cig4.paa --out .hemttout/icons/eckstein.png
```

The sheet shows the top 280 px of each texture with a v ruler. The paper is u 10–389, and the filter starts at u 391. The script prints the paper logo's box, which you can use for `--logo-v` (its v centre) or for `texture_fix.py move-logo --box`. Logos printed on the filter's white band (u 391–432) aren't reported.

## Fix a texture

```powershell
python tools/gear_icons/texture_fix.py rotate morley --dry-run
python tools/gear_icons/texture_fix.py rotate morley
python tools/gear_icons/texture_fix.py move-logo savage --box 268 88 341 162 --dx 48
```

- `rotate` turns the pack's top flap by default. Pass `--box u0 v0 u1 v1` for another region; the face boxes are in docs/gear-icons.md.
- `move-logo` moves the print inside `--box` by `--dx` px along the strip (positive is towards the filter) and covers the old spot with paper from 120 px further left (`--paper-from`).
- `--dry-run` only writes the PNG to `.hemttout/icons/_edit/`. The original is kept there as `<addon>_texture_orig.png`.
- Re-render the icons afterwards.

These edit the committed PAA in place. Running one twice applies it twice, so the commands above are a record of what was done (Morley and base top flap, Savage logo); don't run them again on those brands.

## Render a pack that isn't a cigarette brand

```powershell
python tools/gear_icons/render_pack.py addons/crayons/data/crayonpack/crayonpack.paa .hemttout/icons/crayons/gear_crayonpack_ca.png --paa addons/crayons/data/UI/gear_crayonpack_ca.paa
```

This only works if the model uses the same UVs as `cigpack.p3d`. Check that with `mlod.py --faces`. The cigar boxes are different models, so it doesn't work for them.

## Inspect a model

```powershell
python tools/gear_icons/mlod.py addons/base/data/cigpack.p3d --faces
python tools/gear_icons/cig_uvmap.py addons/base/data/cig0.p3d addons/base/data/cig1.p3d addons/eckstein/data/cigs/cig1.p3d
```

- `mlod.py` summarises the first LOD: extents in mm, texture/material groups with their UV range in pixels, and named selections. `--faces` lists every face with UVs in pixels and positions in mm.
- `cig_uvmap.py` lists each side section of a cigarette as "mm from the burnt end → u pixel". That tells you which part of the strip, and so which logo, each stage shows in-game.

What it found (November 2026):

- The base `cig1`..`cig4` keep the burnt-end side of the strip (u 3 → 322 / 228 / 135 / 47 at the filter) and cut off the filter side, so the paper logo only shows on the unlit `cig0`.
- `eckstein`, `craven` and `lucky_strike` use an older model in `data/cigs/`: 56 mm, no filter section, no `Camo`/`CamoB` selections, and a separate texture per stage that moves the logo to stay visible. Eckstein's `cig3` is the same length as its `cig2`.

To use `mlod.py` from another script:

```python
import sys; sys.path.insert(0, "tools/gear_icons")
from mlod import read
lod = read("addons/base/data/cig0.p3d")[0]   # dict(res, pts, faces, sels)
```
