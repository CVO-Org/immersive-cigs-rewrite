#include "../../script_component.hpp"

/*
* Author: Zorn
* Condition Function to pay respect to a fallen/uncon comrade.
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

params ["_target", "_player"];

_player getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE"
&&
{
    !(lifeState _target in ["HEALTHY", "INJURED"])
}
