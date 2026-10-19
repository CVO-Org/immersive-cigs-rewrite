# Scripting API

[Back to the documentation overview](README.md)

For mission makers and modders who write SQF.

- [Functions](#functions)
- [Unit variables](#unit-variables)
- [AI Cigs: packs per side](#ai-cigs-packs-per-side)
- [Events](#events)

## Functions

Call these where the unit is local.

| Function | What it does |
| -------- | ------------ |
| `[_unit] call cigs_core_fnc_start_cig` | Lights the cigarette in the unit's facewear/NVG slot, with lighter animation and sound. Needs a lighter or matches in the inventory. |
| `[_unit, true] call cigs_core_fnc_start_cig` | Same, but without the need for a lighter. |
| `[_unit] call cigs_core_fnc_smoking_start` | Starts smoking right away: no lighter, no animation. Needs a smokable item in the facewear/NVG slot. |
| `[_unit] call cigs_core_fnc_stop_cig` | Puts the cigarette out. |
| `[_unit] call cigs_core_fnc_start_suck` | Starts sucking the lollipop/crayon in the facewear/NVG slot. |
| `[_unit] call cigs_core_fnc_stop_suck` | Stops sucking. |
| `["PACKAGES"] call cigs_core_fnc_getAllItems` | Classnames of all packs. |
| `["LIGHTERS"] call cigs_core_fnc_getAllItems` | Classnames of all lighters and matches. |
| `["ALL"] call cigs_core_fnc_getAllItems` | Both. |
| `[] call cigs_ai_fnc_getDefaultPacks` | The [default packs](modders.md#default-pack-presets) per side, as a hashmap. `["WEST"] call cigs_ai_fnc_getDefaultPacks` returns the array of one side. |

## Unit variables

Set these with `setVariable` and broadcast them (`true` as third argument), as the checks run on different machines.

```sqf
_unit setVariable ["cigs_api_blockAnimations", true, true];
```

| Variable | Value | What it does |
| -------- | ----- | ------------ |
| `cigs_api_blockAnimations` | `true` | The unit plays no Immersive Cigs animations. |
| `cigs_api_blockDynamicSmoking` | `true` | The unit never smokes on its own. |
| `cigs_api_blockAiCigs` | `true` | The unit gets no cigarettes from AI Cigs. Must be set before the unit is processed, i.e. in its init. |

In 3DEN, these are the checkboxes in the unit's attributes, see [Mission Makers](mission-makers.md#unit-attributes-in-3den).

## AI Cigs: packs per side

To set the packs per side from a script, define `cigs_aiCigs_api` **on the server**, before the AI are processed (e.g. in `initServer.sqf`). It overrides the module and the default presets.

```sqf
// initServer.sqf
cigs_aiCigs_api = createHashMapFromArray [
    ["WEST", ["cigs_morley_cigpack", "cigs_lucky_strike_cigpack"]],
    ["EAST", ["cigs_kosmos_cigpack"]],
    ["GUER", []],                       // GUER gets nothing
    ["CIV",  ["cigs_pops_poppack"]]
];
```

- Keys: `"WEST"`, `"EAST"`, `"GUER"`, `"CIV"`. Values: arrays of pack classnames, see [Classnames](classnames.md).
- A side that is missing or empty gets nothing.
- An empty hashmap turns AI Cigs off for all sides.

## Events

The mod raises these [CBA events](https://cbateam.github.io/CBA_A3/docs/files/events/fnc_addEventHandler-sqf.html). They are local events: they fire on the machine where the unit is local. Listen to them with `CBA_fnc_addEventHandler`:

```sqf
["cigs_api_startsSmoking", {
    params ["_unit", "_loopData"];
    systemChat format ["%1 lights up a %2", name _unit, _loopData get "itemClass"];
}] call CBA_fnc_addEventHandler;
```

| Event | Parameters | When |
| ----- | ---------- | ---- |
| `cigs_api_takeFromPack` | `_unit, _packClass, _itemGlasses, _itemHMD` | A cigarette/lollipop is taken from a pack. |
| `cigs_api_useLighter` | `_unit, _lighterClass, _lighterType, _mode` | A lighter or matches are used. `_mode`: `"NORMAL"`, `"GIVING"` (lighting someone else's) or `"RECIEVING"`. |
| `cigs_api_startsSmoking` | `_unit, _loopData` | A unit starts smoking. |
| `cigs_api_startsSucking` | `_unit, _loopData` | A unit starts sucking. |
| `cigs_api_smoking` | `_unit, _loopData` | Every puff **and** every suck. Check `_loopData get "consumeType"`. |
| `cigs_api_stopsSmoking` | `_unit, _loopData` | A unit stops smoking. |
| `cigs_api_stopsSucking` | `_unit, _loopData` | A unit stops sucking. |
| `cigs_api_eatCig` | `_unit, _item, _slot` | A unit eats its cigarette/lollipop. |
| `cigs_api_respectPayed` | `_player, _target` | Respect is paid to a fallen unit. |

### `_loopData`

A hashmap with the state of the current cigarette or lollipop:

| Key | Content |
| --- | ------- |
| `"consumeType"` | `"SMOKE"` or `"SUCK"` |
| `"itemType"` | Slot of the item: `"GOGGLES"` or `"HMD"` |
| `"itemClass"` / `"currentConfig"` | Classname / config of the item |
| `"curStage"` / `"endStage"` | Current and last stage (the item model changes per stage) |
| `"curConsumes"` / `"totalConsumes"` | Puffs/sucks used so far / in total |
| `"stages"` | Hashmap: stage → puffs needed to reach it |

> [!NOTE]
> Up to v3.0.6, the events were named `cigs_core_api_*` instead of `cigs_api_*`.
