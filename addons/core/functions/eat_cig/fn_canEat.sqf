#include "../../script_component.hpp"

/*
* Author: Zorn
* Checks if the unit can eat their smokeable/suckable
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


getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1
||
{
    getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSmokable)) == 1
    ||
    {
        getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSuckable)) == 1
        ||
        {
            getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSuckable)) == 1
        }
    }
}
