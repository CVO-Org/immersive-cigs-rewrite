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


 _unit getVariable [QPVAR(isConsuming), false] isEqualTo false
&&
{
    ( [_unit] call EFUNC(core,checkCompatibleSkeleton) )
    &&
    {
        ( getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSuckable)) == 1 )
        ||
        {
            ( getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSuckable)) == 1 )
        }
    }
}
