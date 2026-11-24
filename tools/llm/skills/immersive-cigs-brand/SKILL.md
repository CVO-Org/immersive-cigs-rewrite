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

Keep the copied `data/model.cfg` next to the pack model. It gives the model its own CfgModels entry; without it the model falls back to the engine's global default, which other mods can break. CI (`tools/check_model_cfg.py`) fails a brand without it.

## 2. Rename

Replace the old brand everywhere inside the new folder, and nowhere else:
- `$PBOPREFIX$`: `zrn\cigs\addons\<brand>`
- `script_component.hpp`: `COMPONENT` and `COMPONENT_BEAUTIFIED`
- `stringtable.xml`: `<Project name="cigs_<brand>">` and every key `STR_cigs_<old>_*` -> `STR_cigs_<brand>_*`, then the texts. Keep every language the template has; translate them yourself or, if you are not sure, copy the English text and tell the user which ones need a translator.
- `config.cpp`: `authors[]`, and `requiredAddons[]` if the item type needs more
- `cigpack.hpp`: `count` and the pack description's number
- `defines.hpp`: `TOTALPUFFS` / `SUCKS_TOTAL`
- `license.md`: keep or replace with the user's licence, then add the folder to the matching list in the root `license.md`. An invented brand keeps the template's CC BY 4.0 `license.md` and goes under "Creative Commons Attribution 4.0". A real brand (a real product's name and pack) gets no `license.md` and goes under "The following Folders are under no license".
- `aceax.hpp` and `compat_aceax/config.cpp`: nothing to rename, they use `COMPONENT` and the macros. Keep both; `config.cpp` doesn't include `aceax.hpp`, the sub-config does. The brand's value in the shared model comes in step 5.
- Keep `scope = 1` on `cig0` (`cigs_glasses.hpp`) and `cig0_nv` (`cigs_hmd.hpp`); the compat sub-config shows them with ACE Arsenal Extended. The pack stays `scope = 2`.
- Optional: `PVAR(flavor)[] = { "...", ... };` on `cig0` in both `cigs_glasses.hpp` and `cigs_hmd.hpp`, the line shown after lighting up. Most brands have four.

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

### ACE Arsenal Extended

The stage 0 cigarette (`cig0` and `cig0_nv`) is `scope = 1`: without ACE Arsenal Extended (AAE) it's hidden from the arsenal and the Eden lists, and players take cigarettes out of the pack. With AAE every cigarette brand shows up as one button of the shared cigarette model. That takes three things; a brand without them is missing from the AAE selector, and its cigarette is hidden there too:
1. The compat sub-config `compat_aceax/config.cpp` and `aceax.hpp` in the brand folder (both copied in step 1). The sub-config has its own `CfgPatches` (`cigs_<brand>_compat_aceax`) that requires `aceax_gearinfo` with `skipWhenMissingDependencies = 1`, so it only loads with AAE. It sets `cig0` and `cig0_nv` back to `scope = 2` and includes `..\aceax.hpp`, which maps all five stages, facewear and NVG item, to the model. `config.cpp` doesn't include `aceax.hpp`. HEMTT packs the sub-config into the brand's PBO.
2. The brand in the shared model `addons/base/aceax.hpp`: its name in `values[]` (alphabetical) and a value class next to the others, also alphabetical:
   ```cpp
   class <brand> { label = ""; image = QPATHTOEF(<brand>,data\ui\aceax_logo_ca.paa); description = ECSTRING(<brand>,cigarette); };
   ```
   This is the one edit in `addons/base/` a new brand makes. Use the Edit tool (backslashes).
3. The logo, the flat pack front for the button. Once the brand is in `values[]`, write it:
   ```powershell
   python tools/gear_icons/aceax_logos.py --only <brand> --out .hemttout/aceax
   python tools/gear_icons/aceax_logos.py --only <brand> --out .hemttout/aceax --apply
   ```
   Read `.hemttout/aceax/preview.png` after the first command; `--apply` writes `addons/<brand>/data/UI/aceax_logo_ca.paa`.

Without AAE the sub-config is dropped, so the brand needs no dependency on it.

## 6. Check it

```powershell
hemtt check
```

Fix every error and warning in your addon. `hemtt check` also bumps the build number in `addons/main/script_version.hpp` (and may touch `README.md` / `mod.cpp`): don't commit those, `git checkout` them. Then go through `references/checklist.md`, add the pack to `docs/classnames.md`, and tell the user to try it in game: `hemtt launch` opens the test mission, `hemtt launch aceax` adds ACE Arsenal Extended for the brand button. You can't test in game yourself; say so instead of claiming it works.

## 7. AI faction presets

The AI Cigs presets give factions their brands: `addons/ai_presets_factions/vanilla` and one `addons/ai_presets_factions/<cdlc>` per CDLC (`docs/modders.md` explains the classes). Ask the user whether the new brand belongs to a faction there. If it does, that's its own PR after the brand is merged, not part of the brand PR. Don't add a preset for a faction from a mod the repository has no preset addon for (CUP, RHS and the like); say so instead.

## 8. The PR

One PR per brand, so each gets its own changelog line. Title `Brand - New: <Brand> cigarettes (<region>)`, label `pr/new`, body as in `CONTRIBUTING.md`. Every brand adds to the same `values[]` line in `addons/base/aceax.hpp`, so two brand PRs open at once conflict there. When you build several brands, branch each from the previous one (stacked) and say in the PRs that they merge in order, or rebase the later ones after each merge.

## Rules

- Write previews and scratch files under `.hemttout/` (gitignored), never into `addons/`.
- PAA files are only written by the scripts (`--paa`, `--apply`), which call `hemtt utils paa convert`. Don't commit the PNGs you made on the way unless the user wants the sources in the repo (the cigar addons keep a `_co.png` next to the PAA).
- `texture_fix.py` edits a committed PAA in place. Running it twice applies the fix twice. Use `--dry-run` and `--input` to chain fixes on a PNG and convert once.
- Text files use CRLF, 4 spaces, UTF-8 (`.editorconfig`). Edit files with backslashes (paths, macros) with the Edit/Write tools, not with `sed` or `echo`.
- New user-facing text goes into `stringtable.xml`, never into the config directly.
- Don't change anything in `addons/base/`, `addons/core/` or `addons/main/` for a new brand, except the brand's value in `addons/base/aceax.hpp` (step 5). If a brand seems to need more, stop and ask.
- A PR to this repository follows `CONTRIBUTING.md` (step 8).
