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

params ["_array", "_index", "_indexEnd"];

private _next = { [ FUNC(AI_loop), [_array, _index + 1, _indexEnd], 10 ] call CBA_fnc_waitAndExecute; };

private _unit = _array select _index;

private _canSmoke = _unit call FUNC(AI_canSmoke);

// TODO Continue