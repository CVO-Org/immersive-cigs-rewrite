// Faction dump - runs when the mission is opened in Eden (init3den.sqf), once per game session.
// Lists every CfgFactionClasses entry with its displayName, side and the number of units in it,
// to build/check the faction presets. Meant for the "factions" launch profile (vanilla + all CDLCs):
//     hemtt launch factions
// Units = CfgVehicles classes with scope 2 (placeable in the editor) that are men (CAManBase).
// Output goes to the RPT, one line per faction, between the BEGIN / END markers:
//     [cigs][factions] <class>;<displayName>;<side>;<units>
// To run it again in the same session: uiNamespace setVariable ["cigs_test_factionDump_done", nil]; then reopen the mission.

if ( uiNamespace getVariable ["cigs_test_factionDump_done", false] ) exitWith {};
uiNamespace setVariable ["cigs_test_factionDump_done", true];

// units per faction
private _unitsByFaction = createHashMap;
{
    if ( getNumber (_x >> "scope") isEqualTo 2 && { configName _x isKindOf "CAManBase" } ) then {
        private _faction = getText (_x >> "faction");
        _unitsByFaction set [_faction, (_unitsByFaction getOrDefault [_faction, 0]) + 1];
    };
} forEach ( "true" configClasses (configFile >> "CfgVehicles") );

private _sideNames = ["EAST", "WEST", "GUER", "CIV"];
private _rows = ( "true" configClasses (configFile >> "CfgFactionClasses") ) apply {
    private _side = getNumber (_x >> "side");
    [
        configName _x,
        getText (_x >> "displayName"),
        if ( _side >= 0 && { _side < count _sideNames } ) then { _sideNames select _side } else { str _side },
        _unitsByFaction getOrDefault [configName _x, 0]
    ]
};

// factions that units use but that have no CfgFactionClasses entry
{
    private _faction = _x;
    if ( _rows findIf { (_x select 0) == _faction } isEqualTo -1 ) then { _rows pushBack [_faction, "<no CfgFactionClasses entry>", "?", _y] };
} forEach _unitsByFaction;

_rows sort true;

private _withUnits = { (_x select 3) > 0 } count _rows;
private _total = 0;
{ _total = _total + _y } forEach _unitsByFaction;
diag_log text format ["[cigs][factions] BEGIN - %1 factions, %2 with units, %3 units", count _rows, _withUnits, _total];
diag_log text "[cigs][factions] class;displayName;side;units";
{
    _x params ["_class", "_name", "_side", "_count"];
    diag_log text format ["[cigs][factions] %1;%2;%3;%4", _class, _name, _side, _count];
} forEach _rows;
diag_log text "[cigs][factions] END";

systemChat format ["[cigs] Faction dump written to the RPT: %1 factions, %2 with units", count _rows, _withUnits];
