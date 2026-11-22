/*
    Debug: list every faction (classname + displayName) with its unit counts.
    Paste into the debug mission's init3den.sqf (or execVM this file from it).
    Runs once per game session (guarded by a uiNamespace flag).
    Output goes to the RPT, wrapped in FACTIONDUMP_BEGIN / FACTIONDUMP_END markers.

    Counted per faction from CfgVehicles (scope == 2, i.e. placeable in editor/Zeus):
      men      = classes inheriting from CAManBase
      vehicles = everything else that is a LandVehicle / Air / Ship / StaticWeapon
      total    = men + vehicles
*/
if (uiNamespace getVariable ["CIGS_debug_factionDumpDone", false]) exitWith {};
uiNamespace setVariable ["CIGS_debug_factionDumpDone", true];

private _counts = createHashMap; // faction -> [men, vehicles]
{
    if (getNumber (_x >> "scope") == 2) then {
        private _faction = getText (_x >> "faction");
        if (_faction != "") then {
            private _class = configName _x;
            private _entry = _counts getOrDefault [_faction, [0, 0]];
            if (_class isKindOf "CAManBase") then {
                _entry set [0, (_entry # 0) + 1];
            } else {
                if ({_class isKindOf _x} count ["LandVehicle", "Air", "Ship", "StaticWeapon"] > 0) then {
                    _entry set [1, (_entry # 1) + 1];
                };
            };
            _counts set [_faction, _entry];
        };
    };
} forEach ("true" configClasses (configFile >> "CfgVehicles"));

private _factions = "true" configClasses (configFile >> "CfgFactionClasses");
diag_log text "FACTIONDUMP_BEGIN";
diag_log text "faction;displayName;side;men;vehicles;total";
{
    private _name = configName _x;
    private _c = _counts getOrDefault [_name, [0, 0]];
    diag_log text format ["%1;%2;%3;%4;%5;%6",
        _name, getText (_x >> "displayName"), getNumber (_x >> "side"),
        _c # 0, _c # 1, (_c # 0) + (_c # 1)];
} forEach _factions;
// factions used by units but missing a CfgFactionClasses entry
{
    if (!isClass (configFile >> "CfgFactionClasses" >> _x)) then {
        diag_log text format ["%1;<no CfgFactionClasses entry>;?;%2;%3;%4", _x, _y # 0, _y # 1, (_y # 0) + (_y # 1)];
    };
} forEach _counts;
diag_log text format ["FACTIONDUMP_END (%1 factions)", count _factions];
