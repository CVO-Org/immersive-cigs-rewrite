# Checklist

Go through every point before telling the user the brand is done. Say which ones you couldn't check.

## Files

- [ ] `addons/<brand>/$PBOPREFIX$` is `zrn\cigs\addons\<brand>`.
- [ ] `grep -ri <old brand> addons/<brand>` finds nothing (binary `.p3d` included: run `mlod.py` on each model and read the paths).
- [ ] Every model's `texture` and `material` paths point at `addons\<brand>\` or `addons\base\`.
- [ ] Every copied `.rvmat` points at `addons\<brand>\` or `addons\base\`.
- [ ] `data/texture.paa` (or the item type's textures) is new, 1024 x 1024.
- [ ] `data/UI/` has an icon for every `picture =` in the configs, and no leftovers of the old brand.
- [ ] No PNG, PSD or preview left in `addons/<brand>/` that the user didn't ask for.
- [ ] Root `license.md` lists the folder under its licence.
- [ ] `docs/classnames.md` lists `cigs_<brand>_cigpack` (alphabetical), with what it contains.
- [ ] `data/UI/aceax_logo_ca.paa` exists (`aceax_logos.py --apply`), and you looked at its preview.
- [ ] The only file changed outside `addons/<brand>/` besides `license.md` and `docs/classnames.md` is `addons/base/aceax.hpp`. `addons/main/script_version.hpp`, `README.md` and `mod.cpp`, which `hemtt check` touches, are not in the commit.

## Config

- [ ] `config.cpp`: `authors[]` has the user; `requiredAddons[]` has `cigs_base` (and `cigs_cigars` for cigars); `units[]` and `weapons[]` use the template's macros.
- [ ] Pack: `scope = 2`, `count` matches the description, `PVAR(item_glasses)` / `PVAR(item_hmd)` name this brand's stage 0 classes.
- [ ] Every stage has its model and `picture`; stage 0 (`cig0`, `cig0_nv`) is `scope = 1`, the rest `_DEBUG_SCOPE_`.
- [ ] `stringtable.xml`: every key is `STR_cigs_<brand>_*`, every key has `<English>`, and each `CSTRING(x)` in the configs has a key `STR_cigs_<brand>_x`.
- [ ] ACE Arsenal Extended: `compat_aceax/config.cpp` (copied with the brand) sets `cig0` / `cig0_nv` to `scope = 2` and includes `..\aceax.hpp`; `config.cpp` doesn't include `aceax.hpp`. The brand is in `values[]` and has a value class in `addons/base/aceax.hpp` (`addons/cigars/aceax.hpp` for cigars). A cigarette brand's value class has `label = ""`, `image` pointing at its `data\ui\aceax_logo_ca.paa` (made by `tools/gear_icons/aceax_logos.py`) and `description = ECSTRING(<brand>,cigarette)`.

## Build

- [ ] `hemtt check` passes without new errors or warnings.
- [ ] `python tools/gear_icons/mlod.py addons/<brand>/data/*.p3d` reads every model.

## Looks (from the previews; the user checks in game)

- [ ] Pack icon: front, side and top flap the right way up, brand readable at 64 px.
- [ ] Cigarette icons: the logo sits next to the filter and survives into `cig3`; the stages differ by length and the lit tip.
- [ ] Paper logo: its top points towards the filter (mouth end without a filter), not towards the lit end; text and mark are stacked along the cigarette. Without a filter, it sits a bit away from the mouth end (u 273-327).
- [ ] Texture: no face upside down or mirrored compared with `guide.png`.
- [ ] AAE logo: the pack front, upright, readable as a small square button.
- [ ] Tell the user what to look at in game (`hemtt launch`): the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke, the flavour line, and the brand button in ACE Arsenal Extended (`hemtt launch aceax`).

## Afterwards

- [ ] Asked the user whether the brand goes into an AI faction preset (`addons/presets_*`), as its own PR.
