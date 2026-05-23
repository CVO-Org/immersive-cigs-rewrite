#include "../script_component.hpp"

/*
* Author: Zorn
* This function creates an Custom ACE Arsenal Tab for the Userfacing Items (Packages and Lighters) of the Mod.
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
    ["_value",        true,         [true]       ]
];


if (_value) then {
    private _isEnabled = missionNamespace getVariable [QPVAR(isEstablished_aceTab), false];

    if (!_isEnabled) then {
        missionNamespace setVariable [QPVAR(isEstablished_aceTab), true];

        [
            [] call FUNC(getAllItems),
            "Immersion Cigs",
            QPATHTOF(data\ui\light_cig.paa) // Image Path
        ] call ace_arsenal_fnc_addRightPanelButton
    };
};
