#include "../../script_component.hpp"

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

// Check if the unit has had their cigarette removed from the slot (SlotChangedEH)
if ( _unit getVariable [QGVAR(forceVanish), false] ) then { _vanish = true; _unit setVariable [QGVAR(forceVanish), nil]; };

////////////////////////////////////////
// Remove Item
////////////////////////////////////////
switch (_loopData get "itemType") do {
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

