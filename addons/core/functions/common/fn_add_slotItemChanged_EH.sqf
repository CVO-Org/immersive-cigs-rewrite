#include "../../script_component.hpp"

/*
* Author: Zorn
* FNC to handle the SlotItemChanged Event Handler
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

_unit addEventHandler [
    "SlotItemChanged",
    {
        params ["_unit", "_name", "_slot", "_assigned", "_weapon"];

	    private _rm_eh = { _unit removeEventHandler [_thisEvent, _thisEventHandler]; };

        private _isSmoking = _unit getVariable [QPVAR(isSmoking), false];
        if !( _isSmoking || { _unit getVariable [QPVAR(isSucking), false] } ) exitWith _rm_eh;

        [
            [QPVAR(isSucking), QPVAR(suckData)],
            [QPVAR(isSmoking), QPVAR(smokeData)]
        ]  select _isSmoking params ["_isConsumingVarName", "_dataVarName"];

        // Translate Slot Number, Exit if not relevant
        _slot = switch (_slot) do {
            case 603: { "GOGGLES" };
            case 616: { "HMD" };
            default { nil };
        };
        if (isNil "_slot") exitWith {};

        // Get Data
        private _data = _unit getVariable _dataVarName;
        private _itemType  = _data get "itemType";
        private _itemClass = _data get "itemClass";

        // Check if the player removed the smoking item
        private _stopSmoking = if (_assigned) then {
            _slot isEqualTo _itemType && { _name isNotEqualTo _itemClass }
        } else {
            _slot isEqualTo _itemType && { _name isEqualTo _itemClass }
        };

        if (_stopSmoking) then { _unit setVariable [_isConsumingVarName, false, true]; call _rm_eh };
    }
];
