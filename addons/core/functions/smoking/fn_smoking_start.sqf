#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_smoking_start;
*
* Public: No
*/  

params ["_unit"];

private _consumeType = "SMOKE";

[_unit, _consumeType] call FUNC(loopStart);
