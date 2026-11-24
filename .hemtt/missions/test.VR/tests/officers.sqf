// Officer presets test: every unit class with cigs_packsExtra[] (the officers of presets_* CfgVehicles.hpp, and the
// classes that inherit from them), for whichever mods are loaded.
//
// 1. Config: the class is still a sound unit - a CAManBase with a faction, a side that matches its faction, a name and
//    a uniform. A wrong parent in OFFICER_CIGARS breaks this. The engine also writes "Updating base class" to the RPT
//    then, which tools\autotest.ps1 reports.
// 2. getCigItems: the cigar box is in the unit's list, on top of its faction's packs.
// 3. Live: one unit of every spawnable class goes through the real chain (EntityCreated -> queue -> items) with the
//    mission's module cleared; it must carry a uniform and only allowed packs. Across all units, some carry cigars.
// Server only, scheduled (it sleeps). Results go to systemChat, the RPT ("[cigs][test]") and a hint.
// Adds its failures to cigs_test_failed, for the autotest run (init.sqf).

if (!isServer) exitWith {};

waitUntil { missionNamespace getVariable ["cba_settings_ready", false] && { !isNil "cigs_aiCigs_default" } };

private _results = [];
private _log = {
    params ["_line"];
    diag_log text ("[cigs][test] " + _line);
    _line remoteExec ["systemChat", 0];
};
private _check = {
    params ["_name", "_ok", ["_detail", ""]];
    _results pushBack [_name, _ok];
    if !( _ok ) then { [format ["FAIL  %1%2", _name, ["", "  - " + _detail] select (_detail isNotEqualTo "")]] call _log; };
};
private _sameSet = {
    params ["_a", "_b"];
    private _sa = _a arrayIntersect _a; _sa sort true;
    private _sb = _b arrayIntersect _b; _sb sort true;
    _sa isEqualTo _sb
};

private _cigars = "cigs_cigars_cigarbox_5";
private _isPack = { getNumber (configFile >> "CfgMagazines" >> _x >> "cigs_isPack") isEqualTo 1 };

["---- Officer presets test ----"] call _log;

// ---------------------------------------------------------------- the classes
private _classes = "isArray (_x >> 'cigs_packsExtra') && { getNumber (_x >> 'scope') > 0 }" configClasses (configFile >> "CfgVehicles");
// set on the class itself (an OFFICER_CIGARS line), not inherited
private _declared = _classes select { !isArray (inheritsFrom _x >> "cigs_packsExtra") };
[format ["%1 classes with cigs_packsExtra[], %2 of them set it themselves", count _classes, count _declared]] call _log;


// ---------------------------------------------------------------- 1. config
{
    private _cfg = _x;
    private _class = configName _cfg;
    private _faction = getText (_cfg >> "faction");
    private _factionCfg = configFile >> "CfgFactionClasses" >> _faction;
    private _uniform = getText (_cfg >> "uniformClass");

    [format ["%1 is a CAManBase", _class], _class isKindOf "CAManBase", "parent " + configName inheritsFrom _cfg] call _check;
    [format ["%1 has a faction", _class], _faction isNotEqualTo "" && { isClass _factionCfg }, str _faction] call _check;
    // only the declared classes: the mods' own variants below them may sit in a faction of another side on purpose
    // (3CB's undercover officers, UK3CB_<X>_<side>_Officer_U)
    if ( _cfg in _declared ) then {
        [format ["%1 side matches its faction", _class], getNumber (_cfg >> "side") isEqualTo getNumber (_factionCfg >> "side"),
            format ["unit %1, faction %2", getNumber (_cfg >> "side"), getNumber (_factionCfg >> "side")]] call _check;
    };
    [format ["%1 has a name", _class], getText (_cfg >> "displayName") isNotEqualTo ""] call _check;
    [format ["%1 has a uniform", _class], _uniform isNotEqualTo "" && { isClass (configFile >> "CfgWeapons" >> _uniform) }, str _uniform] call _check;
    [format ["%1 packsExtra has the cigar box", _class], _cigars in getArray (_cfg >> "cigs_packsExtra"), str getArray (_cfg >> "cigs_packsExtra")] call _check;
} forEach _classes;


// ---------------------------------------------------------------- 2. + 3. live
private _spawnable = _classes select { getNumber (_x >> "scope") isEqualTo 2 } apply { configName _x };

// clear the module for the test, as in liveFactions
private _module = missionNamespace getVariable "cigs_aiCigs_module";
cigs_aiCigs_module = nil;

// one group per side: there are more officers than a side may have groups
private _groups = createHashMap;
private _units = [];
{
    private _side = [east, west, independent, civilian] select ( getNumber (configFile >> "CfgVehicles" >> _x >> "side") min 3 );
    private _group = _groups getOrDefault [str _side, grpNull];
    if ( isNull _group ) then { _group = createGroup [_side, true]; _groups set [str _side, _group]; };
    private _unit = _group createUnit [_x, [-2000 - 3 * (_forEachIndex mod 40), -2000 - 3 * floor (_forEachIndex / 40), 0], [], 0, "CAN_COLLIDE"];
    _unit disableAI "ALL";
    _unit allowDamage false;
    _units pushBack _unit;
} forEach _spawnable;

[format ["Spawned %1 officers, waiting for the AI cigs queue", count _units]] call _log;
private _start = time;
sleep 6;    // the queue starts 5 s after its first unit
waitUntil { sleep 1; isNil "cigs_ai_aiCigs_queue" || { time - _start > 240 } };
sleep ((missionNamespace getVariable ["cigs_ai_set_aiCigs_delay", 5]) + 3);
["queue finished in time", isNil "cigs_ai_aiCigs_queue", format ["still busy after %1 s", round (time - _start)]] call _check;

private _withCigars = 0;
{
    private _unit = _x;
    private _class = typeOf _unit;
    private _allowed = [_unit] call cigs_ai_fnc_getCigItems;
    private _presets = [_unit] call cigs_ai_fnc_getConfigPresets;

    [format ["%1 getCigItems has the cigar box", _class], _cigars in _allowed, str _allowed] call _check;
    if ( "packs" in _presets ) then {
        [format ["%1 getCigItems = its packs + the cigar box", _class], [_allowed, (_presets get "packs") + [_cigars]] call _sameSet, str _allowed] call _check;
    };

    [format ["%1 spawned with a uniform", _class], uniform _unit isNotEqualTo ""] call _check;
    private _carried = ( magazineCargo uniformContainer _unit ) select _isPack;
    private _foreign = _carried select { !(_x in _allowed) };
    [format ["%1 carries only allowed packs", _class], _foreign isEqualTo [], "not allowed: " + str (_foreign arrayIntersect _foreign)] call _check;
    if ( _cigars in _carried ) then { _withCigars = _withCigars + 1; };
} forEach _units;

if ( _units isNotEqualTo [] ) then {
    [format ["some officers carry cigars (%1 of %2)", _withCigars, count _units], _withCigars > 0] call _check;
};

// restore and clean up
missionNamespace setVariable ["cigs_aiCigs_module", _module];
{ deleteVehicle _x } forEach _units;
{ deleteGroup _x } forEach values _groups;

private _failed = _results select { !(_x # 1) };
private _summary = format ["Officer presets test: %1 checks on %2 classes, %3 failed, %4 of %5 spawned officers carry cigars",
    count _results, count _classes, count _failed, _withCigars, count _units];
[_summary] call _log;
_summary remoteExec ["hint", 0];

cigs_test_failed = (missionNamespace getVariable ["cigs_test_failed", 0]) + count _failed;
