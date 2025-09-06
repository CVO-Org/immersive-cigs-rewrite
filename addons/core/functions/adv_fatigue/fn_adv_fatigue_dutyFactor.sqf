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
* ['something', player] call cigs_core_fnc_adv_fatigue_dutyFactor;
*
* Public: No
*/

params ["_player"];

linearConversion [
    0,
    250,
    ( _player getVariable [QPVAR(recent_puffs), 0] ) * ( missionNamespace getVariable [QSET(adv_fatigue_modifier), 1] ),
    1,
    2.0,
    true
] // return
