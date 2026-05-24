#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to pay respect to a fallen/uncon comrade. Will put players cigarette into the targets goggles/hmd slot.
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

params ["_target", "_player"];

private _lookData = _player getVariable QPVAR(loopData);

private _class = _lookData get "itemClass";
private _itemType = _lookData get "itemType";

switch (_itemType) do {
    case "GOGGLES": { removeGoggles _player; };
    case "HMD": { _player removeWeapon _class; };
};

[_player, _lookData, true, true] call FUNC(smoking_stop);

switch (_itemType) do {
    case "GOGGLES": { [ _class, _class + "_nv" ] };
    case "HMD": {  [ _class trim ["_nv", 2], _class ] };
} params ["_classGoggles", "_classHMD"];


switch (true) do {
    case (goggles _target isEqualTo ""): {
        // place player cig type in goggles slot
        _target addGoggles _classGoggles;
    };
    case (hmd _target isEqualTo ""): {
        // place player cig type in hmd slot
        _target addWeapon _classHMD;
    };
    default {
        // rm hmd slot item
        private _hmd = hmd _target;
        _target removeWeapon _hmd;
        // add cig to tgt
        _target addWeapon _classHMD;
        // place it in unit inventory or ground
        [_player, _hmd, true, true] call CBA_fnc_addItem;
    };
};
