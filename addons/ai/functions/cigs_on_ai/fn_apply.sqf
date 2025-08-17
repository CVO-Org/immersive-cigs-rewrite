#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add the items to an individual unit
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

if (!SET(cigsonai_enable) || { isNull _unit || { isPlayer _unit } } ) exitWith {};

if ( random 1 > SET(cigsonai_chance) ) exitWith {};

[FUNC(addCigItemsToUnit), [_unit], SET(cigsonai_delay) min 5] call CBA_fnc_waitAndExecute;
