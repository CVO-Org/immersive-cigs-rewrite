#include "../../script_component.hpp"

/*
 * Author: commy2, acemod
 * The unit will put its current weapon away.
 *
 * License: https://github.com/acemod/ACE3?tab=License-1-ov-file
 *
 * Arguments:
 * 0: Unit <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [player] call ace_weaponselect_fnc_putWeaponAway
 *
 * Public: Yes
 */

 
params ["_unit"];

_unit action ["SwitchWeapon", _unit, _unit, 299];
