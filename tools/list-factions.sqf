/*
 * Lists every faction class (CfgFactionClasses) of the loaded game and mods,
 * as the starting point for faction presets (docs/modders.md, "Faction presets").
 *
 * Usage: start the game with the mods/CDLCs you want (e.g. `hemtt launch factions`),
 * paste this into the debug console and press "Local Exec".
 * The result is copied to the clipboard and written to the RPT, one faction per line, ";"-separated:
 *
 *   mod;class;displayName;side;parent;sourceAddon;hasCigsPacks
 *
 * - mod:          configSourceMod, e.g. "vn" for S.O.G. Prairie Fire, "" for the base game
 * - parent:       the parent class (needed when the preset declares the class), "" when none
 * - sourceAddon:  the CfgPatches class that defines the faction, the one to put in requiredAddons[]
 * - hasCigsPacks: whether the faction already has cigs_packs[]
 *
 * Paste the clipboard into a spreadsheet with ";" as separator to sort and filter.
 */

private _sideNames = ["EAST", "WEST", "GUER", "CIV"];

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
        str isArray (_x >> "cigs_packs")
    ]
};

_rows sort true;

private _lines = ["mod;class;displayName;side;parent;sourceAddon;hasCigsPacks"];
{
    private _line = _x joinString ";";
    _lines pushBack _line;
    diag_log text _line;
} forEach _rows;

copyToClipboard (_lines joinString endl);
hint format ["%1 factions copied to the clipboard", count _rows];
