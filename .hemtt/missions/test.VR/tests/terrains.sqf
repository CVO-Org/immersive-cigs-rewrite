// Terrain list: logs every loaded terrain to the RPT ("[cigs][terrains]"), to find the worldName (the class name in
// terrainPacks.hpp) of a new terrain mod. Launch with `hemtt launch terrains` to load the candidate terrains.
// Per terrain: worldName, its display name, the mod it comes from, its addons, and whether it already has a terrain preset.
// Runs anywhere, unscheduled is fine. From the debug console: [] call cigs_test_fnc_terrains;

private _worlds = ("getText (_x >> 'worldName') != ''" configClasses (configFile >> "CfgWorlds")) apply {
    [configName _x, getText (_x >> "description"), configSourceMod _x, configSourceAddonList _x, isClass (configFile >> "cigs_terrainPacks" >> configName _x)]
};
_worlds sort true;

private _missing = _worlds select { !(_x select 4) };

diag_log text format ["[cigs][terrains] %1 terrains loaded, %2 without a terrain preset", count _worlds, count _missing];
diag_log text "[cigs][terrains] worldName | name | mod | addons | terrain preset";
{
    _x params ["_class", "_name", "_mod", "_addons", "_hasPreset"];
    diag_log text format ["[cigs][terrains] %1 | %2 | %3 | %4 | %5", _class, _name, ["vanilla", _mod] select (_mod != ""), _addons joinString ", ", ["-", "yes"] select _hasPreset];
} forEach _worlds;

diag_log text "[cigs][terrains] Without a terrain preset (worldName, name, mod):";
{
    _x params ["_class", "_name", "_mod"];
    diag_log text format ["[cigs][terrains]     %1 - %2 (%3)", _class, _name, ["vanilla", _mod] select (_mod != "")];
} forEach _missing;

systemChat format ["[cigs][terrains] %1 terrains logged to the RPT, %2 without a terrain preset", count _worlds, count _missing];
