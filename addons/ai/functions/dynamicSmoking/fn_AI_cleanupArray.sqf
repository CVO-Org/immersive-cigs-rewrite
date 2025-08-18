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

private _array = + GVAR(dynamicSmoking_units);

diag_log format ['[CVO](debug)(fn_AI_cleanupArray) _array start: %1', count _array];

if ( _array isEqualTo [] ) exitWith { GVAR(dynamicSmoking_cleanup_inProgress) = nil; diag_log format ['[CVO](debug)(fn_AI_cleanupArray) _array was empty: %1', _array]; };

private _code = {

    params ["_array", "_index", "_indexEnd", "_code"];
    private _unit = _array select _index;

    private _keep = alive _unit && {
        _unit isNil QGVAR(API_dynamicSmoking_blocked)
        && {
            _unit call EFUNC(core,canTakeFromPack)
        }
    };
    if (!_keep) then { _arry set [ _index, nil ]; diag_log format ['[CVO](debug)(fn_AI_cleanupArray) _unit removed: %1', _unit];};

    if (_index isEqualTo _indexEnd ) then {
        GVAR(dynamicSmoking_units) = _array select { ! isNil "_x" };
        GVAR(dynamicSmoking_cleanup_inProgress) = nil;
        diag_log format ['[CVO](debug)(fn_AI_cleanupArray) cleanup done: %1', count GVAR(dynamicSmoking_units) ];
    } else {
        [ _code, [_array, _index + 1, _indexEnd, _code] ] call CBA_fnc_execNextFrame;
    };
};

[ _code, [_array, 0, count _array - 1, _code] ] call CBA_fnc_execNextFrame;
