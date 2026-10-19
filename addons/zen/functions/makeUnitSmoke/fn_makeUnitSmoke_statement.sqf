#include "../../script_component.hpp"

/*
* Author: Zorn
* Statement Function which will be executed after confirming the Dialog
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

params ["_return", "_params"];
_return params ["_return_cigpacks", "_return_lighters", "_return_slot", "_addToDynamicSmoking"];
_params params ["_posASL", "_unit"];

// "SIDE" stays as is - resolved on the server, where the package tables exist
private _cigpack = switch (_return_cigpacks) do {
    case "RANDOM": { selectRandom (["PACKAGES"] call EFUNC(core,getAllItems)) };
    default { _return_cigpacks };
};

private _lighter = switch (_return_lighters) do {
    case "RANDOM": { selectRandom (["LIGHTERS"] call EFUNC(core,getAllItems)) };
    default { _return_lighters };
};

private _slot = switch (_return_slot) do {
    case "RANDOM": { selectRandom ["GOGGLES", "HMD"] };
    default { _return_slot };
};

// Finalized on the server
[QGVAR(EH_makeUnitSmoke), [_unit, _cigpack, _lighter, _slot, _addToDynamicSmoking]] call CBA_fnc_serverEvent;

// Info
[ LLSTRING(module_makeUnitSmoke_success) ] call zen_common_fnc_showMessage;
