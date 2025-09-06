#include "../../script_component.hpp"

/*
* Author: Zorn
* Function for Mission EventHandler EntityCreated.
* Triggered by all Units in the Mission. Both, part of mission.sqm and created through zeus.
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

if (!(_unit isKindOf "CAManBase") || { _unit isKindOf "CBA_NamespaceDummy" || { isPlayer _unit } } ) exitWith {};

[_unit] call FUNC(addToQueue);
