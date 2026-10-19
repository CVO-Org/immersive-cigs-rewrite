#include "../../script_component.hpp"

/*
* Author: Zorn
* Condition: can the player light the target's cigarette with their own burning cigarette.
*
* Arguments:
* 0: Target <OBJECT>
* 1: Player <OBJECT>
*
* Return Value:
* Can light <BOOL>
*
* Example:
* [_target, player] call cigs_core_fnc_canGiveFireFromCig
*
* Public: No
*/

params ["_target", "_player"];

_player getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE"
&&
{ [_target] call FUNC(canStartSmoking) }
