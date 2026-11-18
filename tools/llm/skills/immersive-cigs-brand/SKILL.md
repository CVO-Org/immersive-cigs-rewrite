---
name: immersive-cigs-brand
description: Adds a new smokable or suckable brand to the Immersive Cigs - Rewrite Arma 3 mod - a cigarette pack (with or without filter), a cigar box or a lollipop-style pack. Covers copying the right template addon, renaming, config and stringtable, building the 1024 px texture from artwork with texture_compose.py, fixing the pack model's texture paths with mlod.py, rendering the gear icons with gear_icons.py, and checking the result with hemtt. Use when someone asks to make, add or retexture a cigarette, cigar, pop or crayon brand for Immersive Cigs.
---

# Adding a brand to Immersive Cigs

You are working in the Immersive Cigs - Rewrite repository (HEMTT project, prefix `zrn\cigs`, addons in `addons/`). A brand is one addon folder: a pack (a `CfgMagazines` magazine whose ammo count is the number of cigarettes), the pack lying on the ground (`CfgVehicles`), and the smokable twice per burn stage: as facewear (`CfgGlasses`) and as NVG item (`CfgWeapons`).

Read these before you start. They are the source of truth; this skill only tells you the order and the traps:
- `docs/adding-a-brand.md` - the human guide for this repository
- `docs/modders.md` - every `cigs_*` config property
- `docs/gear-icons.md` - the texture layout and the icon recipe
- `tools/gear_icons/README.md` - every helper script with examples
- `references/item-types.md` (next to this file) - which addon to copy for which kind of item
- `references/texture.md` - the UV layout and how to turn artwork into `texture.paa`
- `references/checklist.md` - what to check before you call it done

## 0. Ask first

Settle these with the user before touching files. Don't invent them:
1. **Where it goes.** This repository (a PR to Immersive Cigs) or the user's own mod? For their own mod, the [extension template](https://github.com/OverlordZorn/immersion-cigs-extension-template) is the start; its guide replaces steps 1-3 below. The texture and icon steps (4-6) still apply: run the scripts in a clone of this repository, with the brand's folder copied into `addons/` for the time being.
2. **Kind of item:** cigarette with filter, cigarette without filter, or a suckable (lollipop, crayon). See `references/item-types.md`. For a cigar, switch to the `immersive-cigs-cigar` skill (`tools/llm/skills/immersive-cigs-cigar/SKILL.md`).
3. **Names:** the addon folder name (`snake_case`, ASCII, becomes the classname `cigs_<brand>_cigpack`), the display name in English, and the author credit.
4. **Numbers:** cigarettes per pack (`count`), puffs per cigarette (`TOTALPUFFS`, 17), optionally a smoke colour.
5. **Artwork:** what the user has. Pictures for the pack faces and a small logo for the cigarette paper are ideal. If they have none, you can't paint them: ask for them, or build a plain placeholder pack with `--pack-colour` and say that it is one.
6. **Rights:** the artwork must be the user's own or free to use. Real brand names and logos are the user's call, not yours; point it out once if it is a real trademark, then go on.

## 1. Copy the template addon

Copy the folder named in `references/item-types.md` to `addons/<brand>/`, without `data/UI/*.paa` and `data/texture.paa` of the old brand (you make new ones). Don't copy the shared cigarette or cigar models: they live in `addons/base/data/` and take the brand's texture through `hiddenSelectionsTextures[]`.

## 2. Rename

Replace the old brand everywhere inside the new folder, and nowhere else:
- `$PBOPREFIX$`: `zrn\cigs\addons\<brand>`
- `script_component.hpp`: `COMPONENT` and `COMPONENT_BEAUTIFIED`
- `stringtable.xml`: `<Project name="cigs_<brand>">` and every key `STR_cigs_<old>_*` -> `STR_cigs_<brand>_*`, then the texts. Keep every language the template has; translate them yourself or, if you are not sure, copy the English text and tell the user which ones need a translator.
- `config.cpp`: `authors[]`, and `requiredAddons[]` if the item type needs more
- `cigpack.hpp`: `count` and the pack description's number
- `defines.hpp`: `TOTALPUFFS` / `SUCKS_TOTAL`
- `license.md`: keep or replace with the user's licence, then add the folder to the matching list in the root `license.md`

Then search the new folder for the old name (`grep -ri <old> addons/<brand>`). The only hits left should be none.

Classnames come from the macros (`GVAR(cigpack)` -> `cigs_<brand>_cigpack`). Don't write classnames by hand, and keep the macros the template uses (`QPATHTOF`, `CSTRING`, `ECSTRING`, `PVAR`, `QPATH_*`). The `QPATH_*` macros are in `addons/main/script_macros_cigs.hpp`.

## 3. Fix the model paths

A pack model has its texture path baked in. After copying, it still points at the old brand:

```powershell
python tools/gear_icons/mlod.py addons/<brand>/data/cigpack.p3d --rename addons\<old>\ addons\<brand>\
python tools/gear_icons/mlod.py addons/<brand>/data/cigpack.p3d
```

The second command prints the paths; both `texture` and `material` must point at `<brand>` or at `addons\base\`. Do the same for every `.p3d` you copied (cigar box: `data/cigarbox_5/cigarbox_5.p3d`). An `.rvmat` you copied is plain text: fix its paths with the Edit tool.

## 4. Make the texture

Cigarette brands: one 1024 x 1024 `data/texture.paa` covers the pack and the cigarettes. Build it with `tools/gear_icons/texture_compose.py`; `references/texture.md` has the layout, the face sizes and the orientation rules.

```powershell
python tools/gear_icons/texture_compose.py guide --over-base --out .hemttout/llm/guide.png
python tools/gear_icons/texture_compose.py compose --front <png> --back <png> --top <png> --left <png> --right <png> --bottom <png> --paper-logo <png> --paper-logo-rotate -90 --filter "#rrggbb" --out .hemttout/llm/<brand>/texture.png --paa addons/<brand>/data/texture.paa
```

Draw the paper logo upright, with text and mark stacked, and let `--paper-logo-rotate -90` turn its top towards the filter: the logo reads from the front of the cigarette, like on the other brands (`references/texture.md`). For a filterless cigarette, also pass `--paper-logo-u 300`, so the logo sits a bit away from the mouth end. Look at the PNG it writes (read the image) before you go on. Cigars and suckables have their own textures; see `references/item-types.md`.

## 5. Render the gear icons

```powershell
python tools/gear_icons/gear_icons.py <brand> --out .hemttout/icons/<brand> --logo-v 127
```

Read `.hemttout/icons/<brand>/preview.png` and check it against "What to check" in `docs/gear-icons.md`. When it is right, run the same command with `--apply`, which writes the six PAAs into `addons/<brand>/data/UI/`. Pass `--logo-v 127` when the logo came from `texture_compose.py`; otherwise let the script find it and check the `logo at v ...` line it prints.

`gear_icons.py` only does cigarette brands. Cigars have `cigar_icons.py` (see the cigar skill); for suckables, see `references/item-types.md`.

## 6. Check it

```powershell
hemtt check
```

Fix every error and warning in your addon. Then go through `references/checklist.md`, add the pack to `docs/classnames.md`, and tell the user to try it in game: `hemtt launch` opens the test mission. You can't test in game yourself; say so instead of claiming it works.

## Rules

- Write previews and scratch files under `.hemttout/` (gitignored), never into `addons/`.
- PAA files are only written by the scripts (`--paa`, `--apply`), which call `hemtt utils paa convert`. Don't commit the PNGs you made on the way unless the user wants the sources in the repo (the cigar addons keep a `_co.png` next to the PAA).
- `texture_fix.py` edits a committed PAA in place. Running it twice applies the fix twice. Use `--dry-run` and `--input` to chain fixes on a PNG and convert once.
- Text files use CRLF, 4 spaces, UTF-8 (`.editorconfig`). Edit files with backslashes (paths, macros) with the Edit/Write tools, not with `sed` or `echo`.
- New user-facing text goes into `stringtable.xml`, never into the config directly.
- Don't change anything in `addons/base/`, `addons/core/` or `addons/main/` for a new brand. If a brand seems to need it, stop and ask.
- A PR to this repository follows `CONTRIBUTING.md`: title `Brand - New: Add <Brand> cigarettes`, label `pr/new`.
