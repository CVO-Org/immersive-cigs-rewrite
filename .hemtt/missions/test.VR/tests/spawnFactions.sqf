// AI cigs live test: spawns one unit per faction that has a faction preset, in a row in front of the player.
// They go through the real AI cigs chain (EntityCreated -> queue -> delay -> items). After the delay, the report
// checks that each unit only carries packs that getCigItems allows for it.
// The units can't move, shoot or be hurt, so different sides can stand next to each other.
// Arguments: 0: position to start the row at <ARRAY>, 1: direction of the row <NUMBER>

params [ ["_origin", getPosATL player, [[]]], ["_dir", getDir player, [0]] ];

if (!isServer) exitWith { [_origin, _dir] remoteExec ["cigs_test_fnc_spawnFactions", 2] };

// one unit class per faction
private _classByFaction = createHashMap;
{
    if ( getNumber (_x >> "scope") isEqualTo 2 && { configName _x isKindOf "CAManBase" } ) then {
        private _faction = getText (_x >> "faction");
        if !( _faction in _classByFaction ) then { _classByFaction set [_faction, configName _x] };
    };
} forEach ( "true" configClasses (configFile >> "CfgVehicles") );

// remove the previous row
{ deleteVehicle _x } forEach ( missionNamespace getVariable ["cigs_test_liveUnits", []] );

private _factions = ( "isArray (_x >> 'cigs_packs')" configClasses (configFile >> "CfgFactionClasses") ) apply { configName _x };
_factions pushBack "CIV_F";     // no entry: default presets

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

missionNamespace setVariable ["cigs_test_liveUnits", _units, true];

private _wait = (missionNamespace getVariable ["cigs_ai_set_aiCigs_delay", 5]) + 10;
private _line = format ["Spawned %1 units (one per faction). Report in %2 s.", count _units, _wait];
diag_log text ("[cigs][test] " + _line);
_line remoteExec ["systemChat", 0];

[ { [] call cigs_test_fnc_reportFactions }, [], _wait ] call CBA_fnc_waitAndExecute;
