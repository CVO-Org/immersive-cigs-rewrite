#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to set the unit aleart
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

params ["_group", "_instigator"];

_group setBehaviour  "COMBAT";

private _leader = leader _group;
_leader reveal [_instigator, (_leader knowsAbout _instigator) + 0.1];
