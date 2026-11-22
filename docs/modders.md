# Modders

[Back to the documentation overview](README.md)

Everything in Immersive Cigs is driven by config. You can add brands, lighters or default packs in your own mod without touching this one. Please do that instead of re-uploading the whole mod with small changes.

- [Adding a brand](#adding-a-brand)
- [Config properties](#config-properties)
- [Faction presets](#faction-presets)
- [Terrain presets](#terrain-presets)
- [Default pack presets](#default-pack-presets)
- Scripting: see the [Scripting API](api.md)

## Adding a brand

**Want to release your own cigarette brand?** Start from the [Immersive Cigs extension template](https://github.com/OverlordZorn/immersion-cigs-extension-template). It is a ready-to-build mod with one brand addon, placeholders to replace, Photoshop templates for the textures and a step-by-step guide. Your mod then has Immersive Cigs as a dependency.

Want your brand to become part of Immersive Cigs itself? See [Adding a Brand](adding-a-brand.md) for how to add it to this repository and send it as a pull request.

## Config properties

All properties start with `cigs_`. The easiest way is to inherit from the base classes in `addons/base` and only change what you need.

### Packs (`CfgMagazines`)

A pack is a magazine; its ammo count is the number of cigarettes.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_isPack` | `1` | Marks the magazine as a pack. Packs with `scope = 2` show up in the AI Cigs lists, Zeus modules and settings. |
| `cigs_item_glasses` | class | `CfgGlasses` class put into the facewear slot when taking one out. |
| `cigs_item_hmd` | class | `CfgWeapons` class put into the NVG slot when taking one out. |
| `cigs_unpackSound` | class | `CfgSounds` class played when taking one out. |
| `count` | number | Cigarettes per pack. |

### Smokables and suckables (`CfgGlasses` + `CfgWeapons`)

Each cigarette exists twice: as facewear (`CfgGlasses`, base `cigs_base_cigBase`) and as NVG item (`CfgWeapons`, base `cigs_base_cigBase_nv`). Each burn stage is its own class (`_cig0` … `_cig4`), so the model can get shorter.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_isSmokable` | `1` | Can be lit and smoked. |
| `cigs_isSuckable` | `1` | Can be sucked (lollipops, crayons). |
| `cigs_totalPuffs` | number | Puffs in a full cigarette (smokables). |
| `cigs_totalSucks` | number | Sucks in a full lollipop (suckables). |
| `cigs_curStage` | number | Stage of this class, starting at `0`. |
| `cigs_endStage` | number | Last stage. When it's used up, the item is gone. |
| `cigs_smokeColor[]` | `{r, g, b}` | Colour of the smoke. Default `{0.2, 0.2, 0.2}`. |
| `cigs_smokeMultiplier` | number | Amount of smoke. Default `1`. |
| `cigs_sound[]` | classes | `CfgSounds` classes for a puff (smokables). |
| `cigs_sounds[]` | classes | `CfgSounds` classes for a suck (suckables). |
| `cigs_flavor[]` | strings | Random flavour told to the player after lighting up/starting. Optional. |

### Lighters (`CfgMagazines`)

A lighter is a magazine as well; its ammo count is the number of uses (matches).

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_isLighter` | `1` | Marks the magazine as a lighter. |
| `cigs_LighterSound[]` | classes | `CfgSounds` classes played when lighting up. |

### Objects to light a cigarette at (`CfgVehicles`)

Burning fireplaces (`simulation = "fire"`, e.g. `Land_Campfire_F`) work automatically. For other objects that are always burning (barrels, stoves, ...):

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_isFireSource` | `1` | Players can light their cigarette at this object (ACE interaction). |

### Objects that can cause combustion (`CfgVehicles`)

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_canCauseCombustion` | `1` | Using a lighter within 7 m of this object can set the user on fire (needs ACE Fire). Fuel sources (ACE Refuel) count automatically. |

## Faction presets

A faction can say which packs and lighters its AI carry. Add the arrays to its class in `CfgFactionClasses`. [Brands](readme_brands.md) lists every brand with its era and where it may be used.

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_packs[]` | classes | Packs AI of this faction can get. An empty array means the faction gets no packs. |
| `cigs_lighters[]` | classes | Lighters (or matches) those AI get with the packs. Missing or empty: the normal lighter pool. |

```cpp
class CfgFactionClasses {
    class MyMod_Partisans {
        // ... the faction's own entries
        cigs_packs[]    = { "cigs_eckstein_cigpack", "cigs_kosmos_cigpack" };
        cigs_lighters[] = { "cigs_matches" };
    };
};
```

- **No dependency needed.** These are plain strings, so a faction mod can add them to its own factions without requiring Immersive Cigs.
- **Classnames that aren't loaded are dropped.** A faction can list packs of optional brands. If none of them are loaded, the faction gets no packs.
- **Where it ranks.** Faction presets come after the scripts, the module, the pack selection and `cigs_aiCigs_api_lesser`, and before the terrain and default presets below. See [Mission Makers](mission-makers.md#which-packs-a-side-gets). Server admins can turn them off with *Use Faction Presets*.
- **Related factions don't share entries.** `BLU_F` and `BLU_T_F` each need their own entry. The exception is config inheritance: a faction class that inherits from another one (e.g. Global Mobilization's `gm_fc_gc_civ: gm_fc_gc`) also inherits its `cigs_packs[]`. Give the child class its own entry if it should get something else.

To add presets to **another mod's** factions, use a compat addon that loads after that mod and is skipped when it's missing:

```cpp
class CfgPatches {
    class MyMod_cigs_compat_theirMod {
        requiredAddons[] = { "their_mod_factions" };   // the CfgPatches class that defines the factions
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = {};
    };
};
class CfgFactionClasses {
    class their_faction {
        cigs_packs[] = { "cigs_lucky_strike_cigpack" };
    };
};
```

If the faction class has a parent class, declare it with the same parent, or the inheritance breaks.

### Included faction presets

Immersive Cigs brings entries for the vanilla factions (addon `presets_vanilla`). Units pick 1–3 packs at random from the list.

| Faction | Packs |
| ------- | ----- |
| NATO `BLU_F` | Morley, Marlboro, Camel, Crayons |
| NATO (Pacific) `BLU_T_F` | Morley, Marlboro, Matelot, Crayons |
| NATO (Woodland) `BLU_W_F` | Morley, Marlboro, Lipa, Crayons |
| CTRG `BLU_CTRG_F` | Marlboro, Morley, NIL |
| Gendarmerie `BLU_GEN_F`, `OPF_GEN_F` | Matelot, Morley, NIL |
| Syndikat `IND_C_F` | Matelot, Black Devil, Baja Blast |
| AAF `IND_F` | Almyra, Morley, NIL |
| FIA `BLU_G_F`, `OPF_G_F`, `IND_G_F` | Almyra, Morley, Black Devil, NIL |
| CSAT `OPF_F` | Alborz, Apollo Soyuz, Kosmos |
| CSAT (Pacific) `OPF_T_F` | Shanhai, Alborz, Apollo Soyuz |
| Viper `OPF_V_F` | Shanhai, Alborz, NIL |
| Spetsnaz `OPF_R_F` | Kosmos, Apollo Soyuz, Voron |
| LDF `IND_E_F` | Lipa Dzwonek, Lipa, Voron, NIL |
| Looters `IND_L_F` | Lipa, Voron, Black Devil, NIL |
| IDAP `CIV_IDAP_F` | Lollipops, Morley, NIL |

Civilians (`CIV_F`) have no entry, as they cover several maps at once; they get the [terrain presets](#terrain-presets) of the map instead. The Contact DLC's own factions (EMP variants, extraterrestrials) have none either.

#### Global Mobilization

Addon `presets_gm`, active when the CDLC is loaded. Border guards and civilians (`_bgs`, `_civ`) inherit their country's entry. The other GM countries have no units and no entry.

| Faction | Packs |
| ------- | ----- |
| West Germany `gm_fc_ge` | Ernte 23, Marlboro, Morley |
| Denmark `gm_fc_dk` | Prince, Morley, Marlboro, Camel |
| East Germany `gm_fc_gc` | f6, Kosmos, Apollo Soyuz |
| Poland `gm_fc_pl` | Popularne, Kosmos, Apollo Soyuz |
| Revolutionaries `gm_fc_xx` | Popularne, f6, Kosmos |

#### S.O.G. Prairie Fire

Addon `presets_sog`, active when the CDLC is loaded.

| Faction | Packs |
| ------- | ----- |
| MACV `B_MACV`, US CIA `B_CIA`, US MEDT `B_MEDT` | Marlboro, Camel, Savage, Morley |
| Australia `B_AUS`, New Zealand `B_NZ` | Camel, Savage, Morley |
| Republic Of Korea `B_ROK` | Hwarang, Marlboro, Savage |
| ARVN `I_ARVN` | Ruby Queen, Marlboro, Savage |
| Royal Lao Army `I_LAO`, FANK `I_CAM`, Vietnamese `C_VIET` | Ruby Queen, Savage, Morley |
| PAVN `O_PAVN`, Viet Cong `O_VC`, Pathet Lao `O_PL`, Khmer Rouge `O_CAM` | Ruby Queen, Kosmos, Savage |

#### CSLA Iron Curtain

Addon `presets_csla`, active when the CDLC is loaded.

| Faction | Packs |
| ------- | ----- |
| CSLA `CSLA`, `CSLA_DES`, Civilians `CSLA_CIV` | Sparta, Kosmos, Apollo Soyuz |
| FIA `FIA`, `FIA_DES` | Sparta, Kosmos, Marlboro |
| Armed Forces of the Midland Coalition `AFMC` | Gudok, Zamok, Sosna, Marlboro, Camel |
| US '85 `US85`, `US85_DES` | Marlboro, Morley, Camel |

#### Western Sahara

Addon `presets_ws`, active when the CDLC is loaded. The SFIA and Tura classes of the other sides inherit the GUER entry.

| Faction | Packs |
| ------- | ----- |
| SFIA `IND_SFIA_lxWS` (+ `OPF_SFIA_lxWS`) | Casa Sports, Black Devil, Morley |
| Tura `IND_TURA_lxWS` (+ `BLU_TURA_lxWS`, `OPF_TURA_lxWS`) | Casa Sports, Black Devil, Mtn Dew Baja Blast |
| ION Services `BLU_ION_lxWS` | Camel, Morley, Marlboro |
| UNA `BLU_UN_lxWS` | Camel, Morley, Prince |
| NATO (Desert) `BLU_NATO_lxWS` | Morley, Marlboro, Camel, Crayons |

#### Spearhead 1944

Addon `presets_spe`, active when the CDLC is loaded.

| Faction | Packs |
| ------- | ----- |
| Wehrmacht `SPE_WEHRMACHT`, Sturmtroopers `SPE_STURM` | Eckstein, Juno |
| La Milice `SPE_MILICE` | Troupes, Eckstein, Juno |
| French Interior Forces `SPE_FFI` | Troupes, Matelot, Lucky Strike |
| French Liberation Army `SPE_FR_ARMY` | Troupes, Lucky Strike, Craven "A" |
| 40s Civilians `SPE_CIV` | Troupes, Matelot, Eckstein |
| US Army `SPE_US_ARMY` | Lucky Strike, Morley, Craven "A" |

#### Expeditionary Forces

Addon `presets_ef`, active when the CDLC is loaded.

| Faction | Packs |
| ------- | ----- |
| MJTF (Desert) `EF_B_MJTF_Des`, MJTF (Woodland) `EF_B_MJTF_Wdl` | Matelot, Morley, Marlboro, Crayons |
| MJTF (Navy) `EF_B_MJTF_Navy` | Matelot, Morley, Marlboro |

#### RHS

Addons `presets_rhs_afrf`, `presets_rhs_usaf`, `presets_rhs_gref` and `presets_rhs_saf`, one per RHS mod, each active when its mod is loaded. Entries sit on the base classes; the other factions and side variants inherit them. Belomorkanal, Parliament, Newport and Drina are planned brands (issues #358, #359, #357, #361): until they are in the mod, those packs are dropped and the rest of the list is used.

| Faction | Packs |
| ------- | ----- |
| Russia `rhs_faction_msv` (+ VDV, VDV 1945, VMF, VV, TV, VPVO, VVS, RVA) | Belomorkanal, Parliament, Kosmos, Apollo Soyuz, Marlboro |
| Eastern Militia `rhs_faction_insurgents` | Gudok, Belomorkanal, Zamok, Kosmos |
| US Army `rhs_faction_usarmy` (+ USMC, USAF, USN, SOCOM, woodland and desert variants) | Marlboro, Camel, Newport, Morley |
| CDF Ground Forces, Air Forces, National Guard `rhsgref_faction_cdf_ground`, `_air`, `_ng` (+ `_b`) | Zamok, Sosna, Gudok, Marlboro |
| NAPA `rhsgref_faction_nationalist` | Sosna, Gudok, Marlboro |
| ChDKZ `rhsgref_faction_chdkz` (+ `_g`) | Gudok, Belomorkanal, Kosmos |
| United Nations `rhsgref_faction_un` | Camel, Morley, Prince |
| Horizon Islands Defence Force `rhsgref_faction_hidf` | Matelot, Marlboro, Morley |
| Tanoan Liberation Army `rhsgref_faction_tla` (+ `_g`) | Matelot, Black Devil Pink, Mtn Dew Baja Blast |
| Serbian Army, Air Force `rhssaf_faction_army`, `_airforce` (+ `_opfor`) | Drina, Marlboro, Camel |
| Serbian UN contingent `rhssaf_faction_un` | Drina, Camel, Prince |

#### 3CB Factions and 3CB BAF

Addons `presets_3cb` (3CB Factions) and `presets_3cb_baf` (3CB BAF), each active when its mod is loaded. 3CB has no inheritance between its faction classes, so every side class (`UK3CB_<X>_O`, `_B`, `_I`, civilians also `_C`) has its own entry; all sides of a faction get the same packs unless noted. Belomorkanal, Sportsman and Lambert & Butler are planned brands (issues #358, #362, #360) and are dropped until they are in the mod.

| Faction | Packs |
| ------- | ----- |
| AAF `AAF`, Altis Police `APD` | Almyra, Morley, NIL |
| FIA `FIA` | Almyra, Morley, Black Devil Pink, NIL |
| Malden Defence Force `MDF` | Matelot, Marlboro, Morley |
| Tanoa Nationalist Militia `TNM` | Matelot, Black Devil Pink, Mtn Dew Baja Blast |
| Horizon Islands Gendarmerie `TPD` | Matelot, Morley, NIL |
| Livonia Defence Force `LDF` | Lipa Dzwonek, Lipa, Voron, NIL |
| Livonia Forest Rangers `LFR` | Lipa, Lipa Dzwonek, NIL |
| Livonian Nationalist Militia `LNM` | Lipa, Popularne, NIL |
| Livonia Separatist Militia `LSM` | Belomorkanal, Lipa, Kosmos |
| Chernarus Civilians `CHC` | Gudok, Zamok, Sosna, Belomorkanal, Marlboro |
| Chernarus Police `CPD` | Zamok, Gudok, Marlboro |
| NAPA `NAP` | Sosna, Gudok, Marlboro |
| Chernarus Communist Militia `CCM_O`, ChDKZ Red Star `CHD_O`, `CHD_W_O` | Gudok, Belomorkanal, Kosmos |
| Chernarus Local Defence Volunteers `CCM_B`, ChDSZ Blue Star `CHD_B`, `CHD_W_B` | Zamok, Sosna, Marlboro |
| Chernarus Nationalist Militia `CCM_I` | Sosna, Gudok, Marlboro |
| ChDZZ Green Star `CHD_I`, `CHD_W_I` | Sosna, Gudok, Zamok |
| Grozovia Armed Forces `GAF` | Zamok, Belomorkanal, Marlboro |
| Nogovan Freedom Alliance `NFA` | Sparta, Belomorkanal, Marlboro |
| Nogova Police `NPD` | Sparta, Marlboro, Morley |
| Kolgujev Defence Force `KDF` | Belomorkanal, Kosmos, Marlboro |
| Takistan National Army `TKA` | Zargabad, Jaffudi, Sharig, Marlboro |
| Takistan Civilians `TKC` | Zargabad, Sharig, Jaffudi, Kosmos, Marlboro |
| Takistan National Police `TKP` | Zargabad, Jaffudi, Marlboro |
| Takistan Insurgents `TKM_O`, Tribal Fighters `TKM_I` | Zargabad, Sharig, Kosmos |
| Takistan Pro-Government Militia `TKM_B` | Zargabad, Sharig, Marlboro |
| Afghan National Army `ANA_B`, Afghan National Police `ANP_B` | Zargabad, Sharig, Marlboro |
| Ardistan Army `ARD` | Sharig, Zargabad, Belomorkanal |
| Karzeghistan Royal Guard `KRG` | Jaffudi, Sharig, Marlboro |
| Middle East Civilians `MEC` | Zargabad, Jaffudi, Alborz, Marlboro |
| Middle East Insurgents `MEI` | Zargabad, Sharig, Alborz |
| Middle East Extremists `MEE` | Sharig, Alborz, Zargabad |
| African Desert Army `ADA` | Sportsman, Casa Sports, Marlboro, Camel |
| African Desert Army Paramilitary `ADR` | Sportsman, Casa Sports, Marlboro |
| African Desert National Police `ADP` | Sportsman, Casa Sports, Camel |
| African Desert Civilians `ADC` | Sportsman, Casa Sports, Camel, Marlboro |
| African Desert Civilian Militia `ADG`, Militia `ADM` | Sportsman, Casa Sports, Black Devil Pink |
| African Desert Extremists `ADE` | Casa Sports, Sportsman, Camel |
| PLM `PLM` | Camel, Marlboro, Black Devil Pink |
| Western European Insurgents `WEI` | Marlboro, Camel, Black Devil Pink, NIL |
| UN Peacekeepers `UN` | Camel, Morley, Prince |
| ION Services, all camos and sides `ION_<side>_<camo>` | Camel, Morley, Marlboro |
| CSAT Europe, Middle East, Mediterranean, Navy, Winter, Urban `CSAT_<W/B/M/F/S/U>_O` | Alborz, Apollo Soyuz, Kosmos |
| CSAT Pacific, Navy (Pacific) `CSAT_G_O`, `CSAT_N_O` | Shanhai, Alborz, Apollo Soyuz |
| CSAT Africa `CSAT_A_O` | Alborz, Apollo Soyuz, Sportsman |
| Cold War USSR Early `CW_SOV_O_EARLY` | Kosmos, Belomorkanal |
| Cold War USSR Late `CW_SOV_O_LATE` | Kosmos, Apollo Soyuz, Belomorkanal |
| Cold War US Early, Late `CW_US_B_EARLY`, `_LATE` | Marlboro, Camel, Morley |
| British Armed Forces (3CB BAF) `UK3CB_BAF_Faction` | Lambert & Butler, Marlboro, Morley |

## Terrain presets

Units whose faction has no faction preset get the packs that are locally available on the current terrain, whatever their side. This is mainly for civilians: vanilla `CIV_F` is one faction for Altis, Tanoa and Livonia, so only the terrain can say which brands are local. Add a class named after the terrain's `worldName` to `cigs_terrainPacks`:

```cpp
class cigs_terrainPacks {
    class MyTerrain {                                       // worldName
        packs[] = { "cigs_gudok_cigpack", "cigs_zamok_cigpack", "cigs_sosna_cigpack" };
    };
};
```

- **No dependency needed.** It is a plain root class, so a terrain mod can add its own entry without requiring Immersive Cigs, and nothing in `CfgWorlds` is touched.
- **The same for all sides.** Every unit without a faction preset gets these packs, civilians and soldiers alike. An empty array means those units get no packs. Terrains without an entry leave them to the default presets.
- **Classnames that aren't loaded are dropped**, as with faction presets.
- **Where it ranks.** After the faction presets, before the default presets. Server admins can turn them off with *Use Terrain Presets*.

### Included terrain presets

Each terrain lists what a local shop would sell: the regional brand first, then other brands of the region and era, then international brands that fit the era. Units pick 1–3 at random. No gag brands and no Voron, as these reach civilians and soldiers alike. The WW2-era looks (Craven "A", Eckstein, Juno, Lucky Strike, Troupes) only appear on the 1940s terrains.

Every vanilla military and guerrilla faction has its own faction preset, so these reach the civilians and mod factions without a preset. VR has no entry.

| Terrain | Packs |
| ------- | ----- |
| Altis `Altis`, Stratis `Stratis` | Almyra, Morley, Marlboro, Camel, NIL |
| Malden `Malden` | Matelot, Morley, Marlboro, Camel, NIL |
| Tanoa `Tanoa` | Matelot, Morley, Shanhai, Marlboro, Camel, NIL |
| Livonia `Enoch` | Lipa, Lipa Dzwonek, Popularne, Marlboro, Camel, NIL |
| Weferlingen (Global Mobilization) `gm_weferlingen_summer`, `gm_weferlingen_winter` | f6, Ernte 23, Kosmos, Apollo Soyuz, Marlboro |
| Cam Lao Nam, Khe Sanh, The Bra (S.O.G. Prairie Fire) `Cam_Lao_Nam`, `vn_khe_sanh`, `vn_the_bra` | Ruby Queen, Savage, Marlboro, Camel, Kosmos |
| Stožec (CSLA Iron Curtain) `Stozec` | Sparta, Kosmos, Apollo Soyuz, Popularne, f6 |
| Sefrou-Ramal (Western Sahara) `SefrouRamal` | Casa Sports, Camel, Marlboro, Morley |
| Normandy, Mortain (Spearhead 1944) `SPE_Normandy`, `SPE_Mortain` | Troupes, Matelot, Eckstein, Juno, Lucky Strike, Craven "A", Camel |

The CDLC entries need no dependency: they only apply while that terrain is loaded. The CDLC factions keep their own faction presets, so these reach the other factions on the terrain. Expeditionary Forces and Reaction Forces bring no terrain.

## Default pack presets

The packs AI get when the mission has no *Configure AI Cigs* module come from presets in `class cigs_ai_defaultPacks`. A newly placed module also starts with these packs ticked. See [Mission Makers](mission-makers.md#which-packs-a-side-gets) for how the sources are prioritised.

How they're resolved:

- A preset is **active** when all its `requiredAddons[]` are loaded (CfgPatches) and its `condition` returns `true`. Both are optional.
- **Per side**, the active preset with the highest `priority` that defines that side wins.
- A preset only needs to list the sides it changes. The others fall through to lower priorities.

| Preset | Priority | Active when | Sides |
| ------ | -------- | ----------- | ----- |
| `Vanilla` | 0 | always | all four |

### Adding your own preset

Add a class to `cigs_ai_defaultPacks` in your mod's `config.cpp`. Make your `CfgPatches` require `cigs_ai`, so your preset loads after the base class.

```cpp
class cigs_ai_defaultPacks {
    class MyMod_Desert {
        priority = 20;                                  // Higher wins. Vanilla is 0.
        requiredAddons[] = { "my_desert_units" };       // Optional - all need to be loaded
        condition = "true";                             // Optional - SQF, needs to return a BOOL
        WEST[] = { "cigs_lucky_strike_cigpack" };       // Optional per side: WEST, EAST, GUER, CIV
        GUER[] = { "cigs_black_devil_cigpack" };
    };
};
```

Here, WEST and GUER come from `MyMod_Desert`, while EAST and CIV fall through to `Vanilla`.

> [!TIP]
> Prefer `requiredAddons[]` over `condition` to check for a mod.
> Presets are resolved early (in preInit and in 3DEN), and only once per game session. Variables set later (e.g. in postInit) don't exist yet when `condition` is checked.
