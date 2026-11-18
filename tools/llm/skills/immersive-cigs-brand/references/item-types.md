# Item types

Which addon to copy, what it brings, and how its icons are made. Look at the copied addon's files before you change them; this page only lists what differs between the types.

| Kind | Copy | Models | Texture(s) the brand brings | Icons |
| --- | --- | --- | --- | --- |
| Cigarette with filter | `voron` | `base/data/cig0..4.p3d`, own `data/cigpack.p3d` | `data/texture.paa` | `gear_icons.py` |
| Cigarette without filter | `eckstein` | `base/data/cig_nofilter0..4.p3d`, own `data/cigpack.p3d` | `data/texture.paa` | `gear_icons.py` (detects filterless) |
| Cigar | `papa_schultz` | `base/data/cigar0..4.p3d`, own `data/cigarbox_5/cigarbox_5.p3d` | `data/cigars/cigar_co.paa`, `data/cigarbox_5/cigarbox_5_co.paa` (+ `_nohq`) | `cigar_icons.py`, see below |
| Suckable (lollipop) | `pops` | own `data/pop/pop.p3d`, own `data/poppack/poppack.p3d` | the textures those models use | no script, see below |
| Variety pack (one of several items at random) | `crayons` | own models | own textures | `render_pack.py` for the pack |

## Cigarette with filter (`voron`)

The usual case. `voron` uses the shared materials from `addons/base`, so it has no `.rvmat` of its own. Avoid copying `morley`: it brings its own `texture.rvmat` with a path to `morley`.

- `cigs_glasses.hpp` / `cigs_hmd.hpp`: `QPATH_BASE_MODEL_CIG0` ... `CIG4`, `hiddenSelectionsTextures[] = { QPATH_TEXTURE, QPATH_TEXTURE }`.
- Smoke colour: `PVAR(smokeColor)[] = { r, g, b };` on `cig0` in both files, as in `baja_blast` (default `{0.2, 0.2, 0.2}`). `PVAR(smokeMultiplier)` for more smoke.
- Flavour text after lighting up: `PVAR(flavor)[] = { "..." };` (optional).

## Cigarette without filter (`eckstein`)

Same texture layout. The models are paper only: 56 mm fresh, burning down to 20 mm. The filter part of the texture (u 391-585) isn't shown; the mouth end shows the tobacco end (u 722-788). Print the logo on the paper's end next to where the filter would be (u 330-389), as for a filtered cigarette. A cork tip goes onto the paper's last 11 mm (u 317-389), see Craven in `tools/gear_icons/README.md`.

## Cigar (`papa_schultz`)

Cigars have their own skill: follow `immersive-cigs-cigar` (`tools/llm/skills/immersive-cigs-cigar/SKILL.md`) instead of this one. In short: the cigar models are shared, the brand brings a cigar texture (`texture_compose.py cigar`) and its own box, and `cigar_icons.py` renders the icons from the models.

## Suckable (`pops`)

- No burning: `PVAR(isSuckable) = 1`, `PVAR(totalSucks) = SUCKS_TOTAL`, `PVAR(sounds)[]` for the suck sounds, `PVAR(flavor)[]`.
- Its own models and textures in `data/pop/` and `data/poppack/`. Rename the model paths with `mlod.py --rename` and fix the paths in every copied `.rvmat`.
- Icons have no script. A pack that uses the cigarette pack's UVs (check with `mlod.py --faces`) can use `render_pack.py`; the pop pack doesn't.

## Variety pack (`crayons`)

`PVAR(item_glasses)[]` and `PVAR(item_hmd)[]` can be arrays. Taking one out picks a random entry (`CBA_fnc_getCfgDataRandom`), so one pack can hold several colours or flavours. `crayons/defines.hpp` shows the macros that build both lists. Each list is picked from on its own, and the unit gets the facewear or the NVG item depending on which slot is free, so list the same items in both.

```powershell
python tools/gear_icons/render_pack.py addons/<brand>/data/<pack>/<pack>.paa .hemttout/icons/<brand>/gear_<pack>_ca.png --paa addons/<brand>/data/UI/gear_<pack>_ca.paa
```

## Checking a model with its texture

```powershell
python tools/gear_icons/mlod.py addons/<brand>/data/<model>.p3d --faces
python tools/gear_icons/render_model.py addons/base/data/cigar0.p3d addons/base/data/cigar4.p3d --texture addons/<brand>/data/cigars/cigar_co.paa --out .hemttout/llm/<brand>_models.png
```

`render_model.py` is flat-shaded: good to see which part of the texture lands where, not how it looks in game.
