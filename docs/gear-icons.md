# Gear Icons

[Back to the documentation overview](README.md) · [Adding a Brand](adding-a-brand.md)

Every cigarette brand has six inventory icons in `addons/<brand>/data/UI/`. They are rendered from the brand's own `data/texture.paa` by [`tools/gear_icons/gear_icons.py`](../tools/gear_icons/gear_icons.py), so all brands look the same and the icons always match the in-game models.

| File | Size | Shows |
| --- | --- | --- |
| `gear_cigpack_x_ca.paa` | 512 × 512 | the pack in 3/4 view: front, right side, top flap |
| `gear_cig0_x_ca.paa` | 128 × 128 | fresh cigarette, unlit |
| `gear_cig1_x_ca.paa` … `gear_cig4_x_ca.paa` | 128 × 128 | lit, burning down to the stub |

## Rendering a brand's icons

You need Python 3 with Pillow (`pip install pillow`) and `hemtt` on your `PATH`. Run from the repository root.

1. Preview first. This writes PNGs and a `preview.png` sheet, and does not touch the addon:
   ```powershell
   python tools/gear_icons/gear_icons.py <brand> --out .hemttout/icons/<brand>
   ```
2. Open `preview.png`. It shows every icon on a dark and a light background, plus at the 64 px size the inventory actually uses. Check the points in [What to check](#what-to-check).
3. When it looks right, write the PAAs into `addons/<brand>/data/UI/`:
   ```powershell
   python tools/gear_icons/gear_icons.py <brand> --out .hemttout/icons/<brand> --apply
   ```
4. Check them in-game (`hemtt launch` opens `test.VR`).

A brand without a `data/cigpack.p3d` (for example `savage`) only gets the five cigarette icons.

The same folder has helper scripts: overview sheets, cigarette strip and logo finder, texture fixes, a pack renderer for non-brand packs, and readers for the `.p3d` models. See [tools/gear_icons/README.md](../tools/gear_icons/README.md).

## The pack icon

- **Faces:** the front, the right side and the top flap, cut from the texture at the pack's UVs. Every brand's `cigpack.p3d` uses the same UV layout:

  | Face | Texture pixels (u0, v0, u1, v1) |
  | --- | --- |
  | front | 512, 451, 873, 1015 |
  | right side | 873, 451, 1024, 1015 |
  | top flap | 512, 300, 873, 451 |
  | back | 0, 300, 361, 864 (not in the icon) |

- **View:** 3/4 from the front right and slightly above. The front is 430 px tall in the 512 px icon. The side is drawn at 70 % brightness and the top at 85 %, so the pack reads as a box.
- **Background:** transparent, no shadow.

If a brand's texture has faces that are upside down on the model, fix the texture first. The icon shows the texture exactly as the model maps it.

## The cigarette icons

- **Layout:** 45°, rising to the right, with the filter end at the same spot (118, 11) in every stage. Each stage burns down from the bottom-left end.
- **Lengths:** taken from the base models `addons/base/data/cig0.p3d` … `cig4.p3d`: 83.9, 83.8, 69.1, 55.4 and 42.6 mm, with a 30.5 mm filter and a 7.6 mm diameter. At 1.78 px per mm the fresh cigarette spans about 150 px of the diagonal.
- **Filterless brands** (`eckstein`, `craven`, `lucky_strike`) use `cig_nofilter0.p3d` … `cig_nofilter4.p3d`: 56, 56, 44, 32 and 20 mm of paper, no filter. The script spots them from the `NOFILTER` models in their `cigs_glasses.hpp`, draws them at the same scale and puts the mouth end at the same spot.
- **Texture:** the cigarette strip at the top of the texture, which every brand shares with the base models:

  | Part | Texture pixels |
  | --- | --- |
  | paper | u 10–389 (u 389 meets the filter) |
  | filter | u 391–585 (often starts with a white band up to u 432) |
  | charred paper edge | u 0–10 |
  | ash | u 836–994, v 70–96 |

- **No stretching:** the paper is wrapped at the strip's own scale, 6.57 px per mm. The side view shows half the circumference (π × d / 2 ≈ 78 px of the strip) folded onto the diameter. The fold is half arcsine and half flat, so a logo looks round without its top and bottom collapsing.
- **Logo placement:** the wrap is centred on whatever is printed next to the filter: on the paper's end or on the filter's white band. The script finds it and prints `logo at v …`. A shorter stage keeps the paper next to the filter and loses paper from the burnt end, so the logo stays put until the stub burns into it. The models do the same; [`cig_models.py`](../tools/gear_icons/cig_models.py) holds them to it.
- **Lit stages:** grey ash tip, the strip's charred edge behind it, and an orange ember glow where ash meets paper.
- **Shading:** cylindrical, lit from above, with a faint dark rim so the icon reads on light backgrounds too.

## What to check

- **Logo cut off:** the script warns when the printed logo is taller than the 78 px visible side, for example vertical text like `космос` or `BAJA BLAST`. Part of it wraps round the back, as on the real model. To show a different part, pass `--logo-v <v>` with the v pixel to centre on.
- **Wrong spot found:** if `logo at v …` doesn't match where the logo is on the strip, pass `--logo-v`. Stripes, seam lines and the strip's edges are ignored automatically, but an unusual layout can still fool it.
- **Pack:** the front, side and top should read the right way up and match what you see in-game.
- **Small size:** at 64 px the pack's brand name should still be readable. The cigarette stages should be told apart by length and the lit tip.

## Changing the style

All the numbers above are constants at the top of `tools/gear_icons/gear_icons.py`. If you change the style, re-render every brand so they stay consistent.
