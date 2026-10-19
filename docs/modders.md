# Modders

[Back to the documentation overview](README.md)

Everything in Immersive Cigs is driven by config. You can add brands, lighters or default packs in your own mod without touching this one. Please do that instead of re-uploading the whole mod with small changes.

- [Adding a brand](#adding-a-brand)
- [Config properties](#config-properties)
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

### Objects that can cause combustion (`CfgVehicles`)

| Property | Type | Description |
| -------- | ---- | ----------- |
| `cigs_canCauseCombustion` | `1` | Using a lighter within 7 m of this object can set the user on fire (needs ACE Fire). Fuel sources (ACE Refuel) count automatically. |

## Default pack presets

The packs AI get when the mission has no *Configure AI Cigs* module come from presets in `class cigs_ai_defaultPacks`. A newly placed module also starts with these packs ticked. See [Mission Makers](mission-makers.md#which-packs-a-side-gets) for how the sources are prioritised.

How they're resolved:

- A preset is **active** when all its `requiredAddons[]` are loaded (CfgPatches) and its `condition` returns `true`. Both are optional.
- **Per side**, the active preset with the highest `priority` that defines that side wins.
- A preset only needs to list the sides it changes. The others fall through to lower priorities.

| Preset | Priority | Active when | Sides |
| ------ | -------- | ----------- | ----- |
| `Vanilla` | 0 | always | all four |
| `SOGPF` | 10 | S.O.G. Prairie Fire is loaded (`weapons_f_vietnam_c`) | all four: Savage pack |

### Adding your own preset

Add a class to `cigs_ai_defaultPacks` in your mod's `config.cpp`. Make your `CfgPatches` require `cigs_ai`, so your preset loads after the base class.

```cpp
class cigs_ai_defaultPacks {
    class MyMod_Desert {
        priority = 20;                                  // Higher wins. Vanilla is 0, SOGPF is 10.
        requiredAddons[] = { "my_desert_units" };       // Optional - all need to be loaded
        condition = "true";                             // Optional - SQF, needs to return a BOOL
        WEST[] = { "cigs_lucky_strike_cigpack" };       // Optional per side: WEST, EAST, GUER, CIV
        GUER[] = { "cigs_black_devil_cigpack" };
    };
};
```

Here, WEST and GUER come from `MyMod_Desert`, while EAST and CIV fall through to `SOGPF` or `Vanilla`.

> [!TIP]
> Prefer `requiredAddons[]` over `condition` to check for a mod.
> Presets are resolved early (in preInit and in 3DEN), and only once per game session. Variables set later (e.g. in postInit) don't exist yet when `condition` is checked.
