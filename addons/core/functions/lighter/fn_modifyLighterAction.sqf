#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Modify the Displayname for the "light your cigarette" action
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

params ["_target", "_player", "_params", "_actionData"];

// Modify the action - index 1 is the display name, 2 is the icon...
_actionData set [
    1,
    format [
        LLSTRING(start_cig_own_custom),
        [_player] call FUNC(getSmokableDisplayName)
    ]
];
