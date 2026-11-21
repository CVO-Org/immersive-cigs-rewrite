// Lists every faction in CfgFactionClasses with its display name, side and how many units it has.
// "men" = scope 2 (public) CAManBase classes with that faction, "vehicles" = all other scope 2 classes with that faction.
// Results go to the RPT, one line per faction, prefixed "[cigs][factions]", as CSV:
//     classname,"displayName",side,men,vehicles
// Factions without any public unit are listed too (men = 0), so nothing is hidden.

private _sides = ["EAST", "WEST", "GUER", "CIV", "UNKNOWN", "ENEMY", "FRIENDLY", "LOGIC", "EMPTY", "AMBIENT"];

// count the units per faction in one pass over CfgVehicles
private _men = createHashMap;
private _vehicles = createHashMap;
{
    if ( getNumber (_x >> "scope") isEqualTo 2 ) then {
        private _faction = getText (_x >> "faction");
        if ( _faction isNotEqualTo "" ) then {
            if ( configName _x isKindOf "CAManBase" ) then {
                _men set [_faction, (_men getOrDefault [_faction, 0]) + 1];
            } else {
                _vehicles set [_faction, (_vehicles getOrDefault [_faction, 0]) + 1];
            };
        };
    };
} forEach ( "true" configClasses (configFile >> "CfgVehicles") );

private _factions = ( "true" configClasses (configFile >> "CfgFactionClasses") ) apply {
    private _class = configName _x;
    private _side = getNumber (_x >> "side");
    [
        _class,
        getText (_x >> "displayName"),
        _sides param [_side, str _side],
        _men getOrDefault [_class, 0],
        _vehicles getOrDefault [_class, 0]
    ]
};
_factions sort true;

diag_log text format ["[cigs][factions] ---- %1 factions ----", count _factions];
diag_log text "[cigs][factions] classname,""displayName"",side,men,vehicles";
{
    _x params ["_class", "_name", "_side", "_m", "_v"];
    // quotes in the display name are doubled so the line stays valid CSV
    diag_log text format ["[cigs][factions] %1,""%2"",%3,%4,%5", _class, _name regexReplace ["""", """"""], _side, _m, _v];
} forEach _factions;
diag_log text format ["[cigs][factions] ---- end: %1 factions, %2 with men ----", count _factions, { _x select 3 > 0 } count _factions];
