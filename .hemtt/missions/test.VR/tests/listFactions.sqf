// Lists every faction class (CfgFactionClasses) of the loaded game and mods into the RPT,
// as the starting point for faction presets (docs/modders.md, "Faction presets").
// Start with the mods/CDLCs you want (e.g. `hemtt launch factions`); the list is written once at mission start.
// To run it again, from the debug console: [] call cigs_test_fnc_listFactions;
//
// One faction per line, ";"-separated, every line prefixed with "[cigs][factions]":
//   mod;class;displayName;side;parent;sourceAddon;hasCigsPacks;men;vehicles
// - mod:          configSourceMod, e.g. "vn" for S.O.G. Prairie Fire, "" for the base game
// - parent:       the parent class (needed when a preset declares the class), "" when none
// - sourceAddon:  the CfgPatches class that defines the faction, the one to put in requiredAddons[]
// - hasCigsPacks: whether the faction already has cigs_packs[]
// - men:          editor-placeable (scope 2) CAManBase classes of the faction - 0 means it has no infantry, so no preset needed
// - vehicles:     editor-placeable (scope 2) other CfgVehicles classes of the faction
// Filter the RPT for "[cigs][factions]", strip the prefix and paste into a spreadsheet with ";" as separator.

private _sideNames = ["EAST", "WEST", "GUER", "CIV"];

// men and vehicles per faction, only those placeable in the editor (scope 2) - a faction with 0 men has no infantry
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
    private _parent = inheritsFrom _x;
    private _addons = configSourceAddonList _x;
    private _side = getNumber (_x >> "side");

    private _sideName = str _side;
    if (_side >= 0 && {_side < count _sideNames}) then { _sideName = _sideNames select _side; };

    private _parentName = "";
    if (!isNull _parent) then { _parentName = configName _parent; };

    private _sourceAddon = "";
    if (_addons isNotEqualTo []) then { _sourceAddon = _addons select 0; };

    [
        configSourceMod _x,
        configName _x,
        getText (_x >> "displayName"),
        _sideName,
        _parentName,
        _sourceAddon,
        str isArray (_x >> "cigs_packs"),
        str (_men getOrDefault [configName _x, 0]),
        str (_vehicles getOrDefault [configName _x, 0])
    ]
};

_rows sort true;

diag_log text "[cigs][factions] mod;class;displayName;side;parent;sourceAddon;hasCigsPacks;men;vehicles";
{
    diag_log text ("[cigs][factions] " + (_x joinString ";"));
} forEach _rows;

diag_log text format ["[cigs][factions] %1 factions listed", count _rows];
systemChat format ["%1 factions listed in the RPT", count _rows];
