#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

params ["_posASL", "_unit"];

if  ( isNull _unit                    ) exitWith { [ LLSTRING(module_makeUnitSmoke_noUnit)   ] call zen_common_fnc_showMessage; };
if !( _unit isKindOf "CAManBase"      ) exitWith { [ LLSTRING(module_makeUnitSmoke_notUnit)  ] call zen_common_fnc_showMessage; };
if  ( _unit call EFUNC(core,isPlayer) ) exitWith { [ LLSTRING(module_makeUnitSmoke_player)   ] call zen_common_fnc_showMessage; };
if !( alive _unit                     ) exitWith { [ LLSTRING(module_makeUnitSmoke_notAlive) ] call zen_common_fnc_showMessage; };

private _isSmoking = _unit getVariable [QPVAR(isSmoking), false];
private _isSucking = _unit getVariable [QPVAR(isSucking), false];

if ( (!_isSmoking) && { !_isSucking } ) exitWith { [ LLSTRING(module_stopUnitSmoke_notConsuming) ] call zen_common_fnc_showMessage; };

switch (true) do {
    case (_isSmoking): {
        _unit setVariable [QPVAR(isSmoking), false, true];
        [ LLSTRING(module_stopUnitSmoke_stoppedSmoking) ] call zen_common_fnc_showMessage;
    };
    case (_isSucking): {
        _unit setVariable [QPVAR(isSucking), false, true];
        [ LLSTRING(module_stopUnitSmoke_stoppedSucking) ] call zen_common_fnc_showMessage;
    };
};
