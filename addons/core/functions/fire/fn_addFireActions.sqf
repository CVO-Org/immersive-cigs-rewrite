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

private _action = [
    QPVAR(light_from_fire),
    LLSTRING(light_from_fire),
    QPATHTOF(data\ui\light_cig.paa),
    { call FUNC(lightFromFire) },
    { call FUNC(canLightFromFire) }
] call ace_interact_menu_fnc_createAction;

{
    // Units: on the head, objects: on the object itself
    private _parentPath = if (_x isEqualTo "CAManBase") then { ["ACE_Head"] } else { [] };
    [_x, 0, _parentPath, _action, true] call ace_interact_menu_fnc_addActionToClass;
} forEach ([] call FUNC(getFireSourceClasses));
