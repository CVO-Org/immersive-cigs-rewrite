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

ZRN_LOG_1(_this);

params ["_unit", "_loopData"];

////////////////////////////////////////
// Remove Item
////////////////////////////////////////
if (_loopData get "curConsumes" > _loopData get "totalConsumes") then {
    switch (_loopData get "itemType") do {
        case ("GOGGLES"): { removeGoggles _unit };
        case ("HMD"):     { _unit removeWeapon (_loopData get "itemClass") };
    };
};

