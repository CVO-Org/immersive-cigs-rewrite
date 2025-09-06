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

if ( isNull _unit || { _unit call EFUNC(core,isPlayer) } ) exitWith {};



if ( !SET(cigsonai_enable) ) exitWith {};
if ( random 1 < SET(cigsonai_chance) ) then { [FUNC(addCigItemsToUnit), [_unit], SET(cigsonai_delay) max 5] call CBA_fnc_waitAndExecute; };


