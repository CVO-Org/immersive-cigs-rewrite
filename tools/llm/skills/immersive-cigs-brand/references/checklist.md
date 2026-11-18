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

## Config

- [ ] `config.cpp`: `authors[]` has the user; `requiredAddons[]` has `cigs_base` (and `cigs_cigars` for cigars); `units[]` and `weapons[]` use the template's macros.
- [ ] Pack: `scope = 2`, `count` matches the description, `PVAR(item_glasses)` / `PVAR(item_hmd)` name this brand's stage 0 classes.
- [ ] Every stage has its model and `picture`; only stage 0 is `scope = 2`, the rest `_DEBUG_SCOPE_`.
- [ ] `stringtable.xml`: every key is `STR_cigs_<brand>_*`, every key has `<English>`, and each `CSTRING(x)` in the configs has a key `STR_cigs_<brand>_x`.

## Build

- [ ] `hemtt check` passes without new errors or warnings.
- [ ] `python tools/gear_icons/mlod.py addons/<brand>/data/*.p3d` reads every model.

## Looks (from the previews; the user checks in game)

- [ ] Pack icon: front, side and top flap the right way up, brand readable at 64 px.
- [ ] Cigarette icons: the logo sits next to the filter and survives into `cig3`; the stages differ by length and the lit tip.
- [ ] Paper logo: its top points towards the filter (mouth end without a filter), not towards the lit end; text and mark are stacked along the cigarette. Without a filter, it sits a bit away from the mouth end (u 273-327).
- [ ] Texture: no face upside down or mirrored compared with `guide.png`.
- [ ] Tell the user what to look at in game (`hemtt launch`): the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke.
