#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to be used for advanced fatuige
*
* Arguments:
*
* Return Value:
* Duty Factor as Number
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params ["_enable"];

if (! isClass (configFile >> "CfgPatches" >> "ace_advanced_fatigue") ) exitWith {};

if (_enable) then {
    [QADDON, FUNC(adv_fatigue_dutyFactor)] call ace_advanced_fatigue_fnc_addDutyFactor;
} else {
    [QADDON] call ace_advanced_fatigue_fnc_removeDutyFactor;
};
