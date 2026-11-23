#include "..\..\script_component.hpp"

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

params ["_unit", "_loopData"];

////////////////////////////////////////
// Remove Item
////////////////////////////////////////
// Only when it's still in its slot: the player may have swapped something else in (#295)
private _itemClass = _loopData get "itemClass";
if (_loopData get "curConsumes" > _loopData get "totalConsumes") then {
    switch (_loopData get "itemType") do {
        case ("GOGGLES"): { if (goggles _unit isEqualTo _itemClass) then { removeGoggles _unit }; };
        case ("HMD"):     { if (hmd _unit isEqualTo _itemClass) then { _unit removeWeapon _itemClass }; };
    };
};

