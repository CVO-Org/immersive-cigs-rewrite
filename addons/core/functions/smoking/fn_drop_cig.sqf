#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to handle the removing/dropping of the cig.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_drop_cig;
*
* Public: No
*/

params [ "_unit", "_loopData", ["_vanish", true, [false]] ];

if (isNil "_loopData") then { _loopData = _unit getVariable QPVAR(loopData); };

private _className = _loopData get "itemClass";

// The player moved the cigarette out of its slot, or swapped something else in (#295):
// it's already in the inventory or on the ground. Don't remove what's in the slot now, and don't drop a copy.
private _itemType = _loopData get "itemType";
private _inSlot = switch (_itemType) do {
    case ("GOGGLES"): { goggles _unit isEqualTo _className };
    case ("HMD"):     { hmd _unit isEqualTo _className };
    default { false };
};
if (!_inSlot) exitWith {};

////////////////////////////////////////
// Remove Item
////////////////////////////////////////
switch (_itemType) do {
    case ("GOGGLES"): { removeGoggles _unit; };
    case ("HMD"):     { _unit removeWeapon _className; };
};

if (_vanish) exitWith {};

////////////////////////////////////////
// Drop Item on Floor
////////////////////////////////////////

// Find Nearby or create WeaponHolder
private _weaponHolder = getPos _unit nearObjects ["WeaponHolder", 1];
if (_weaponHolder isEqualTo []) then {
    _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
    _weaponHolder setPosASL getPosASL _unit;
} else {
    _weaponHolder = selectRandom _weaponHolder;
};

// Add Item
_weaponHolder addItemCargoGlobal [_className, 1];

