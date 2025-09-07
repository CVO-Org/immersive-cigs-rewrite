#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to make an AI unit start smoking
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

params [ "_unit", "_package", "_slot" ];

diag_log format ['[CVO](debug)(fn_AI_startConsuming) _unit: %1', _unit];

if ( (_unit call EFUNC(core,isPlayer)) || { ! local _unit } ) exitWith {};

// Check if unit has Cigarette Pack
if !( _unit call EFUNC(core,canTakeFromPack) ) exitWith {};

// Check if face or hmd slot is free

private _curGlasses = goggles _unit;
private _curHMD = hmd _unit;

if (isNil "_slot") then { _slot = SET(dynamicSmoking_slot) };

switch (true) do {
    case (_curGlasses isEqualTo ""): { ["GOGGLES", false] };
    case (_curHMD     isEqualTo ""): { ["HMD", false] };
    default { [_slot, true] };
} params ["_targetSlot", "_needsRemoval"];


// If setting is to not remove any item but it the targetslot is blocked, exit
if ( _needsRemoval && { !SET(dynamicSmoking_slot_remove) } ) exitWith {};

// Handle Rnadom
if (_targetSlot isEqualTo "RANDOM") then { _targetSlot = selectRandom ["GOGGLES", "HMD"]; };

diag_log format ['[CVO](debug)(fn_startConsuming) _targetSlot: %1', _targetSlot];

// remove and store current goggles/hmd item
private _storedItem = if (_needsRemoval) then {
    switch (_targetSlot) do {
        case "GOGGLES": {
            removeGoggles _unit;
            [_curGlasses, "GOGGLES"]

        };
        case "HMD": {
            _unit unlinkItem _curHMD;
            [_curHMD, "HMD"]
        };
    };

    [_unit, _storedItem#0] call CBA_fnc_addItem;
    
    _unit setVariable [QGVAR(dynSmoke_storedItem), _storedItem, true];
};

if (isNil "_package") then { _package = selectRandom (magazines _unit select { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isPack)) == 1}) };

// Take item from package
[
    _unit,
    _package
] call EFUNC(core,takeFromPack);


// Start consumption
switch (true) do {
    case (_unit call EFUNC(core,canStartSmoking)): { [QGVAR(eh_startCig),  _unit ] call CBA_fnc_localEvent; };
    case (_unit call EFUNC(core,canStartSucking)): { [QGVAR(eh_startSuck), _unit ] call CBA_fnc_localEvent; };
};
