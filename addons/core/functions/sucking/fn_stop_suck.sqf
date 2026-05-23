#include "../../script_component.hpp"

/*
* Author: Zorn
* Statement of Action to Stop Sucking.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_stop_cig;
*
* Public: No
*/

params ["_unit"];

_unit setVariable [QPVAR(isConsuming), false, true];
