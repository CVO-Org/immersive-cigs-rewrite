#include "../../script_component.hpp"

/*
* Author: Zorn
* Event Handler Function, Triggered by ace_refuel_started
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

ZRN_LOG_1(_this);

params ["_unit"];

if (isNil "_unit" || { SET(effect_combustion_chance) isEqualTo 0 } ) exitWith {};

private _random = random 1;
private _chance = _random <= SET(effect_combustion_chance);

ZRN_LOG_2(_random,_chance);

if ( _unit getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE" && { _chance } ) then {
    
    ZRN_LOG_1(_chance);

    [_unit] call FUNC(combustion_do);

};
