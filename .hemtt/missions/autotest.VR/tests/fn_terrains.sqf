/*
* Author: Zorn
* Logs every loaded terrain to the RPT ("[cigs][terrains]"), to find the worldName of a new terrain mod.
* A list, not a test: launch the 'terrains' profile and read it with -Grep '[cigs][terrains]'.
*
* Notes from the old test:
* The worldName is the class name in terrainPacks.hpp.
* Per terrain: worldName, its display name, the mod it comes from, its addons, and whether it already has a terrain preset.
*
* Arguments:
* None
*
* Return Value:
* Tests <ARRAY>
*
* Example:
* [["terrains"]] spawn autotest_fnc_runAll;
*
* Public: No
*/

[
    ["Loaded terrains and their terrain presets", {
        params ["_ctx"];

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

        ["listed the loaded terrains", count _worlds > 0, format ["%1 terrains, %2 without a terrain preset", count _worlds, count _missing]] call autotest_fnc_check;
    }, 60]
]
