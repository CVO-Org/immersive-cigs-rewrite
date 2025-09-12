#include "../../script_component.hpp"

/*
* Author: Zorn
* Conditioncheck to see if the player can start sucking their lollipop or whatever
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


!(_unit getVariable [QPVAR(isSucking), false])
&& 
{
    !(_unit getVariable [QPVAR(isSmoking), false])
    &&
    {
        getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSuckable)) == 1
        ||
        {
            getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSuckable)) == 1
        }
        &&
        [_unit] call EFUNC(core,checkCompatibleSkeleton)
    }
}
