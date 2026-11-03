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
| [`texture_fix.py`](texture_fix.py) | Turns a texture region by 180°, moves a logo along the cigarette paper, or copies a box elsewhere. |
| [`mlod.py`](mlod.py) | Reads and writes MLOD models, byte for byte. Summarises them, lists faces, renames texture paths. Other scripts import it. |
| [`cig_uvmap.py`](cig_uvmap.py) | Shows which part of the strip a cigarette model maps along its length. |
| [`cig_models.py`](cig_models.py) | Fixes the base cigarette models' paper mapping and builds the filterless models from them. |
| [`render_model.py`](render_model.py) | Renders models with a texture, to check UVs without Object Builder. |

## Render a brand's icons

```powershell
python tools/gear_icons/gear_icons.py kosmos --out .hemttout/icons/kosmos
```

Open `.hemttout/icons/kosmos/preview.png`. When it looks right, run it again with `--apply` to write the PAAs into `addons/kosmos/data/UI/`. If the logo on the cigarette is off-centre, find the right v with `strips.py` and pass `--logo-v <v>`.

Used so far: `baja_blast --logo-v 91` (centres on "BLAST") and `kosmos --logo-v 112` (the start of "КОСМОС").

A brand whose `cigs_glasses.hpp` uses the `QPATH_BASE_MODEL_NOFILTER_*` models is rendered as a filterless cigarette (56, 56, 44, 32, 20 mm) automatically.

## Compare brands

```powershell
python tools/gear_icons/icon_sheet.py overview apollo baja_blast kosmos voron --out .hemttout/icons/overview.png
python tools/gear_icons/icon_sheet.py files "addons/cigars/data/UI/*.paa" --out .hemttout/icons/cigars.png
```

`overview` reads the PNGs that `gear_icons.py` wrote to `.hemttout/icons/<brand>/`, so render those brands first. `files` takes the committed PAAs as they are.

## Look at the cigarette strips

```powershell
python tools/gear_icons/strips.py kosmos baja_blast savage --out .hemttout/icons/strips.png
python tools/gear_icons/strips.py .hemttout/icons/_edit/craven_texture_orig.png craven --out .hemttout/icons/craven.png
```

The sheet shows the top 280 px of each texture with a v ruler. The paper is u 10–389, and the filter starts at u 391. The script prints the paper logo's box, which you can use for `--logo-v` (its v centre) or for `texture_fix.py move-logo --box`. Logos printed on the filter's white band (u 391–432) aren't reported.

## Fix a texture

```powershell
python tools/gear_icons/texture_fix.py rotate morley --dry-run
python tools/gear_icons/texture_fix.py rotate morley
python tools/gear_icons/texture_fix.py move-logo savage --box 268 88 341 162 --dx 48
python tools/gear_icons/texture_fix.py move-logo craven --box 325 92 385 161 --dx -72 --dry-run
python tools/gear_icons/texture_fix.py copy craven --box 391 41 463 217 --to 317 41 --input .hemttout/icons/_edit/craven_texture.png
```

- `rotate` turns the pack's top flap by default. Pass `--box u0 v0 u1 v1` for another region; the face boxes are in docs/gear-icons.md.
- `move-logo` moves the print inside `--box` by `--dx` px along the strip (positive is towards the filter) and covers the old spot with paper from 120 px further left (`--paper-from`).
- `copy` copies `--box` to `--to u v`.
- `--dry-run` only writes the PNG to `.hemttout/icons/_edit/`. The original is kept there as `<addon>_texture_orig.png`.
- `--input <png>` starts from such a PNG instead of the PAA. Chain several fixes this way, so the PAA is compressed only once.
- Re-render the icons afterwards.

These edit the committed PAA in place. Running one twice applies it twice, so the commands above are a record of what was done; don't run them again on those brands:
- Morley and base: the top flap was upside down.
- Savage: the badge moved next to the filter.
- Craven: on the filterless model, the cork tip moved from the unused filter part (u 391–463) onto the paper's last 11 mm (u 317–389), with "Craven A" moved in front of it.

## Render a pack that isn't a cigarette brand

```powershell
python tools/gear_icons/render_pack.py addons/crayons/data/crayonpack/crayonpack.paa .hemttout/icons/crayons/gear_crayonpack_ca.png --paa addons/crayons/data/UI/gear_crayonpack_ca.paa
```

This only works if the model uses the same UVs as `cigpack.p3d`. Check that with `mlod.py --faces`. The cigar boxes are different models, so it doesn't work for them.

## Inspect a model

```powershell
python tools/gear_icons/mlod.py addons/base/data/cigpack.p3d --faces
python tools/gear_icons/cig_uvmap.py addons/base/data/cig0.p3d addons/base/data/cig1.p3d addons/base/data/cig_nofilter4.p3d
python tools/gear_icons/render_model.py addons/base/data/cig0.p3d addons/base/data/cig4.p3d addons/base/data/cig_nofilter4.p3d --texture addons/kosmos/data/texture.paa --out .hemttout/icons/models.png
python tools/gear_icons/mlod.py --roundtrip "addons/**/*.p3d"
```

- `mlod.py` summarises the first LOD: extents in mm, texture/material groups with their UV range in pixels, and named selections. `--faces` lists every face with UVs in pixels and positions in mm.
- `cig_uvmap.py` lists each side section of a cigarette as "mm from the burnt end → u pixel". That tells you which part of the strip, and so which logo, each stage shows in-game.
- `render_model.py` draws the models side by side at one scale, mouth end on the right, with the texture applied. It's a flat-shaded check of the UVs, not how the game lights them.
- `--roundtrip` checks that `mlod.py` writes every model back byte for byte. Run it after changing `mlod.py`.

## Edit a model

`mlod.py` can write models: `load()` keeps everything, and `save()` writes it back. Points and faces carry their own selection weights, so adding or removing them keeps every named selection, `#SharpEdges#` and `#UVSet#` in step.

```powershell
python tools/gear_icons/mlod.py addons/mybrand/data/cigpack.p3d --rename addons\morley\ addons\mybrand\
python tools/gear_icons/cig_models.py fix-base
python tools/gear_icons/cig_models.py nofilter
```

- `--rename` replaces part of every texture and material path, which is the Object Builder step when adding a brand.
- `cig_models.py fix-base`: in the base `cig1`..`cig4`, the paper now keeps its filter end and the logo printed there, and runs back at the strip's true 6.57 px/mm. A 1 mm ring at the burnt end shows the charred edge (u 3–10). It skips models it has already fixed.
  - Before (until November 2026), these stages kept the strip's burnt-end side (u 3 → 322 / 228 / 135 / 47) and cut the logo off after `cig0`.
- `cig_models.py nofilter` writes `cig_nofilter0..4.p3d` from the fixed `cig0..4`. The filter is removed, and the paper is closed at the mouth with the tobacco end cap (u 722–788), where the filter's end was. The stages are 56, 56, 44, 32 and 20 mm, and the shadow LOD is shortened to match. `Camo`/`CamoB`, the lit tip and the sharp edges stay as in the base models.
  - These replaced the old per-brand models of `eckstein`, `craven` and `lucky_strike`. Those were 56 mm with no selections and a texture per stage, and Eckstein's `cig3` was the same length as its `cig2`.
- `cig_models.py cigars` makes `addons/base/data/cigar0..4.p3d` retexturable. It adds `Camo` on the body and `CamoB` on the lit tip (the existing `Tip` selection), clears the texture baked into the faces, and uses the shared `cigar.rvmat` / `cigar_lit.rvmat`. Running it again gives the same result.
  - `cigars` and `papa_schultz` used to carry identical copies of these models with their own texture baked in. They now use the base models and bring only `data/cigars/cigar_co.paa`, through `QPATH_TEXTURE_CIGAR`.
  - The cigar box stays per addon, like `cigpack.p3d`, because a pack item can't be retextured from config. Its cigars use the base `cigar.rvmat`.

Open a model you changed in Object Builder, or look at it in-game, before you release it.

To use `mlod.py` from another script:

```python
import sys; sys.path.insert(0, "tools/gear_icons")
from mlod import load, read, save
lod = read("addons/base/data/cig0.p3d")[0]   # dict(res, pts, faces, sels)
model = load("addons/base/data/cig0.p3d")     # everything, editable; save(model, path)
```
