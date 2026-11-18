---
name: immersive-cigs-cigar
description: Adds a new cigar brand to the Immersive Cigs - Rewrite Arma 3 mod - a box of cigars with its own wrapper, band and box artwork. Covers copying the papa_schultz addon, renaming, fixing the box model's paths with mlod.py, building the cigar texture with texture_compose.py cigar, retexturing the box from its UV layout, rendering the cigar and box icons with cigar_icons.py, and checking the result with hemtt. Use when someone asks to make, add or retexture a cigar or cigar box for Immersive Cigs.
---

# Adding a cigar brand to Immersive Cigs

You are working in the Immersive Cigs - Rewrite repository (HEMTT project, prefix `zrn\cigs`, addons in `addons/`). A cigar brand is one addon folder with:
- a box of cigars: a `CfgMagazines` magazine (`cigarbox_5`, its ammo count is the number of cigars) and the box lying on the ground (`CfgVehicles`), with its own model `data/cigarbox_5/cigarbox_5.p3d`;
- the cigar twice per burn stage (`cigar0` ... `cigar4`): as facewear (`CfgGlasses`) and as NVG item (`CfgWeapons`). The cigar models are shared (`addons/base/data/cigar0..4.p3d`); the brand only brings their texture, `data/cigars/cigar_co.paa`.

Read these before you start:
- `docs/modders.md` - every `cigs_*` config property
- `tools/gear_icons/README.md` - the helper scripts, "Cigars" in particular
- `references/cigar-layout.md` (next to this file) - the cigar and box textures, and how to build them
- `references/checklist.md` - what to check before you call it done
- `addons/papa_schultz/` - the addon you copy; read all its files once

## 0. Ask first

Settle these with the user. Don't invent them:
1. **Where it goes.** This repository (a PR to Immersive Cigs) or the user's own mod? For their own mod, the [extension template](https://github.com/OverlordZorn/immersion-cigs-extension-template) is the start: it is set up for cigarettes, so copy the cigar files in from `papa_schultz` and keep its `cigs_cigars` dependency. Run the scripts in a clone of this repository, with the brand's folder copied into `addons/` for the time being.
2. **Names:** the addon folder name (`snake_case`, ASCII, becomes `cigs_<brand>_cigarbox_5`), the display names in English (the cigar, the box, the box's description), and the author credit.
3. **Numbers:** cigars per box (`count`, 5 in the templates; keep the class name `cigarbox_5` unless the user wants another, then rename it everywhere), puffs per cigar (`TOTALPUFFS`, 135), smoke amount (`PVAR(smokeMultiplier)`, 1.5).
4. **Artwork:** the wrapper colour or a wrapper picture, the band colour, a print for the band (a medallion, a logo), and pictures for the box: front, back, sides. If they have none, ask; a placeholder is fine if they say so, and you call it one.
5. **Rights:** the artwork must be the user's own or free to use. Real brand names are the user's call; point it out once, then go on.

## 1. Copy and rename

Copy `addons/papa_schultz/` to `addons/<brand>/`. Then replace `papa_schultz` everywhere inside the new folder and nowhere else:
- `$PBOPREFIX$`: `zrn\cigs\addons\<brand>`
- `script_component.hpp`: `COMPONENT` and `COMPONENT_BEAUTIFIED`
- `stringtable.xml`: `<Project name="cigs_<brand>">`, every key `STR_cigs_papa_schultz_*` -> `STR_cigs_<brand>_*`, then the texts in every language the file has. Translate them or copy the English text and tell the user which need a translator.
- `config.cpp`: `authors[]`. Keep `"cigs_cigars"` in `requiredAddons[]`.
- `cigarpack.hpp`: `count` and the description's number
- `defines.hpp`: `TOTALPUFFS`
- `data/cigarbox_5/cigarbox_5.rvmat`: the `_nohq` path, with the Edit tool
- add a `license.md` if the user wants one, and the folder to the matching list in the root `license.md`

Then `grep -ri papa addons/<brand>` must find nothing but binary files, which step 2 fixes.

Classnames come from the macros (`GVAR(cigar0)` -> `cigs_<brand>_cigar0`). Keep the macros `papa_schultz` uses (`QPATH_BASE_MODEL_CIGAR0..4`, `QPATH_TEXTURE_CIGAR`, `QPATH_BASE_RVMAT_CIGAR`, `CSTRING`, `PVAR`). Don't copy cigar models; they stay in `addons/base`.

## 2. Fix the box model's paths

```powershell
python tools/gear_icons/mlod.py addons/<brand>/data/cigarbox_5/cigarbox_5.p3d --rename addons\papa_schultz\ addons\<brand>\
python tools/gear_icons/mlod.py addons/<brand>/data/cigarbox_5/cigarbox_5.p3d
```

The second command prints two groups: the box (`<brand>\data\cigarbox_5\cigarbox_5_co.paa` with `<brand>\...\cigarbox_5.rvmat`) and the cigars inside it (`<brand>\data\cigars\cigar_co.paa` with `base\data\cigar.rvmat`). Nothing may point at `papa_schultz` any more.

## 3. Make the cigar texture

```powershell
python tools/gear_icons/cigar_icons.py layout papa_schultz --out .hemttout/llm/<brand>
python tools/gear_icons/texture_compose.py cigar --wrapper "#rrggbb" --band "#rrggbb" --band-print <png> --out .hemttout/llm/<brand>/cigar_co.png --paa addons/<brand>/data/cigars/cigar_co.paa
```

Read `cigar_layout.png` first: it shows which part of the texture is the wrapper, the head, the foot, the ash and the ember. `texture_compose.py cigar` starts from Papa Schultz' texture with its band removed, so the foot, the ash and the ember stay right. Read the PNG it writes before you go on. Details and limits: `references/cigar-layout.md`.

Keep the PNG next to the PAA (`data/cigars/cigar_co.png`), as the other cigar addons do, so the next person can edit it.

## 4. Make the box texture

There is no builder for the box: its model is detailed (an open lid, the cigars inside, edges). Start from `addons/<brand>/data/cigarbox_5/Cigarbox_5_co.png` (the copy from Papa Schultz), read `box_layout.png` from step 3 to see which area is which face, and paste the user's pictures over those areas with Pillow, keeping the layout. Convert it:

```powershell
Remove-Item addons/<brand>/data/cigarbox_5/cigarbox_5_co.paa
hemtt utils paa convert addons/<brand>/data/cigarbox_5/Cigarbox_5_co.png addons/<brand>/data/cigarbox_5/cigarbox_5_co.paa
```

## 5. Render the icons

```powershell
python tools/gear_icons/cigar_icons.py all <brand> --out .hemttout/icons/<brand>
```

Read `.hemttout/icons/<brand>/preview.png`: the box in 3/4 view, and the cigar at five stages with its band print facing you and the ember glowing at the foot. If the cigar shows the wrong side, pass `--logo-v <v>` with the v pixel (of 1024) of the print on the cigar texture. When it is right, run the same command with `--apply`, which writes the six PAAs into `addons/<brand>/data/UI/`. The `gear_cigarbox_5_x_ca.png` there is a leftover of Papa Schultz; replace it with the new PNG or delete it.

## 6. Check it

```powershell
hemtt check
```

Fix every error and warning in your addon. Go through `references/checklist.md`, add the box to `docs/classnames.md`, and tell the user to try it in game (`hemtt launch`). You can't test in game yourself; say so.

## Rules

- Write previews and scratch files under `.hemttout/` (gitignored), never into `addons/`.
- PAAs are written by the scripts (`--paa`, `--apply`) or `hemtt utils paa convert`, which won't overwrite: delete the old PAA first.
- Text files use CRLF, 4 spaces, UTF-8. Edit files with backslashes (paths, macros) with the Edit/Write tools, not with `sed` or `echo`.
- New user-facing text goes into `stringtable.xml`.
- Don't change `addons/base/`, `addons/core/`, `addons/main/` or `addons/cigars/` for a new brand. If it seems necessary, stop and ask.
- A PR to this repository follows `CONTRIBUTING.md`: title `Brand - New: Add <Brand> cigars`, label `pr/new`.
