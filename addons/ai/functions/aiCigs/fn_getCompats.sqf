#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the active compat presets: the functions of the cigs_ai_compats entries whose condition is met, highest priority first.
* Read from configFile (mods) and missionConfigFile (missions, gamemodes). A mission entry replaces a mod entry of the same name.
* Resolved on the first call of the mission and kept in cigs_ai_compatFunctions, as the conditions can depend on the mission.
*
* An entry:
* class cigs_ai_compats {
*     class MyCompat {
*         priority = 0;                          // Optional - higher is asked first
*         condition = "!isNil 'my_active'";      // Optional - SQF, needs to return a BOOL
*         function = "my_fnc_getPresets";        // Name of the function
*     };
* };
*
* The function gets [_unit] and returns:
* - nil: not its unit. The next compat is asked, then the unit class and faction presets.
* - HASHMAP with "packs", "lighters" and / or "packsExtra" (classnames): the presets of the unit.
*   An empty hashmap, or one without "packs", skips the unit class and faction presets: the unit goes on to the terrain presets.
* See cigs_ai_fnc_getConfigPresets.
*
* Arguments:
* None
*
* Return Value:
* Functions <ARRAY of CODE>
*
* Example:
* [] call cigs_ai_fnc_getCompats
*
* Public: No
*/

private _functions = missionNamespace getVariable QGVAR(compatFunctions);
if ( !isNil "_functions" ) exitWith { _functions };

private _entries = createHashMap;
{
    { _entries set [ toLowerANSI configName _x, _x ]; } forEach ( "true" configClasses ( _x >> QGVAR(compats) ) );
} forEach [ configFile, missionConfigFile ];

private _active = values _entries select {
    private _condition = getText ( _x >> "condition" );
    private _result = if ( _condition isEqualTo "" ) then { true } else { call compile _condition };
    if !( _result isEqualType true ) then {
        ERROR_2("cigs_ai_compats >> %1: condition must return a BOOL - got %2 - ignored",configName _x,_result);
        _result = false;
    };
    _result
};

_active = [ _active, [], { getNumber ( _x >> "priority" ) }, "DESCEND" ] call BIS_fnc_sortBy;

_functions = [];
{
    private _name = getText ( _x >> "function" );
    private _code = missionNamespace getVariable _name;
    if ( isNil "_code" || { !( _code isEqualType {} ) } ) then {
        ERROR_2("cigs_ai_compats >> %1: function %2 is not defined - ignored",configName _x,_name);
    } else {
        INFO_2("Compat presets active: %1 (%2)",configName _x,_name);
        _functions pushBack _code;
    };
} forEach _active;

GVAR(compatFunctions) = _functions;

_functions
