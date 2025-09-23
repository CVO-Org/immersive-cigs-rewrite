#include "../../script_component.hpp"

/*
* Author: Zorn
* Removes a "bullet" from a magazine. Used by lighters, matches or packages.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/




params ["_unit", "_magazineClass", "_slot"];

// Create Nested Arrays of "magazines" within the units inventory of desired classname
// magazinesAmmoCargo -> [ ["Classname", ammoCount], ... ]
// gets reduced to [ [10, "UNIFORM"], [10, "VEST"], [100, "BACKPACK"] ]
private _array = [];
_array append ( magazinesAmmoCargo uniformContainer  _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "UNIFORM_CONTAINER"  ] } );
_array append ( magazinesAmmoCargo vestContainer     _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "VEST_CONTAINER"     ] } );
_array append ( magazinesAmmoCargo backpackContainer _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "BACKPACK_CONTAINER" ] } );

// Put Smallest Magazine in the front
_array = [ _array, [], { _x select 0 }, "ASCEND" ] call BIS_fnc_sortBy;

//Identify Target Container - Ether via Params or by selecting where the smallest magazine is.
private _targetContainerType = [_slot, _array select 0 select 1] select (isNil "_slot");

// Filter based on Target Container and reduce to Array o Ammo Counts
private _targetMagazines = _array select { _x select 1 isEqualTo _targetContainerType } apply { _x select 0 };

// Remove 1 "bullet" from smallest Entry
private _newMagazineCount = (_targetMagazines#0) -1;

// Update Smallest Entry
_targetMagazines set [0, _newMagazineCount ];

// Remove old magazines
switch (_targetContainerType) do {
    case "UNIFORM_CONTAINER":  { { _unit removeItemFromUniform  _magazineClass } forEach _targetMagazines };
    case "VEST_CONTAINER":     { { _unit removeItemFromVest     _magazineClass } forEach _targetMagazines };
    case "BACKPACK_CONTAINER": { { _unit removeItemFromBackpack _magazineClass } forEach _targetMagazines };
};

// Remove Entries which Empty Magazines
_targetMagazines = _targetMagazines select { _x isNotEqualTo 0 };

// Return Magazines
switch (_targetContainerType) do {
    case "UNIFORM_CONTAINER":  { { uniformContainer  _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
    case "VEST_CONTAINER":     { { vestContainer     _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
    case "BACKPACK_CONTAINER": { { backpackContainer _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
};

// Notify Players that they used up their "magazine"
if (
    _newMagazineCount isEqualTo 0
    &&
    {
        getNumber (configFile >> "CfgMagazines" >> _magazineClass >> "count") > 1
        &&
        {
            _unit call EFUNC(core,isPlayer)
        }
    }
) then { [QGVAR(EH_notify), [format [LLSTRING(is_Empty), getText (configFile >> "CfgMagazines" >> _magazineClass >> "displayName")], 1]] call CBA_fnc_localEvent; };
