# Classnames

[Back to the documentation overview](README.md)

## Packs

| Classname | Name | Contains | Notes |
| --------- | ---- | -------- | ----- |
| `cigs_alborz_cigpack` | Pack of Alborz | cigarettes | |
| `cigs_almyra_cigpack` | Pack of Almyra | cigarettes | Altis |
| `cigs_apollo_cigpack` | Apollo Soyuz Cigarette Pack | cigarettes | |
| `cigs_baja_blast_cigpack` | Mtn Dew Baja Blast Cigs Pack | cigarettes | tinted smoke |
| `cigs_black_devil_cigpack` | Black Devil Pink Cigs Pack | cigarettes | |
| `cigs_camel_cigpack` | Pack of Camel | cigarettes | international, modern western filler |
| `cigs_casa_sport_cigpack` | Pack of Casa Sports | cigarettes (without filter) | Western Sahara |
| `cigs_cigars_cigarbox_5` | Box of Cigars | cigars | |
| `cigs_craven_cigpack` | Craven "A" Cigarette Pack | cigarettes | WW2 |
| `cigs_crayons_crayonpack` | Pack of Crayons | crayons (suckable) | |
| `cigs_eckstein_cigpack` | Eckstein No. 5 Cigarette Pack | cigarettes | WW2 |
| `cigs_ernte_23_cigpack` | Pack of Ernte 23 | cigarettes | West Germany, 1970s-80s (GM) |
| `cigs_f6_cigpack` | Pack of f6 | cigarettes | East Germany (GDR), Global Mobilization era |
| `cigs_gudok_cigpack` | Pack of Gudok | cigarettes (without filter) | Chernarus, 1980s, cheap domestic |
| `cigs_hwarang_cigpack` | Pack of Hwarang | cigarettes (without filter) | South Korean army issue, Vietnam War era |
| `cigs_jaffudi_cigpack` | Pack of Jaffudi | cigarettes | Takistan, kingdom era (1960s-80s), royal brand |
| `cigs_juno_cigpack` | Pack of Juno | cigarettes (without filter) | WW2 |
| `cigs_kosmos_cigpack` | Kosmos Cigarette Pack | cigarettes | |
| `cigs_lipa_cigpack` | Pack of Lipa | cigarettes | filterless, Livonia |
| `cigs_lipa_dzwonek_cigpack` | Pack of Lipa Dzwonek | cigarettes | filterless, Livonia, blue "Bluebells" edition |
| `cigs_lucky_strike_cigpack` | Lucky Strike Cigarette Pack | cigarettes | WW2 |
| `cigs_marlboro_cigpack` | Pack of Marlboro | cigarettes | international, modern |
| `cigs_matelot_cigpack` | Pack of Matelot | cigarettes (without filter) | Tanoa |
| `cigs_morley_cigpack` | Morley Cigarette Pack | cigarettes | |
| `cigs_nil_cigpack` | NIL Cigarette Pack | cigarettes | |
| `cigs_pops_poppack` | Lollipop (Packed) | lollipop (suckable) | |
| `cigs_popularne_cigpack` | Pack of Popularne | cigarettes (without filter) | Cold War Poland |
| `cigs_prince_cigpack` | Pack of Prince | cigarettes | Denmark, Global Mobilization |
| `cigs_ruby_queen_cigpack` | Pack of Ruby Queen | cigarettes (without filter) | Vietnam War era, Saigon |
| `cigs_shanhai_cigpack` | Shanhai Cigarette Pack | cigarettes | |
| `cigs_sosna_cigpack` | Pack of Sosna | cigarettes | menthol, Chernarus (Green Mountain), late-Soviet |
| `cigs_sparta_cigpack` | Pack of Sparta | cigarettes | Czechoslovakia, 1980s |
| `cigs_troupes_cigpack` | Pack of Troupes | cigarettes (without filter) | WW2, French army issue |
| `cigs_voron_cigpack` | Voron Cigarette Pack | cigarettes | |
| `cigs_zamok_cigpack` | Pack of Zamok | cigarettes | Chernarus, 1980s, premium domestic filter |
| `cigs_zargabad_cigpack` | Pack of Zargabad | cigarettes | Takistan, kingdom era (1960s-80s), everyday bazaar brand |
| `cigs_savage_cigpack` | Savage Cigarette Pack | cigarettes | S.O.G. Prairie Fire only |
| `vn_b_item_cigs_01` | Savage Cigarette Pack | cigarettes | S.O.G. Prairie Fire's own pack, made usable |

## Lighters

| Classname | Name | Notes |
| --------- | ---- | ----- |
| `cigs_matches` | Matches | 10 uses |
| `cigs_matches_hunting` | Hunting Matches | 6 uses, burn in wind and water |
| `cigs_lighter` | Lighter | 100 uses, refillable |
| `cigs_lighter_cheap` | Disposable Lighter | 15 uses |
| `cigs_lighter_cricket` | Cricket Lighter | 25 uses |
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
