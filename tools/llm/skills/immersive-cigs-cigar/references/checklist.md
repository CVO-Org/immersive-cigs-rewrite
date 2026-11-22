# Checklist

Go through every point before telling the user the cigar brand is done. Say which ones you couldn't check.

## Files

- [ ] `addons/<brand>/$PBOPREFIX$` is `zrn\cigs\addons\<brand>`.
- [ ] `grep -ri papa addons/<brand>` finds nothing in the text files.
- [ ] `mlod.py addons/<brand>/data/cigarbox_5/cigarbox_5.p3d`: every texture and material path points at `addons\<brand>\` or `addons\base\`.
- [ ] `data/cigarbox_5/cigarbox_5.rvmat` points at `addons\<brand>\`.
- [ ] `data/cigars/cigar_co.paa` and `data/cigarbox_5/cigarbox_5_co.paa` are the new textures, with their PNGs next to them.
- [ ] `data/UI/` has `gear_cigarbox_5_x_ca.paa` and `gear_cigar0..4_x_ca.paa`, all new, and no PNG left from Papa Schultz.
- [ ] No preview or scratch file in `addons/<brand>/`.
- [ ] Root `license.md` lists the folder, if the user chose a licence.
- [ ] `docs/classnames.md` lists `cigs_<brand>_cigarbox_5` (alphabetical), containing cigars.

## Config

- [ ] `config.cpp`: `authors[]` has the user; `requiredAddons[]` has `cigs_base` and `cigs_cigars`; `units[]` is `QGVAR(cigarbox_5Item)`, `weapons[]` is `WEAPONS_ARRAY_CIGARS`.
- [ ] Box: `scope = 2`, `count` matches the description, `PVAR(item_glasses) = QGVAR(cigar0)`, `PVAR(item_hmd) = QGVAR(cigar0_nv)`.
- [ ] Both `cigar_glasses.hpp` and `cigar_hmd.hpp`: every stage has `QPATH_BASE_MODEL_CIGARn` and `gear_cigarn_x_ca.paa`; `hiddenSelectionsTextures[]` uses `QPATH_TEXTURE_CIGAR` twice; only stage 0 is `scope = 2`.
- [ ] `stringtable.xml`: every key is `STR_cigs_<brand>_*` with an `<English>` text, and each `CSTRING(x)` in the configs has its key.
- [ ] ACE Arsenal Extended: `aceax.hpp` (copied from `papa_schultz`, uses `COMPONENT`) is included at the end of `config.cpp`, and the brand is in `values[]` and has a value class in `addons/cigars/aceax.hpp`, with `label = ""`, `image` pointing at its `data\ui\aceax_logo_ca.paa` and `description = ECSTRING(<brand>,cigar)`. Write the logo, the box front, with `python tools/gear_icons/aceax_logos.py --only <brand> --apply` once the brand is in `values[]`.

## Build

- [ ] `hemtt check` passes without new errors or warnings.

## Looks (from the previews; the user checks in game)

- [ ] Cigar icons: the band print faces you and stays on all five stages; the foot is tobacco on `cigar0` and glows on `cigar1`-`cigar4`.
- [ ] Box icon: the front reads the right way round, the brand is readable at 64 px.
- [ ] Tell the user what to look at in game (`hemtt launch`): the box on the ground and in the inventory, taking a cigar out, lighting it, all five stages, the smoke.
