#include "../../script_component.hpp"

/*
* Author: Zorn
* Condition Check if the player can stop the suck
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

_unit getVariable [QPVAR(isConsuming), false] isEqualTo "SUCK"
&& 
{
    getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSuckable)) == 1
    ||
    {
        getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSuckable)) == 1
    }
}
