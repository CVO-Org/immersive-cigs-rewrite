#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to check if the user has a lighter
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [_unit] call cigs_core_fnc_hasLighter;
*
* Public: No
*/

params ["_unit"];

_return = switch (true) do {
    case (magazines _unit findIf { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isLighter) ) == 1}  >= 0): { true };     //   finite lighter
    case (    items _unit findIf { getNumber (configFile >> "CfgWeapons"   >> _x >> QPVAR(isLighter) ) == 1}  >= 0): { true };     // infinite lighter
    default { false };
};
_return
