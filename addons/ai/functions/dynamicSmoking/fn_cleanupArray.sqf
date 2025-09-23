#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to cleanup the Unit Array
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

private _array = GVAR(dynamicSmoking_units);

if ( _array isEqualTo [] ) exitWith { GVAR(dynamicSmoking_cleanup_inProgress) = nil; };

private _code = {
    params ["_array", "_index", "_code"];
    private _unit = _array select _index;

    private _keep = _unit call FUNC(cleanupArray_condition);

    if (!_keep) then {
        _array set [ _index, nil ];
    };

    // Continue with the Cleanup
    if (_index isNotEqualTo (count _array - 1) ) then { [ _code, [_array, _index + 1, _code] ] call CBA_fnc_execNextFrame; } else {
        // Stop the Cleanup
        _array = _array select { ! isNil "_x" };
        GVAR(dynamicSmoking_cleanup_inProgress) = nil;
    };
}; 

[ _code, [_array, 0, _code] ] call CBA_fnc_execNextFrame;
