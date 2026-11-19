// AI cigs live test: one unit per faction that has a faction preset (plus a civilian) goes through the real chain:
// EntityCreated -> queue -> delay -> items. Afterwards each unit's packs are checked against what getCigItems allows,
// and the report says which level decided.
// The mission's Configure AI Cigs module (level 2) would win over the faction presets, so it is cleared for the
// duration of the test and restored afterwards. The units can't move, shoot or be hurt; they are deleted at the end.
// Server only, scheduled (it sleeps). Results go to systemChat, the RPT ("[cigs][test]") and a hint.

if (!isServer) exitWith {};

private _log = {
    params ["_line"];
    diag_log text ("[cigs][test] " + _line);
    _line remoteExec ["systemChat", 0];
};

// Which level decides for a unit - mirrors cigs_ai_fnc_getCigItems
private _level = {
    params ["_unit"];
    switch (true) do {
        case ( !isNil "cigs_aiCigs_api" ): { "api" };
        case ( !isNil "cigs_aiCigs_module" ): { "module" };
        case ( missionNamespace getVariable ["cigs_ai_set_aiCigs_packSelection_enable", false] ): { "pack selection" };
        case ( !isNil "cigs_aiCigs_api_lesser" ): { "lesser api" };
        case ( missionNamespace getVariable ["cigs_ai_set_aiCigs_configPresets_enable", true] && { "packs" in ([_unit] call cigs_ai_fnc_getConfigPresets) } ): { "faction preset" };
        default { "default preset" };
    };
};

// one unit class per faction
private _classByFaction = createHashMap;
{
    if ( getNumber (_x >> "scope") isEqualTo 2 && { configName _x isKindOf "CAManBase" } ) then {
        private _faction = getText (_x >> "faction");
        if !( _faction in _classByFaction ) then { _classByFaction set [_faction, configName _x] };
    };
} forEach ( "true" configClasses (configFile >> "CfgVehicles") );

private _factions = ( "isArray (_x >> 'cigs_packs')" configClasses (configFile >> "CfgFactionClasses") ) apply { configName _x };
_factions pushBack "CIV_F";     // no entry: default presets

// clear the module for the test
private _module = missionNamespace getVariable "cigs_aiCigs_module";
cigs_aiCigs_module = nil;

["---- AI cigs live test ----"] call _log;

// a row in front of the player (or the map centre without one)
private _origin = if ( isNull player ) then { [worldSize / 2, worldSize / 2, 0] } else { getPosATL player };
private _dir = if ( isNull player ) then { 0 } else { getDir player };

private _units = [];
{
    private _class = _classByFaction getOrDefault [_x, ""];
    if ( _class isNotEqualTo "" ) then {
        private _side = [east, west, independent, civilian] select ( getNumber (configFile >> "CfgFactionClasses" >> _x >> "side") );
        private _pos = _origin getPos [6, _dir] getPos [3 * (_forEachIndex - count _factions / 2), _dir + 90];
        private _unit = (createGroup [_side, true]) createUnit [_class, _pos, [], 0, "CAN_COLLIDE"];
        _unit setDir (_dir + 180);
        _unit disableAI "ALL";
        _unit allowDamage false;
        _unit setVariable ["cigs_test_faction", _x, true];
        _units pushBack _unit;
    };
} forEach _factions;

private _wait = (missionNamespace getVariable ["cigs_ai_set_aiCigs_delay", 5]) + 10;
[format ["Spawned %1 units (one per faction), report in %2 s", count _units, _wait]] call _log;
sleep _wait;

// report
private _isPack = { getNumber (configFile >> "CfgMagazines" >> _x >> "cigs_isPack") isEqualTo 1 };
private _failed = 0;
private _empty = 0;
{
    private _unit = _x;
    private _carried = ( magazineCargo uniformContainer _unit ) select _isPack;
    _carried = _carried arrayIntersect _carried;
    private _allowed = [_unit] call cigs_ai_fnc_getCigItems;
    private _foreign = _carried select { !(_x in _allowed) };
    private _result = switch (true) do {
        case ( _carried isEqualTo [] ): { _empty = _empty + 1; "NONE" };
        case ( _foreign isNotEqualTo [] ): { _failed = _failed + 1; "FAIL" };
        default { "PASS" };
    };
    [format ["%1  %2 (%3) [%4]: %5%6",
        _result,
        _unit getVariable ["cigs_test_faction", faction _unit],
        typeOf _unit,
        [_unit] call _level,
        _carried,
        ["", "  - not allowed: " + str _foreign] select (_foreign isNotEqualTo [])
    ]] call _log;
} forEach _units;

// restore and clean up
missionNamespace setVariable ["cigs_aiCigs_module", _module];
{ deleteVehicle _x } forEach _units;

private _summary = format ["AI cigs live test: %1 units, %2 failed, %3 without packs", count _units, _failed, _empty];
[_summary] call _log;
_summary remoteExec ["hint", 0];
