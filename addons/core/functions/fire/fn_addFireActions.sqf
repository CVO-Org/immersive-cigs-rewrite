#include "../../script_component.hpp"

/*
* Author: Zorn
* Adds the ACE action to light a cigarette at fire sources (fireplaces, marked objects, burning units). Players only.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* [] call cigs_core_fnc_addFireActions
*
* Public: No
*/

if ( !hasInterface || { !isClass (configFile >> "CfgPatches" >> "ace_interact_menu") } ) exitWith {};

private _fnc_createAction = {
    params ["_name", "_displayName"];
    [
        _name,
        _displayName,
        QPATHTOF(data\ui\light_cig.paa),
        { call FUNC(lightFromFire) },
        { call FUNC(canLightFromFire) }
    ] call ace_interact_menu_fnc_createAction
};

private _actionFire = [QPVAR(light_from_fire), LLSTRING(light_from_fire)] call _fnc_createAction;
private _actionBody = [QPVAR(light_from_body), LLSTRING(light_from_body)] call _fnc_createAction;

{
    if (_x isEqualTo "CAManBase") then {
        // Burning units - in the main interaction menu
        [_x, 0, ["ACE_MainActions"], _actionBody, true] call ace_interact_menu_fnc_addActionToClass;
    } else {
        // Fire sources - on the object itself
        [_x, 0, [], _actionFire, true] call ace_interact_menu_fnc_addActionToClass;
    };
} forEach ([] call FUNC(getFireSourceClasses));
