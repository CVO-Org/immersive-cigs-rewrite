#include "../../script_component.hpp"

/*
* Author: Zorn
* Function that will stop the suck.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_sucking_stop;
*
* Public: No
*/

params ["_unit", "_suckData"];
_unit setVariable [QPVAR(isSucking), false, true];

_unit setVariable [QPVAR(lastConsumed), CBA_missionTime, true];


if (_suckData get "curSucks" > _suckData get "totalSucks") then {
    switch (_suckData get "itemType") do {
        case ("GOGGLES"): { removeGoggles _unit };
        case ("HMD"):     { _unit removeWeapon (_suckData get "itemClass") };
    };
};
