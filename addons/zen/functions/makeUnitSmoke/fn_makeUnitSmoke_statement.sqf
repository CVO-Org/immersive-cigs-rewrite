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


private _cigpack = switch (_return_cigpacks) do {
    case "SIDE": {
        private _map = missionNamespace getVariable [QGVAR(cigsOnAI_hashmap), nil];
        private _package = selectRandom (_map get str side _unit);
        if (isNil "_package") then { _package = QEGVAR(nil,cigpack); };
        _package
    };
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

// Add package and lighter
[QGVAR(EH_addItem), [_unit, _cigpack, true, true], _unit] call CBA_fnc_targetEvent;
[QGVAR(EH_addItem), [_unit, _lighter, true, true], _unit] call CBA_fnc_targetEvent;

[QEGVAR(ai,EH_startConsuming), [_unit, _cigpack, _slot], _unit] call CBA_fnc_targetEvent;

// Add unit to Framework
if (_addToDynamicSmoking) then { [QEGVAR(ai,EH_addUnitToFramework), _unit] call CBA_fnc_serverEvent; };
