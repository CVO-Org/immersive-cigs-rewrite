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

if ( _array isEqualTo [] ) exitWith {};

private _code = {

    params ["_array", "_index", "_indexEnd", "_code"];
    private _unit = _array select _index;

    private _keep = alive _unit
    &&
    {
        _unit isNil QGVAR(dynamicSmoking_blocked)
        &&
        {
            _unit call EFUNC(core,canTakeFromPack)
        }
    };

    if (!_keep) then { _arry set [ _index, nil ]; };

    if (_index isEqualTo _indexEnd ) then {
        GVAR(dynamicSmoking_units) = _array select { ! isNil "_x" };
        GVAR(dynamicSmoking_cleanup_inProgress) = nil;
    } else {
        [ _code, [_array, _index + 1, _indexEnd, _code] ] call CBA_fnc_execNextFrame;
    };
};

[ _code, [_array, 0, count _array - 1, _code] ] call CBA_fnc_execNextFrame;
