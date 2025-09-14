#include "../../script_component.hpp"

/*
* Author: Zorn
* FNC to get displayName of smokable
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_getSmokableDisplayName
*
* Public: No
*/

params [ "_unit" ];

switch (true) do {
    case (getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1): { getText (configFile >> "CfgGlasses" >> goggles _unit >> "displayName") };
    case (getNumber (configFile >> "CfgWeapons" >>     hmd _unit >> QPVAR(isSmokable)) == 1): { getText (configFile >> "CfgWeapons" >>     hmd _unit >> "displayName") };
    default { "" };
}
