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

private _id = _unit addEventHandler [
    "SlotItemChanged",
    {
        params ["_unit", "_name", "_slot", "_assigned", "_weapon"];

        // Define Remove Eventhandler Codeblock
        private _rm_eh = { _unit removeEventHandler [_thisEvent, _thisEventHandler]; _unit setVariable [QPVAR(SlotItemChanged_EH_ID), nil]; };

        // Check if unit is not consuming
        if ( _unit getVariable [QPVAR(isConsuming), false] isEqualTo false ) exitWith _rm_eh;

        private _loopData = _unit getVariable QPVAR(loopData);

        // Translate Slot Number, Exit if not relevant
        _slot = switch (_slot) do {
            case 603: { "GOGGLES" };
            case 616: { "HMD" };
            default { nil };
        };
        if (isNil "_slot") exitWith {};

        // Get Data
        private _itemType  = _loopData get "itemType";
        private _itemClass = _loopData get "itemClass";

        // Check if the player removed the smoking item
        private _stopConsuming = if (_assigned) then {
            _slot isEqualTo _itemType && { _name isNotEqualTo _itemClass }
        } else {
            _slot isEqualTo _itemType && { _name isEqualTo _itemClass }
        };

        if (_stopConsuming) then {
            _unit setVariable [QPVAR(isConsuming), false, true];
            if (_unit isNil QPVAR(loopData) ) then { _unit setVariable [QPVAR(forceVanish), true]; }; // WTF?
            call _rm_eh;
        };
    }
];

_unit setVariable [QPVAR(SlotItemChanged_EH_ID), _id];
