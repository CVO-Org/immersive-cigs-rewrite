# SQF snippets

Debug console snippets used while working on the mod, so they don't have to be written again. Paste one into the debug console (Escape menu, with the Advanced Developer Tools from the launch profiles, or the vanilla console in the editor) and press **Local Exec**, unless the snippet says server.

The longer ones write to the RPT with a `[cigs][...]` prefix: filter the RPT for that prefix, strip it, and paste the lines into a spreadsheet. Most also copy their result to the clipboard (`copyToClipboard` only works on the local machine, not on a dedicated server).

Add a snippet here whenever you write a new one for the debug console.

## Terrains

### Current terrain and its terrain preset

```sqf
[worldName, getText (configFile >> "CfgWorlds" >> worldName >> "description"), configSourceMod (configFile >> "CfgWorlds" >> worldName), [] call cigs_ai_fnc_getTerrainPacks]
```

Returns the worldName (the class name in `addons/ai_presets_terrains/terrainPacks.hpp`), the display name, the mod it comes from and the packs of its terrain preset. The packs are `nil` when the terrain has no entry; classnames of brands that aren't loaded are dropped.

### Every loaded terrain

The same as `.hemtt/missions/test.VR/tests/terrains.sqf`, which runs at the start of the test mission. Launch with `hemtt launch terrains` for the candidate terrains.

```sqf
private _worlds = ("getText (_x >> 'worldName') != ''" configClasses (configFile >> "CfgWorlds")) apply {
    [configName _x, getText (_x >> "description"), configSourceMod _x, configSourceAddonList _x, isClass (configFile >> "cigs_terrainPacks" >> configName _x)]
};
_worlds sort true;
diag_log text "[cigs][terrains] worldName;name;mod;addons;terrainPreset";
{
    _x params ["_class", "_name", "_mod", "_addons", "_hasPreset"];
    diag_log text format ["[cigs][terrains] %1;%2;%3;%4;%5", _class, _name, _mod, _addons joinString ",", _hasPreset];
} forEach _worlds;
copyToClipboard ((_worlds select { !(_x select 4) } apply { format ["%1 - %2 (%3)", _x select 0, _x select 1, _x select 2] }) joinString endl);
format ["%1 terrains, %2 without a terrain preset (copied)", count _worlds, { !(_x select 4) } count _worlds]
```

Logs every terrain; the clipboard gets only the terrains without a terrain preset. `mod` is `A3` for the base game, otherwise the mod folder (for example `@Bornholm`, or the workshop ID).

## Factions

### Every faction class

Logs every faction in `CfgFactionClasses`, as the starting point for faction presets. Start with the mods or CDLCs you want (`hemtt launch factions`, `rhs` or `3cb`).

```sqf
private _sideNames = ["EAST", "WEST", "GUER", "CIV"];
private _men = createHashMap;
private _vehicles = createHashMap;
{
    private _faction = getText (_x >> "faction");
    if (_faction != "") then {
        private _map = [_vehicles, _men] select ((configName _x) isKindOf "CAManBase");
        _map set [_faction, (_map getOrDefault [_faction, 0]) + 1];
    };
} forEach ("getNumber (_x >> 'scope') == 2" configClasses (configFile >> "CfgVehicles"));

private _rows = ("true" configClasses (configFile >> "CfgFactionClasses")) apply {
    private _side = getNumber (_x >> "side");
    private _parent = inheritsFrom _x;
    [
        configSourceMod _x,
        configName _x,
        getText (_x >> "displayName"),
        _sideNames param [_side, str _side],
        ["", configName _parent] select !isNull _parent,
        (configSourceAddonList _x) param [0, ""],
        str isArray (_x >> "cigs_packs"),
        str (_men getOrDefault [configName _x, 0]),
        str (_vehicles getOrDefault [configName _x, 0])
    ]
};
_rows sort true;
diag_log text "[cigs][factions] mod;class;displayName;side;parent;sourceAddon;hasCigsPacks;men;vehicles";
{ diag_log text ("[cigs][factions] " + (_x joinString ";")) } forEach _rows;
format ["%1 factions listed in the RPT", count _rows]
```

- `parent`: the parent class, which a preset has to declare. Empty when there is none.
- `sourceAddon`: the CfgPatches class that defines the faction, the one for `requiredAddons[]`.
- `men` / `vehicles`: editor-placeable (scope 2) classes of the faction. A faction with 0 men has no infantry and needs no preset.

### Factions of one mod

```sqf
("configSourceMod _x == 'vn'" configClasses (configFile >> "CfgFactionClasses")) apply { [configName _x, getText (_x >> "displayName")] }
```

Replace `vn` with the mod folder that `configSourceMod` returns (`vn` is S.O.G. Prairie Fire, `A3` the base game).

## AI presets

### What a unit gets, and from where

Look at a unit and run:

```sqf
private _unit = cursorObject;
[typeOf _unit, faction _unit, side group _unit, [_unit] call cigs_ai_fnc_getConfigPresets, [_unit] call cigs_ai_fnc_getCigItems]
```

Returns the unit class, its faction, its side, the unit class and faction presets (a hashmap with `packs`, `lighters` and `packsExtra`, empty when none apply) and the packs the unit would get now, from whichever level decides (see `fn_getCigItems.sqf` for the order).

### The faction preset as written in config

```sqf
getArray (configFile >> "CfgFactionClasses" >> faction cursorObject >> "cigs_packs")
```

Unlike `getConfigPresets`, this keeps classnames of brands that aren't loaded.

### Default presets per side

```sqf
[] call cigs_ai_fnc_getDefaultPacks
```

A hashmap per side; pass `"WEST"`, `"EAST"`, `"GUER"` or `"CIV"` for one side.

### Antistasi: templates and what nearby units get

**Server Exec**: the loaded templates (`A3A_Occ_template` etc.) only exist on the server. Look up the result in the server RPT.

```sqf
private _templates = ["Occ", "Inv", "Reb", "Civ"] apply { [_x, missionNamespace getVariable [format ["A3A_%1_template", _x], ""]] };
diag_log text format ["[cigs][a3a] templates %1", _templates];
diag_log text "[cigs][a3a] class;unitType;presets;packs";
{
    diag_log text format ["[cigs][a3a] %1;%2;%3;%4", typeOf _x, _x getVariable ["unitType", ""], [_x] call cigs_ai_fnc_getConfigPresets, [_x] call cigs_ai_fnc_getCigItems];
} forEach ((allPlayers select 0) nearEntities ["CAManBase", 300] select { !isPlayer _x });
```

Logs the loaded template per role, then each AI unit within 300 m of the first player: its class, its Antistasi `unitType` (role and tier), the template presets and the packs it would get now. Empty presets mean the template has no entry for that tier, so the unit gets the terrain or default presets.

## Brands and items

### Every loaded pack

```sqf
private _packs = ("getNumber (_x >> 'cigs_isPack') == 1 && { getNumber (_x >> 'scope') > 0 }" configClasses (configFile >> "CfgMagazines")) apply { configName _x };
copyToClipboard (_packs joinString endl);
_packs
```

### Is a brand loaded?

```sqf
["cleopatra", "belomorkanal"] apply { [_x, isClass (configFile >> "CfgPatches" >> ("cigs_" + _x)), isClass (configFile >> "CfgMagazines" >> ("cigs_" + _x + "_cigpack"))] }
```

Per brand: the addon is loaded, and its pack exists.

### Where a config class comes from

```sqf
private _cfg = configFile >> "CfgMagazines" >> "cigs_cleopatra_cigpack";
[configSourceMod _cfg, configSourceAddonList _cfg]
```

The mod folder and every addon that defines or changes the class. Useful to see whether a compat addon touched it.
