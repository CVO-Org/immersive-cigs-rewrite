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

params ["_unit"];

if !(local _unit) exitWith {};
if (isPlayer _unit) exitWith {};

// Check if unit has Cigarette Pack
if !( _unit call EFUNC(core,canTakeFromPack) ) exitWith {};

// Check if face or hmd slot is free

private _curGlasses = goggles _unit;
private _curHMD = hmd _unit;

private _targetSlot = switch (true) do {
    case (_curGlasses isEqualTo ""): { ["GOGGLES", false] };
    case (_curHMD     isEqualTo ""): { ["HMD", false] };
    default { [QSET(dynamicSmoking_slot), true] };
};

// If setting is to not remove any item but it the targetslot is blocked, exit
if !(SET(dynamicSmoking_remove) || { _targetSlot#1 } ) exitWith {};

if (_targetSlot select 0 isEqualTo "RANDOM") then { _targetSlot set [ 0, selectRandom ["GOGGLES", "HMD"] ] };

// remove and store current goggles/hmd item
private _storedItem = if (_targetSlot#1) then {
    switch (_targetSlot#1) do {
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

// Take cig from package
private _cigPack = selectRandom (magazines _unit select { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isPack)) == 1});
[_unit, _ciPack] call EFUNC(core,take_from_pack);

// Start the smoking loop 
[ EFUNC(core,start_cig), [_unit, true], random 5 ] call CBA_fnc_waitAndExecute;