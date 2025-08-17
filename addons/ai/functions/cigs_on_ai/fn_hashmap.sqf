#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to create the hashmap and add/remove entries.
* Key: side as string
* Value: Array of classnames
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

params ["_sideStr", "_className", "_action"];

private _map = missionNamespace getVariable [QGVAR(cigsOnAI_hashmap), createHashMap];

private _array = _map getOrDefault [_sideStr, [], true];

switch (_action) do {
    case true:  { _array pushBackUnique _className };
    case false: { _array = _array - [_className] };
};

missionNamespace setVariable [QGVAR(cigsOnAI_hashmap), _map];
