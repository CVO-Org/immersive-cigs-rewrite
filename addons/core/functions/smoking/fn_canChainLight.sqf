#include "../../script_component.hpp"

/*
* Author: Zorn
* Condition: is the unit smoking and has an unlit cigarette in the other slot (goggles/hmd).
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* Can chain light <BOOL>
*
* Example:
* [player] call cigs_core_fnc_canChainLight
*
* Public: No
*/

params ["_unit"];

private _loopData = _unit getVariable QPVAR(loopData);

_unit getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE"
&&
{ !isNil "_loopData" }
&&
{
    switch (_loopData get "itemType") do {
        case "GOGGLES": { getNumber (configFile >> "CfgWeapons" >> hmd _unit     >> QPVAR(isSmokable)) == 1 };
        case "HMD":     { getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1 };
        default         { false };
    }
}
