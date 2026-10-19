# Classnames

[Back to the documentation overview](README.md)

## Packs

| Classname | Name | Contains | Notes |
| --------- | ---- | -------- | ----- |
| `cigs_apollo_cigpack` | Apollo Soyuz Cigarette Pack | cigarettes | |
| `cigs_baja_blast_cigpack` | Mtn Dew Baja Blast Cigs Pack | cigarettes | tinted smoke |
| `cigs_black_devil_cigpack` | Black Devil Pink Cigs Pack | cigarettes | |
| `cigs_cigars_cigarbox_5` | Box of Cigars | cigars | |
| `cigs_craven_cigpack` | Craven "A" Cigarette Pack | cigarettes | WW2 |
| `cigs_crayons_crayonpack` | Pack of Crayons | crayons (suckable) | |
| `cigs_eckstein_cigpack` | Eckstein No. 5 Cigarette Pack | cigarettes | WW2 |
| `cigs_kosmos_cigpack` | Kosmos Cigarette Pack | cigarettes | |
| `cigs_lucky_strike_cigpack` | Lucky Strike Cigarette Pack | cigarettes | WW2 |
| `cigs_morley_cigpack` | Morley Cigarette Pack | cigarettes | |
| `cigs_nil_cigpack` | NIL Cigarette Pack | cigarettes | |
| `cigs_pops_poppack` | Lollipop (Packed) | lollipop (suckable) | |
| `cigs_voron_cigpack` | Voron Cigarette Pack | cigarettes | |
| `cigs_savage_cigpack` | Savage Cigarette Pack | cigarettes | S.O.G. Prairie Fire only |
| `vn_b_item_cigs_01` | Savage Cigarette Pack | cigarettes | S.O.G. Prairie Fire's own pack, made usable |

## Lighters

| Classname | Name | Notes |
| --------- | ---- | ----- |
| `cigs_matches` | Matches | |
| `cigs_lighter` | Lighter | |
| `vn_b_item_lighter_01` | *(S.O.G. name)* | S.O.G. Prairie Fire's own lighter, made usable. Keeps its vanilla ability to set things on fire. |

## Cigarettes, cigars, lollipops and crayons

You rarely need these: they're what ends up in the facewear (`CfgGlasses`) or NVG slot (`CfgWeapons`) when you take one from a pack. Each burn stage is its own class.

| Pattern | Example |
| ------- | ------- |
| `cigs_<brand>_cig0` … `_cig4` / `_cig0_nv` … `_cig4_nv` | `cigs_morley_cig0`, `cigs_morley_cig0_nv` |
| `cigs_cigars_cigar0` … `_cigar4` / `_nv` | `cigs_cigars_cigar0` |
| `cigs_crayons_crayon_<color>` / `_nv` | `cigs_crayons_crayon_black` |

## Legacy classnames

The rewrite renamed the classnames of the original mod. The old ones still exist but are deprecated: they don't show up in arsenals or lists anymore. See [Server Admins](server-admins.md#legacy-classnames) for how to update loadouts.

| New classname | Previous classname |
| ------------- | ------------------ |
| `cigs_lighter` | `murshun_cigs_lighter` |
| `cigs_matches` | `murshun_cigs_matches` |
| `cigs_morley_cigpack` | `murshun_cigs_cigpack` |
| `cigs_morley_cig0` | `murshun_cigs_cig0` |
| `cigs_morley_cig0_nv` | `murshun_cigs_cig0_nv` |
| `cigs_cigars_cigar0` | `immersion_cigs_cigar0` |
| `cigs_cigars_cigar0_nv` | `immersion_cigs_cigar0_nv` |
| `cigs_pops_poppack` | `immersion_pops_poppack` |

The same applies to the other stages (`_cig1` … `_cig4`, `_cigar1` … `_cigar4`, each with `_nv`).
