#include "../../script_component.hpp"

/*
* Author: Zorn
* Lights the unit's cigarette from another burning cigarette - no lighter needed.
* Executed where the unit is local.
*
* Arguments:
* 0: Source - unit with the burning cigarette, can be the unit itself <OBJECT>
* 1: Unit lighting its cigarette <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_target, player] call cigs_core_fnc_lightFromCig
*
* Public: No
*/

params ["_source", "_unit"];

if ( !local _unit || { !([_unit] call FUNC(canStartSmoking)) } ) exitWith {};

// Lean in and take a drag
[_unit, QEGVAR(anim,cig_in), 3] call FUNC(anim);
private _sound = selectRandom [QPVAR(smoke_3), QPVAR(smoke_4)];
[ CBA_fnc_globalSay3D, [_unit, _sound, 20, true, false, true], 1 ] call CBA_fnc_waitAndExecute;

[_unit] call FUNC(smoking_start);
