#include "../../script_component.hpp"

/*
* Author: Zorn
* Removes a unit from a magazine. Used by finite lighters, matches or Cigarettes.
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




params ["_unit", "_magazineClass"];

// Create Nested Arrays of Items within the units inventory of desired classname
// magazinesAmmoCargo -> [ ["Classname", ammoCount], ... ]
// _array -> [ [10, "UNIFORM"], [10, "VEST"], [100, "BACKPACK"] ]
private _array = [];
_array append ( magazinesAmmoCargo uniformContainer  _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "UNIFORM"  ] } );
_array append ( magazinesAmmoCargo vestContainer     _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "VEST"     ] } );
_array append ( magazinesAmmoCargo backpackContainer _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "BACKPACK" ] } );

// Put Smallest Magazine in the front
_array = [ _array, [], { _x select 1 }, "ASCEND" ] call BIS_fnc_sortBy;

//Target Container
private _targetContainerType = _array select 0 select 2;

// amount, location
private _targetMagazines = _array select { _x select 2 isEqualTo _targetContainerType } apply { _x select 0 };
private _newMagazineCount = (_targetMagazines#0) -1;

_targetMagazines set [0, _newMagazineCount ];

// Remove old magazines
switch (_targetContainerType) do {
    case "UNIFORM":  { { _unit removeItemFromUniform  _magazineClass } forEach _targetMagazines };
    case "VEST":     { { _unit removeItemFromVest     _magazineClass } forEach _targetMagazines };
    case "BACKPACK": { { _unit removeItemFromBackpack _magazineClass } forEach _targetMagazines };
};

// Filter out Empty Magazines
_targetMagazines = _targetMagazines select { _x select 0 isNotEqualTo 0 };

// Return Magazines
switch (_targetContainerType) do {
    case "UNIFORM":  { { uniformContainer  _unit addMagazineCargoGlobal [_magazineClass, _x] } forEach _targetMagazines };
    case "VEST":     { { vestContainer     _unit addMagazineCargoGlobal [_magazineClass, _x] } forEach _targetMagazines };
    case "BACKPACK": { { backpackContainer _unit addMagazineCargoGlobal [_magazineClass, _x] } forEach _targetMagazines };
};


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
