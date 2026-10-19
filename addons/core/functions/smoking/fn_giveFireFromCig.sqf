#include "../../script_component.hpp"

/*
* Author: Zorn
* ACE action: the player lights the target's cigarette with their own burning cigarette - no lighter needed.
*
* Arguments:
* 0: Target <OBJECT>
* 1: Player - smoking <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_target, player] call cigs_core_fnc_giveFireFromCig
*
* Public: No
*/

params ["_target", "_player"];

[_player, "PutDown", 1.5] call FUNC(anim);

if (isPlayer _target) then { [QGVAR(EH_notify), [format [LLSTRING(gave_fire), name _player], 1], _target] call CBA_fnc_targetEvent; };

// The target lights its cigarette where it is local
[QGVAR(EH_lightFromCig), [_player, _target], _target] call CBA_fnc_targetEvent;
