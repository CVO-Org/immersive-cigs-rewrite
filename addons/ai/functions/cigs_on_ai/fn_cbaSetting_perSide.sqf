#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add a setting for all packages per side.
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

params [
    ["_side", nil, [west] ]
];

if (isNil "_side") exitWith {false};

{ [_x, _side] call FUNC(cbaSetting_addSetting) } forEach ( ["PACKAGES", true] call EFUNC(core,getAllItems) );

true
