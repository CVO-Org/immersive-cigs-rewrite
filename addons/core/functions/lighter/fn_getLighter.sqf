#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to get the first found Lighter Classname and Type (magazine(finite) or Item(infinite))
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_getLighter;
*
* Public: No
*/

params ["_unit"];


// Check for Finite Lighters - might need to add a bit of code to always use the lighter with the least ammo in it?
private _magazines = magazines _unit;
private _index = _magazines findIf { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isLighter) ) == 1};
if (_index > -1) exitWith { [_magazines select _index, "typeMagazine"] };

// return when no lighter found
[false, false]

/*
// Check for Infinite Lighters
private _items = items _unit;
_index = _items findIf { getNumber (configFile >> "CfgWeapons" >> _x >> QPVAR(isLighter) ) == 1};
if (_index > -1) exitWith { [_items select _index, "typeItem"] };


// The whole "Infinite Lighter" Thing was in preperations for compat items, like the sog:pf cigs.
// Only afterwards i realised that those are also defined as CfgMagazines:harold: - I leave it in for now, just in case
*/
