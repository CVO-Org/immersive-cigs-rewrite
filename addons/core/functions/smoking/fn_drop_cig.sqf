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

params [ "_unit", "_smokeData", ["_vanish", true, [false]] ];

if (isNil "_smokeData") then { _unit getVariable [QPVAR(smokeData)] };

private _className = _smokeData get "itemClass";

switch (_smokeData get "itemType") do {
    case ("GOGGLES"): { removeGoggles _unit; };
    case ("HMD"):     { _unit removeWeapon _className; };
};

if (_vanish) exitWith {};

// Put Cigarette on the floor
private _weaponHolder = getPos _unit nearObjects ["WeaponHolder", 2];

if (_weaponHolder isEqualTo []) then {
    _weaponHolder = createVehicle ["GroundWeaponHolder", [0,0,0], [], 0, "NONE"];
    _weaponHolder setPosASL getPosASL _unit;
} else {
    _weaponHolder = selectRandom _weaponHolder;
};

_weaponHolder addItemCargoGlobal [_className, 1];
