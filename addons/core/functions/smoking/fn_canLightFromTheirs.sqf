#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Condition: can the player light their cigarette from the target's burning cigarette.
*
* Arguments:
* 0: Target <OBJECT>
* 1: Player <OBJECT>
*
* Return Value:
* Can light <BOOL>
*
* Example:
* [_target, player] call cigs_core_fnc_canLightFromTheirs
*
* Public: No
*/

params ["_target", "_player"];

_target getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE"
&&
{ [_player] call FUNC(canStartSmoking) }
