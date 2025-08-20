#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Itterate over each individual Unit of the Array and decide if the unit shall smoke and if so, its gonna do it
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

if ( ! SET(dynamicSmoking_enable) ) exitWith { GVAR(dynamicSmoking_LoopRunning) = nil; };

params ["_index"];

private _array = GVAR(dynamicSmoking_units);

private _index_end = count _array - 1;

private _unit = _array select _index;

private _canConsume = _unit call FUNC(canConsume);

diag_log format ['[CVO](debug)(fn_loop) %1/%2 - _canConsume: %3', _index , _index_end ,_canConsume];

if ( _canConsume ) then { [QGVAR(EH_startConsuming), _unit, _unit] call CBA_fnc_targetEvent; };

if (_index isNotEqualTo _index_end) then {
    // Continue Iterating over the loop
    [ FUNC(loop), [_index + 1], LOOP_DELAY ] call CBA_fnc_waitAndExecute;
} else {
    // Restart the loop
    GVAR(dynamicSmoking_LoopRunning) = nil;
    [ FUNC(loop_start), [], LOOP_DELAY_RESTART ] call CBA_fnc_waitAndExecute;
};
