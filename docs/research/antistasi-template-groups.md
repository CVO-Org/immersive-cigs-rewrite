# Antistasi compat: template groups (research)

Research only. Nothing here is implemented, committed or filed as an issue.

Source: [official-antistasi-community/A3-Antistasi](https://github.com/official-antistasi-community/A3-Antistasi), branch `unstable`, commit `8af8cf8` (2026-10-15). Template list from `A3A/addons/core/Templates/Templates.hpp`.

## How Antistasi spawns units

- AI units are generic classes, dressed with `setUnitLoadout`: `a3a_unit_west` (Occupants), `a3a_unit_east` (Invaders), `a3a_unit_reb_*` (Rebels), `a3a_unit_civ` (Civilians). The sides are fixed: Occupants west, Invaders east, Rebels independent.
- `a3a_unit_west` / `_east` inherit from `B_G_Soldier_F` / `O_G_Soldier_F`, so their faction is FIA (`BLU_G_F` / `OPF_G_F`). Without compat, Antistasi units get the FIA faction preset or class presets inherited from the vanilla FIA classes.
- Factions are "templates": config classes under `configFile >> "A3A" >> "Templates" >> <name>`, with inheritance (`Vanilla_CSAT_Temperate : Vanilla_CSAT_Arid`).
- The loaded templates are in `A3A_Occ_template`, `A3A_Inv_template`, `A3A_Reb_template`, `A3A_Civ_template` (classnames, **server only**, set in `fn_initVarServer.sqf`).
- `fn_createUnit.sqf` sets `unitType` on every unit (public): `loadouts_<occ|inv|reb|civ>_<tier>_<role>`, e.g. `loadouts_occ_military_Rifleman`. Tiers: `militia`, `military`, `SF`, `police`, `other`. `unitType` can also be a loadout array, so check the type.

## Proposed hook

- In `fn_getConfigPresets.sqf`: when `unitType` is a string starting with `loadouts_`, read the side prefix, look up `A3A_<prefix>_template`, and read `cigs_packs[]` / `cigs_lighters[]` from that template class. This **replaces both** the class and faction lookups for Antistasi units (both give FIA). Cached per template.
- Tier: try `cigs_packs_<tier>[]` first, then `cigs_packs[]`.
- No template preset → empty map → terrain presets → default presets.
- Same rank as the faction presets, switched by *Use Unit and Faction Presets*. `getCigItems` stays unchanged.
- Data in a new `presets_a3a` addon (`requiredAddons` the A3A core patch, `skipWhenMissingDependencies = 1`), adding `cigs_packs*[]` to the template classes. Each touched class must be redeclared with its real parent from `Templates.hpp`. Extender mods can put `cigs_packs[]` in their own templates.
- To confirm in game: the CfgPatches name of A3A core (probably `A3A_core`), that `unitType` is set before the queue processes the unit, garrison spawns.

## Counts

240 classes in `Templates.hpp`, of which about 30 are mod-family bases. **210 templates**, 206 visible (scope 2), 4 hidden (the SPE set, scope 0).

| Side | Visible |
| --- | --- |
| Occupants | 90 |
| Invaders | 64 |
| Rebels | 28 |
| Civilians | 24 |

## Groups

One brand list per group and tier, shared through a macro. Occupant or Invader does not matter: the preset is keyed by template. Era decides first.

### Modern (2000s to 2035)

| Group | Templates |
| --- | --- |
| US forces | Vanilla NATO (Arid, Tropical, Temperate, Apex), WS NATO, RHS US Army / USMC (4), CUP US Army / USMC (4), Aegis US (3), 3CB Marines Temperate |
| UK | Vanilla NATO/UK (3), 3CB BAF (4), CUP BAF (2), Aegis BAF (3) |
| Germany | CUP BW (2), BWA3 BW (2) |
| Other NATO / Europe | AMF France, TMT Turkey, CRO Croatia, CUP ACR (2), SFP SDF Sweden (4), EF MJTF (2) |
| Russia | RHS AFRF (2), RHS VDV (2), CUP AFRF (4), Aegis Russia, 3CB CSAT BEAR |
| CSAT / Iran / China (Arma lore) | Vanilla CSAT (4), WS CSAT, Aegis Iran, Aegis China, 3CB CSAT VIPER / SCIMITAR / GRYPHON |
| Serbia / Balkans | RHS SAF (maybe CRO) |
| Chernarus and neighbours | 3CB GAF (Grozovia, not the German army), RHS CDF, CUP CDF (2), RHS ChDKZ, RHS NAPA, CUP NAPA, CSLA NAPA, 3CB CCM; civs 3CB Cherno, CUP CH, RHS Civ |
| Livonia | Vanilla LDF, Aegis LDF, 3CB LDF, Vanilla LFF, 3CB LSM; civs Vanilla Livonian |
| Altis / Mediterranean | Vanilla AAF, Aegis AAF, 3CB AAF (2), 3CB MDF (Malden), Vanilla FIA, Aegis FIA, 3CB FIA; civs Vanilla Altian, 3CB Mediterranean |
| Tanoa / South Pacific | RHS HIDF, 3CB HIDF, RHS TLA, Vanilla SDK, Aegis SDK, RHS SDK, 3CB TFIA; civs Vanilla Tanoan, 3CB South Pacific |
| Takistan / Middle East | CUP TKA, 3CB TKA East / West / Mix, 3CB ANA, 3CB KRG, CUP TKM, 3CB TKM; civs CUP TKC, 3CB Takistan, 3CB Middle Eastern |
| Sahrani | CUP RACS (2), PRACS RACS (2), CUP SLA, PRACS SLA (2), PRACS SLA Guards (2) |
| Western Sahara / Africa | WS SFIA, WS ADF, WS Tura, WS Civ, 3CB ADA, 3CB African Desert |
| ION (PMC) | Vanilla ION, WS ION, CUP ION (2), 3CB ION (3), 3CB ION rebels |

### Cold War (1970s to 1980s)

| Group | Templates |
| --- | --- |
| NATO | GM BW (3), 3CB CW US, CWR US, CWR BAF, CSLA US Army (2) |
| Warsaw Pact | GM NVA (3), 3CB CW USSR, CWR USSR, CSLA CSLA (2), CSLA AFMC |
| Insurgents / civs | GM FIA, CWR FIA, CSLA FIA; civs GM, CWR CHC, CSLA CIV_TC |
| Tropical | 3CB TLA, 3CB TNM, 3CB PLM |

### Vietnam

| Group | Templates |
| --- | --- |
| US and allies | VN USMC, VN MACV, VN ANZAC, Unsung US |
| North Vietnam | VN PAVN, VN POF, Unsung PAVN, Unsung VC; civs VN Cam Lao Nam, Unsung |

### WW2 and 1930s

WW2 pack looks (Craven "A", Eckstein, Juno, Lucky Strike, Troupes) only go here, see `docs/classnames.md`.

| Group | Templates |
| --- | --- |
| Wehrmacht | IFA WEH, SPE WEH (hidden), SPE_IFA WEH, SPEX WEH, SPEX WEH DAK, SEP WEH Central (2) |
| US Army | IFA US, IFA USMC, SPE US (hidden), SPE_IFA US, SPEX US, SEP US Winter |
| Commonwealth / UK | IFA UK, IFA ALLIES, SPEX Commonwealth, SPEX CW NAC |
| Soviet | IFA SOV |
| French resistance | IFA FFI, SPE FFF (hidden), SPE_IFA FFF, SPEX FFF, SEP FRAS; civs IFA French, SPE (hidden) / SPE_IFA / SPEX civs |
| Polish resistance | IFA AK, SEP AK; civs IFA Polish |
| China 1930s | EAW IJA, EAW NRA, EAW PLA, EAW Rebel, EAW Civilians |

### Lore check needed

CUP HIL, SEP ACAF (Altis Colonial Armed Forces), SEP IHAC (Horizon Island Colonial Army). The `lore` entries in `Templates.hpp` should settle them.

Settled for the 3CB templates (from the `lore` strings and the loadouts, 2026-11-24):

| Template | Lore and loadouts | Packs |
| --- | --- | --- |
| 3CB ADA | North African coalition around the Sahara, old Soviet and US gear | the 3CB ADA faction preset (Sportsman, Casa Sports, Cleopatra) |
| 3CB MDF | Malden Defence Force, island near Gibraltar, US weapons, French jets | the 3CB MDF preset, Matelot first (Malden is French-flavoured) |
| 3CB KRG | Royal guard of a Central Asian kingdom (the lore says "Kyrgystan", 3CB "Karzeghistan"), US surplus | the 3CB KRG preset, the royal Jaffudi first |
| 3CB TNM | Tanoa militia with a Western backer, WW2 and early Cold War weapons | the 3CB TNM preset (Matelot and the gag brands) |
| 3CB Marines Temperate | US Marines: `lore_USMC`, RHS FROG and G3 uniforms | the RHS US list |
| 3CB PLM | Antistasi's lore makes it a fictional Chinese, Soviet-supplied early Cold War army on the Horizon Islands; 3CB's faction is a generic guerrilla movement | Kosmos, Marlboro, Black Devil Pink: the 3CB PLM preset with Kosmos instead of Camel for the Soviet supply (owner's decision). No Cold War Chinese brand exists (Shanhai is 2035) |

Also: 3CB GAF is the Grozovia Armed Forces (Serbian and Russian weapons), not the German army, so it does not belong in the modern Germany gap.

## Tiers

| Tier (`unitType`) | Packs |
| --- | --- |
| `police` | **decided 2026-11-24:** the terrain preset of the map being played, unless the template has `cigs_packs_police[]` (built into the hook) |
| `militia` | cheaper brands of the army's own country; the template's `cigs_packs[]` when there is no militia list |
| `military` | the main national brand |
| `SF` | premium or international brand |
| `other` | crew, pilots etc.: same as `military` |

The military tier can reuse what the existing presets picked for the same faction: `presets_rhs_usaf`, `presets_rhs_afrf`, `presets_rhs_saf`, `presets_rhs_gref`, `presets_3cb`, `presets_3cb_baf`, `presets_gm`, `presets_sog`, `presets_spe`, `presets_ws`, `presets_ef`, `presets_csla`, `presets_vanilla`. See `docs/readme_brands.md`.

## Rebels and civilians

Default: leave them to the terrain presets. Exception: era templates (IFA, SPE, SPEX, SEP, VN, Unsung, GM, CWR, CSLA, EAW), as a modern terrain preset would hand out the wrong era.

## Gaps

Checked against `docs/readme_brands.md` and `addons/ai/terrainPacks.hpp` on 2026-11-23. Brand suggestions marked *memory* are from general knowledge and not verified.

### Brand gaps (no fitting brand in the mod)

| Group | Gap | Candidates (*memory*) |
| --- | --- | --- |
| WW2 Soviet (IFA SOV) | Kosmos is Cold War, Apollo Soyuz 1975 on. Nothing fits 1940s | Belomorkanal (#358, needs a papirosa model) |
| WW2 Polish resistance (IFA AK, SEP AK, IFA Polish civs) | Popularne is a Cold War look | a 1930s/40s Polish brand, needs research |
| 1930s China (EAW IJA, NRA, PLA, Rebels, Civs) | Shanhai is fictional CSAT 2035 | Golden Bat (Japan, 1906 on) for the IJA; a 1930s Chinese brand (BAT sold Ruby Queen in China before the war, check) |
| Modern Germany (CUP BW, BWA3) | Ernte 23 has a 1970s–80s look | HB, West, Lord Extra |
| Cold War UK (CWR BAF) | Lambert & Butler has the 1990s silver pack, Craven "A" is WW2 | Embassy, Rothmans, John Player Special, Benson & Hedges |
| Turkey (TMT) | no Turkish brand | Samsun, Maltepe (Tekel) |
| Croatia (CRO) | only Drina (Sarajevo-made, Yugoslav look), an awkward fit for the Croatian Army | Ronhill, Filter 160 (TDR Rovinj) |

### Thin coverage (works, but one brand or filler only)

- **SF tier in Western groups.** US, UK and Germany have no premium brand apart from their fillers. Sobranie would fit, but the rules keep it out of all presets. Decide whether the SF tier is an exception.
- **WW2 Commonwealth.** Only Craven "A". Player's Navy Cut would be the classic pick (*memory*).
- **Vietnam ANZAC.** No Australian brand; check what `presets_sog` gives ANZAC today.
- **Sahrani SLA.** Ducados is the Spanish-side brand. SLA has no own brand; Kosmos as Eastern filler?
- **Turkey, Croatia, France** have no brand of their own beyond Matelot (France) and fillers.

### Antistasi maps without a terrain preset

Rebels, civilians and every template without a preset fall back to the terrain presets, so these matter:

| Antistasi map (worldName) | Region | Likely brands |
| --- | --- | --- |
| `Kunduz` | Afghanistan (not the same as our `kunduz_valley`) | Takistan brands |
| `tem_anizay` | Afghanistan | Takistan brands |
| `Tembelan` | Indonesia | Gudang Garam |
| `isladuala3` | fictional Africa | Sportsman, Casa Sports |
| `regero` | check | – |

The other 25 Antistasi maps already have a terrain preset.

### Other open points

- The templates still under *Lore check needed* (CUP HIL, SEP ACAF, SEP IHAC).
- Extender mods add templates under their own names; those fall to the terrain presets until they add `cigs_packs[]` themselves.
- Antistasi Plus and other forks are not covered.
