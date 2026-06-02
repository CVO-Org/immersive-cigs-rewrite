#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to initialize the spikedCig-Effect
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

params ["_unit", "_loopData", "_intensity", "_sfxParams"];
// _sfxParams params ["_something"];


private _startLoop = _unit getVariable [QPVAR(spikedLoop), false];
private _spikedConsumes = _unit getVariable [QPVAR(spikedConsumes), 0];

_unit setVariable [QPVAR(spikedConsumes), _spikedConsumes + _intensity];

// Initialize Effect Loop
if (_startLoop) then {
    _unit setVariable [QPVAR(spikedLoop), _startLoop];

    raise
};
