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




params ["_unit", "_magazineClass", "_slot"];

diag_log format ['[CVO](debug)(fn_removeItemFromMag) _this: %1', _this];

// Create Nested Arrays of Items within the units inventory of desired classname
// magazinesAmmoCargo -> [ ["Classname", ammoCount], ... ]
// _array -> [ [10, "UNIFORM"], [10, "VEST"], [100, "BACKPACK"] ]
private _array = [];
_array append ( magazinesAmmoCargo uniformContainer  _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "UNIFORM_CONTAINER"  ] } );
_array append ( magazinesAmmoCargo vestContainer     _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "VEST_CONTAINER"     ] } );
_array append ( magazinesAmmoCargo backpackContainer _unit select { _x#0 isEqualTo _magazineClass } apply { [ _x#1, "BACKPACK_CONTAINER" ] } );

// Put Smallest Magazine in the front
_array = [ _array, [], { _x select 0 }, "ASCEND" ] call BIS_fnc_sortBy;


diag_log format ['[CVO](debug)(fn_removeItemFromMag) _array: %1', _array];
diag_log format ['[CVO](debug)(fn_removeItemFromMag) isNil "_slot": %1', isNil "_slot"];

//Target Container
private _targetContainerType = [_slot, _array select 0 select 1] select (isNil "_slot");

diag_log format ['[CVO](debug)(fn_removeItemFromMag) _targetContainerType: %1', _targetContainerType];

// amount
private _targetMagazines = _array select { _x select 1 isEqualTo _targetContainerType } apply { _x select 0 };

private _newMagazineCount = (_targetMagazines#0) -1;

_targetMagazines set [0, _newMagazineCount ];

// Remove old magazines
switch (_targetContainerType) do {
    case "UNIFORM_CONTAINER":  { { _unit removeItemFromUniform  _magazineClass } forEach _targetMagazines };
    case "VEST_CONTAINER":     { { _unit removeItemFromVest     _magazineClass } forEach _targetMagazines };
    case "BACKPACK_CONTAINER": { { _unit removeItemFromBackpack _magazineClass } forEach _targetMagazines };
};

// Filter out Empty Magazines
_targetMagazines = _targetMagazines select { _x isNotEqualTo 0 };

// Return Magazines
switch (_targetContainerType) do {
    case "UNIFORM_CONTAINER":  { { uniformContainer  _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
    case "VEST_CONTAINER":     { { vestContainer     _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
    case "BACKPACK_CONTAINER": { { backpackContainer _unit addMagazineAmmoCargo [_magazineClass, 1, _x] } forEach _targetMagazines };
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
