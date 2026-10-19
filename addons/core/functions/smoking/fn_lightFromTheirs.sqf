#include "../../script_component.hpp"

/*
* Author: Zorn
* ACE action: the player lights their cigarette from the target's burning cigarette.
*
* Arguments:
* 0: Target - smoking <OBJECT>
* 1: Player <OBJECT>
*
* Return Value:
* None
*
* Example:
* [_target, player] call cigs_core_fnc_lightFromTheirs
*
* Public: No
*/

params ["_target", "_player"];

if (isPlayer _target) then { [QGVAR(EH_notify), [format [LLSTRING(lit_from_yours), name _player], 1], _target] call CBA_fnc_targetEvent; };

[_target, _player] call FUNC(lightFromCig);
