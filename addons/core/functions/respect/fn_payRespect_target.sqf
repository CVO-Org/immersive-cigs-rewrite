#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Puts the cigarette of a player paying respect into the target's goggles/hmd slot.
* Executed where the target is local.
*
* Arguments:
* 0: Target <OBJECT>
* 1: Cigarette classname for the goggles slot <STRING>
* 2: Cigarette classname for the hmd slot <STRING>
*
* Return Value:
* None
*
* Example:
* [QGVAR(EH_payRespect_target), [_target, "cigs_morley_cig2", "cigs_morley_cig2_nv"], _target] call CBA_fnc_targetEvent
*
* Public: No
*/

params ["_target", "_classGoggles", "_classHMD"];

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
        // place the hmd item in the target's inventory or on the ground
        [_target, _hmd, true, true] call CBA_fnc_addItem;
    };
};
