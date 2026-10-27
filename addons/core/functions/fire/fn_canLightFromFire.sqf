#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Condition: can the player light their cigarette at the target.
*
* Arguments:
* 0: Target - fire source <OBJECT>
* 1: Player <OBJECT>
*
* Return Value:
* Can light <BOOL>
*
* Example:
* [_campfire, player] call cigs_core_fnc_canLightFromFire
*
* Public: No
*/

params ["_target", "_player"];

_target isNotEqualTo _player
&&
{ [_player] call FUNC(canStartSmoking) }
&&
{ [_target] call FUNC(isFireSource) }
