#include "../../script_component.hpp"

/*
* Author: Zorn
* Function that will initiate the Recursive Sucking
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

params ["_unit"];

private _consumeType = "SUCK";

[_unit, _consumeType] call FUNC(loopStart);
