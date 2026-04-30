#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Checks and handles returning the AI's item, which has been put in their inventory to make space for the cigarette.
*
* Arguments:
* 0: _unit <OBJECT>
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params [ "_unit" ];

private _data = _unit getVariable QEGVAR(ai,dynSmoke_storedItem);

if (isNil "_data") exitWith {};

_unit setVariable [QEGVAR(ai,dynSmoke_storedItem), nil, true];

_data params [ "_className", "_slot"];

if !( [_unit, _className] call CBA_fnc_removeItem ) exitWith {};

switch (_slot) do {
    case "GOGGLES": { _unit addGoggles _className; };
    case "HMD": { _unit linkItem _className; };
};
