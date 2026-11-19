// AI cigs: checks which packs a unit gets from which level (cigs_ai_fnc_getCigItems).
// Spawns one unit per faction far away, asks getCigItems directly and compares with the expected packs.
// Every level is switched on and off through its variable, and restored afterwards.
// Server only. Results go to systemChat, the RPT ("[cigs][test]") and a hint.
//
// Order under test, highest first:
// cigs_aiCigs_api > module > pack selection > cigs_aiCigs_api_lesser > faction presets > default presets

if (!isServer) exitWith {};

waitUntil { missionNamespace getVariable ["cba_settings_ready", false] && { !isNil "cigs_aiCigs_default" } };
sleep 5;

private _results = [];

private _log = {
    params ["_line"];
    diag_log text ("[cigs][test] " + _line);
    systemChat _line;
};

private _sameSet = {
    params ["_a", "_b"];
    private _sa = +_a; _sa sort true;
    private _sb = +_b; _sb sort true;
    _sa isEqualTo _sb
};

private _check = {
    params ["_name", "_got", "_expected"];
    private _ok = [_got, _expected] call _sameSet;
    _results pushBack [_name, _ok];
    [format ["%1  %2%3", ["FAIL", "PASS"] select _ok, _name, ["  - got " + str _got + ", expected " + str _expected, ""] select _ok]] call _log;
};


// ---------------------------------------------------------------- one unit class per faction
private _classByFaction = createHashMap;
{
    if ( getNumber (_x >> "scope") isEqualTo 2 && { configName _x isKindOf "CAManBase" } ) then {
        private _faction = getText (_x >> "faction");
        if !( _faction in _classByFaction ) then { _classByFaction set [_faction, configName _x] };
    };
} forEach ( "true" configClasses (configFile >> "CfgVehicles") );

private _spawned = [];
private _spawn = {
    params ["_faction"];
    private _class = _classByFaction getOrDefault [_faction, ""];
    if ( _class isEqualTo "" ) exitWith { objNull };
    private _side = [east, west, independent, civilian] select ( getNumber (configFile >> "CfgFactionClasses" >> _faction >> "side") );
    private _group = createGroup [_side, true];
    private _unit = _group createUnit [_class, [-2000, -2000, 0], [], 0, "CAN_COLLIDE"];
    _unit setVariable ["cigs_api_blockAiCigs", true];
    _unit enableSimulationGlobal false;
    _spawned pushBack _unit;
    _unit
};

private _factionPacks = { params ["_faction"]; getArray (configFile >> "CfgFactionClasses" >> _faction >> "cigs_packs") };
private _defaultPacks = { params ["_sideStr"]; cigs_aiCigs_default getOrDefault [_sideStr, []] };
private _packs = { params ["_unit"]; [_unit] call cigs_ai_fnc_getCigItems };


// ---------------------------------------------------------------- levels: save, reset, restore
// Script variables (api, module, lesser API) are set directly.
// CBA settings go through CBA_settings_fnc_set ("server" source, as in init.sqf), so their change scripts run too:
// the pack selection's script clears its cached map (cigs_aiCigs_settings), which the tests rely on.
private _packSelVar = "cigs_ai_set_aiCigs_packSelection_WEST_cigs_morley_cigpack";
private _scriptVars = [ "cigs_aiCigs_api", "cigs_aiCigs_module", "cigs_aiCigs_api_lesser" ];
private _settings = [ "cigs_ai_set_aiCigs_packSelection_enable", "cigs_ai_set_aiCigs_configPresets_enable", _packSelVar ];

private _savedVars = _scriptVars apply { missionNamespace getVariable _x };
private _savedSettings = _settings apply { [_x, "server"] call CBA_settings_fnc_get };

private _set = { params ["_setting", "_value"]; [_setting, _value, nil, "server"] call CBA_settings_fnc_set };

private _reset = {
    cigs_aiCigs_api = nil;
    cigs_aiCigs_module = nil;
    cigs_aiCigs_api_lesser = nil;
    ["cigs_ai_set_aiCigs_packSelection_enable", false] call _set;
    ["cigs_ai_set_aiCigs_configPresets_enable", true] call _set;
    [_packSelVar, false] call _set;
};

["---- AI cigs preset tests ----"] call _log;
call _reset;

private _blu = ["BLU_F"] call _spawn;
private _opf = ["OPF_F"] call _spawn;
private _civ = ["CIV_F"] call _spawn;


// ---------------------------------------------------------------- 1. faction presets of every faction that has one
// Also catches typos and brands that aren't loaded: getConfigPresets drops those, so the lists would differ.
{
    private _faction = configName _x;
    private _unit = [_faction] call _spawn;
    if ( isNull _unit ) then {
        [format ["SKIP  faction preset %1 - no unit class with this faction", _faction]] call _log;
    } else {
        [format ["faction preset %1", _faction], [_unit] call _packs, [_faction] call _factionPacks] call _check;
    };
} forEach ( "isArray (_x >> 'cigs_packs')" configClasses (configFile >> "CfgFactionClasses") );

// ---------------------------------------------------------------- 2. no entry: default presets
["CIV_F has no entry -> default presets", [_civ] call _packs, ["CIV"] call _defaultPacks] call _check;

// ---------------------------------------------------------------- 3. Use Faction Presets off
call _reset;
["cigs_ai_set_aiCigs_configPresets_enable", false] call _set;
["faction presets off -> default presets (WEST)", [_blu] call _packs, ["WEST"] call _defaultPacks] call _check;

// ---------------------------------------------------------------- 4. lesser API as hashmap - decides all sides
call _reset;
cigs_aiCigs_api_lesser = createHashMapFromArray [["WEST", ["cigs_nil_cigpack"]]];
["lesser hashmap: WEST from the map", [_blu] call _packs, ["cigs_nil_cigpack"]] call _check;
["lesser hashmap: EAST missing -> none", [_opf] call _packs, []] call _check;

// ---------------------------------------------------------------- 5. lesser API as code - nil hands the unit down
call _reset;
cigs_aiCigs_api_lesser = { params ["_unit"]; if ( side group _unit isEqualTo west ) then { ["cigs_voron_cigpack"] } else { nil } };
["lesser code: array for WEST", [_blu] call _packs, ["cigs_voron_cigpack"]] call _check;
["lesser code: nil -> faction preset (OPF_F)", [_opf] call _packs, ["OPF_F"] call _factionPacks] call _check;

call _reset;
cigs_aiCigs_api_lesser = { [] };
["lesser code: [] -> none", [_blu] call _packs, []] call _check;

// ---------------------------------------------------------------- 6. lesser API of a wrong type is ignored (logs an error)
call _reset;
cigs_aiCigs_api_lesser = "oops";
["lesser wrong type -> ignored, faction preset", [_blu] call _packs, ["BLU_F"] call _factionPacks] call _check;

// ---------------------------------------------------------------- 7. pack selection beats the lesser API
call _reset;
cigs_aiCigs_api_lesser = createHashMapFromArray [["WEST", ["cigs_nil_cigpack"]], ["EAST", ["cigs_nil_cigpack"]]];
["cigs_ai_set_aiCigs_packSelection_enable", true] call _set;
[_packSelVar, true] call _set;
["pack selection: WEST ticked Morley", [_blu] call _packs, ["cigs_morley_cigpack"]] call _check;
["pack selection: EAST nothing ticked -> none", [_opf] call _packs, []] call _check;

// the change script clears the cached map, so unticking shows at once
[_packSelVar, false] call _set;
["pack selection: Morley unticked again -> none (cache cleared)", [_blu] call _packs, []] call _check;
[_packSelVar, true] call _set;

// ---------------------------------------------------------------- 8. module beats the pack selection
cigs_aiCigs_module = createHashMapFromArray [["WEST", ["cigs_kosmos_cigpack"]], ["EAST", []], ["GUER", []], ["CIV", []]];
["module beats pack selection", [_blu] call _packs, ["cigs_kosmos_cigpack"]] call _check;

// ---------------------------------------------------------------- 9. cigs_aiCigs_api beats everything
cigs_aiCigs_api = createHashMapFromArray [["WEST", ["cigs_pops_poppack"]]];
["api beats module", [_blu] call _packs, ["cigs_pops_poppack"]] call _check;

// ---------------------------------------------------------------- 10. vanilla factions define no lighters
call _reset;
["no cigs_lighters[] on BLU_F", keys ([_blu] call cigs_ai_fnc_getConfigPresets), ["packs"]] call _check;


// ---------------------------------------------------------------- restore and clean up
{ missionNamespace setVariable [_x, _savedVars # _forEachIndex] } forEach _scriptVars;
{ [_x, _savedSettings # _forEachIndex] call _set } forEach _settings;
{ deleteVehicle _x } forEach _spawned;

private _failed = _results select { !(_x # 1) };
private _summary = format ["AI cigs preset tests: %1 passed, %2 failed", count _results - count _failed, count _failed];
[_summary] call _log;
if ( _failed isNotEqualTo [] ) then { ["Failed: " + (( _failed apply { _x # 0 }) joinString ", ")] call _log; };
[_summary] remoteExec ["hint", 0];
