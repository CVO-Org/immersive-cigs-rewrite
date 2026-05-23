#include "../../script_component.hpp"

/*
* Author: Zorn
* Statement ofAction to Stop Smoking.
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
