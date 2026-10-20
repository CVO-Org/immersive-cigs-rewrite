#include "../../script_component.hpp"

/*
* Author: Zorn
* ACE action: the player lights their cigarette at a fire source. Might singe themselves (ACE Fire, combustion chance setting).
*
* Arguments:
* 0: Target - fire source <OBJECT>
* 1: Player <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_campfire, player] call cigs_core_fnc_lightFromFire
*
* Public: No
*/

params ["_target", "_player"];

[_target, _player] call FUNC(lightFromCig);

// Getting too close to the fire - uses the combustion chance setting
if ( isClass (configFile >> "CfgPatches" >> "ace_fire") && { missionNamespace getVariable ["ace_fire_enabled", false] } ) then {
    [ FUNC(combustion_check), [_player], 2 + random 2 ] call CBA_fnc_waitAndExecute;
};
