#include "../../script_component.hpp"

/*
* Author: Zorn
* Checks if the unit can start smoking
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_canStartSmoking;
*
* Public: No
*/

params ["_unit"];


!(_unit getVariable [QPVAR(isSmoking), false])
&& 
{
    !(_unit getVariable [QPVAR(isSucking), false])
    &&
    {
        ([_unit] call EFUNC(core,checkCompatibleSkeleton))
        &&
        {
            getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1
            ||
            {
                getNumber (configFile >> "CfgWeapons" >> hmd _unit >> QPVAR(isSmokable)) == 1
            }
        }
    }
}
