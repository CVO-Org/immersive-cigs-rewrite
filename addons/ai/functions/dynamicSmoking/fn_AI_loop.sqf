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

params [ "_array" ];

diag_log format ['[CVO](debug)(fn_AI_loop) count _array: %1', count _array];

private _random = random 1;
diag_log format ['[CVO](debug)(fn_AI_loop) _random: %1', _random];

private _unit = _array deleteAt (floor random count _array);

private _canConsume = _unit call FUNC(AI_canConsume);

if ( _canConsume ) then { _unit call FUNC(AI_startConsuming) };


if (_array isNotEqualTo []) then {
    
    // Continue Iterating over the loop
    [
        FUNC(AI_loop),
        [_array],
        1
    ] call CBA_fnc_waitAndExecute;
};
