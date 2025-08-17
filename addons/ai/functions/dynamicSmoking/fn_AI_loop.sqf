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

private _unit = _array deleteAt (floor random count _array);

private _canConsume = _unit call FUNC(AI_canConsume);

if ( _canConsume ) then {  };


if (_array isEqualTo []) then {

    // restart the loop
    [ FUNC(AI_loop_start), nil, 60 ] call CBA_fnc_waitAndExecute;

} else {
    
    // Continue Iterating over the loop
    [
        FUNC(AI_loop),
        [_array],
        [10, 60] select _canConsume
    ] call CBA_fnc_waitAndExecute;

};
