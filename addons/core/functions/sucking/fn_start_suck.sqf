#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to start sucking the lollipop
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

[_unit] call FUNC(sucking_start);

