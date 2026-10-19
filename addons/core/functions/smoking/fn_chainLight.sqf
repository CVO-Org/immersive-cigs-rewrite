#include "../../script_component.hpp"

/*
* Author: Zorn
* Lights the unlit cigarette in the other slot from the one the unit is smoking. The current cigarette is put out.
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* None
*
* Example:
* [player] call cigs_core_fnc_chainLight
*
* Public: No
*/

params ["_unit"];

if !([_unit] call FUNC(canChainLight)) exitWith {};

// Put out the current cigarette - without animation, lighting the new one plays its own
[_unit, _unit getVariable QPVAR(loopData), true] call FUNC(loopStop);

// Light the new one from the stub
[_unit, _unit] call FUNC(lightFromCig);
