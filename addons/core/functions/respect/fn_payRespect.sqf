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

// Stop smoking - removes the cigarette without animation and without dropping it
[_player, _lookData, true, true] call FUNC(loopStop);

switch (_itemType) do {
    case "GOGGLES": { [ _class, _class + "_nv" ] };
    case "HMD": {  [ _class trim ["_nv", 2], _class ] };
} params ["_classGoggles", "_classHMD"];

// Place the cigarette on the target - where the target is local, as the inventory commands need a local unit
[QGVAR(EH_payRespect_target), [_target, _classGoggles, _classHMD], _target] call CBA_fnc_targetEvent;

_target setVariable [QPVAR(respectPayed), true, true];

////////////////////////////////////////
// Effects
////////////////////////////////////////
[
    {
        params ["_target", "_player"];
        // Sound Effect
        private _sound = selectRandom [QPVAR(smoke_3),QPVAR(smoke_4)];
        [_target, _sound, 20, true, false, true, true] call CBA_fnc_globalSay3d;

        // Light Effect
        [QGVAR(EH_light_cig_glow), [_target, _sound]] call CBA_fnc_globalEvent;

        // Smoke Particles
        [ CBA_fnc_globalEvent, [QGVAR(EH_smoke_effect), [_target, nil, 1, true]], 2.5 ] call CBA_fnc_waitAndExecute;
    },
    _this,
    3
] call CBA_fnc_waitAndExecute;



////////////////////////////////////////
// API 
////////////////////////////////////////
[QEGVAR(api,respectPayed),  [_player, _target]] call CBA_fnc_localEvent;
