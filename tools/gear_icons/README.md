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
| [`aceax_logos.py`](aceax_logos.py) | Cuts each cigarette brand's flat pack front out of its `texture.paa` as `aceax_logo_ca.paa`, the picture on its ACE Arsenal Extended brand button. |
| [`render_pack.py`](render_pack.py) | Renders the 3/4 pack icon from any texture with the cigarette pack's UV layout, such as the crayon pack. |
| [`icon_sheet.py`](icon_sheet.py) | Puts icons side by side: an overview of brands, or any set of PAA/PNG icons. |
| [`strips.py`](strips.py) | Shows the cigarette strips of several textures on one sheet and prints where each paper logo sits. |
| [`texture_fix.py`](texture_fix.py) | Turns a texture region by 180°, moves a logo along the cigarette paper, or copies a box elsewhere. |
| [`texture_compose.py`](texture_compose.py) | Draws the texture's UV layout, and builds a brand's texture from one picture per pack face and a paper logo, or a cigar's texture from a wrapper colour, a band and its print. |
| [`cigar_icons.py`](cigar_icons.py) | Renders a cigar brand's box and cigar0..4 icons from the models, and draws the cigar and box UV layouts. Needs numpy. |
| [`mlod.py`](mlod.py) | Reads and writes MLOD models, byte for byte. Summarises them, lists faces, renames texture paths. Other scripts import it. |
| [`cig_uvmap.py`](cig_uvmap.py) | Shows which part of the strip a cigarette model maps along its length. |
| [`cig_models.py`](cig_models.py) | Fixes the base cigarette models' paper mapping and builds the filterless models from them. |
| [`render_model.py`](render_model.py) | Renders models with a texture, to check UVs without Object Builder. |

## Render a brand's icons

```powershell
python tools/gear_icons/gear_icons.py kosmos --out .hemttout/icons/kosmos
```

Open `.hemttout/icons/kosmos/preview.png`. When it looks right, run it again with `--apply` to write the PAAs into `addons/kosmos/data/UI/`. If the logo on the cigarette is off-centre, find the right v with `strips.py` and pass `--logo-v <v>`.

Used so far: `baja_blast --logo-v 144` (centres on "BLAST") and `kosmos --logo-v 112` (the start of "КОСМОС").

A brand whose `cigs_glasses.hpp` uses the `QPATH_BASE_MODEL_NOFILTER_*` models is rendered as a filterless cigarette (56, 56, 44, 32, 20 mm) automatically.

## Build a texture from pictures

```powershell
python tools/gear_icons/texture_compose.py guide --over-base --out .hemttout/icons/guide.png
python tools/gear_icons/texture_compose.py compose --front front.png --back back.png --top top.png --left left.png --right right.png --bottom bottom.png --paper-logo logo.png --filter "#b01818" --out .hemttout/icons/mybrand/texture.png --paa addons/mybrand/data/texture.paa
```

- `guide` draws every pack face and the cigarette strip with its size and which way is up. `--over-base` draws it over the clean base texture instead of grey.
- `compose` starts from `addons/base/data/texture.paa` with every print removed, so the paper grain, the cork, the tobacco end and the ash stay. It scales each picture to fill its face and crops the edges, so give it the face's aspect ratio. A face you leave out stays plain card (`--pack-colour` sets its colour).
- Draw every face upright, pack top at the top. The top flap has the back edge at the top. The bottom is turned by 180° for you. A side picture wider than tall is turned to run along the side.
- `--paper-logo` is fitted into 54 x 72 px on the paper next to the filter, centred on v 127. Draw the logo upright and pass `--paper-logo-rotate -90`, so its top points towards the filter like on the other brands. For a filterless cigarette, add `--paper-logo-u 300` to move it a bit away from the mouth end. Render the icons with `--logo-v 127` afterwards: a tinted paper (`--paper`) can fool `gear_icons.py`'s logo detection.
- `--filter` takes a `#rrggbb` tint for the cork, `white`, or a picture for u 391-591.

## Cigars

```powershell
python tools/gear_icons/cigar_icons.py layout papa_schultz --out .hemttout/icons/papa_schultz
python tools/gear_icons/texture_compose.py cigar --wrapper "#8a5a32" --band "#7a1010" --band-print medallion.png --out .hemttout/icons/mybrand/cigar_co.png --paa addons/mybrand/data/cigars/cigar_co.paa
python tools/gear_icons/cigar_icons.py all mybrand --out .hemttout/icons/mybrand
python tools/gear_icons/cigar_icons.py all mybrand --out .hemttout/icons/mybrand --apply
```

- `layout` draws the UVs over the brand's `cigar_co.paa` (wrapper, head, foot, ash, ember) and `cigarbox_5_co.paa` (the box's faces by the way they face) into `cigar_layout.png` and `box_layout.png`.
- The wrapper runs along u from the foot (u 3) to the mouth (u 1019), about 10 px per mm, and round v 602-1023. The last stage only shows u 599-1019, so keep the band at u 645 or higher.
- `texture_compose.py cigar` starts from Papa Schultz' `cigar_co.png` with its band and medallion removed. `--wrapper` tints the wrapper and the head (or takes a picture), `--band` paints a band at `--band-u` (default 765), `--band-print` puts a picture of up to 130 x 130 on it at `--print-v` (default 820).
- `cigar_icons.py` renders with a small z-buffered rasteriser: smooth shading, lit from the top left, the lit tip glowing. `stages` writes `gear_cigar0..4_x_ca` (256 px): the base cigar models at 45°, mouth end top right, the ember leaning towards you, and turned so the band's print faces you (`--logo-v` picks another spot). `box` writes `gear_cigarbox_5_x_ca` (512 px) from the brand's own box model in 3/4 view, with the textures its faces name. `--apply` writes the PAAs into `data/UI/`.

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

This only works if the model uses the same UVs as `cigpack.p3d`. Check that with `mlod.py --faces`. The cigar boxes are different models; use `cigar_icons.py box` for them.

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
