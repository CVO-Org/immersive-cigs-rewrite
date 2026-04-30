#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to play an animation
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

params ["_unit", "_gestureAnimation", "_playTimeSeconds"];

if (!alive _unit) exitWith {};

if ( _unit getVariable [QEGVAR(api,blockAnimations), false] isEqualTo true ) exitWith {};

if (_unit getVariable ["ACE_isUnconscious", false]) exitWith {};

private _time = time;
_unit forceWalk true;

// Adds pfEH
private _code = {
    _this#0 params ["_unit","_gestureAnimation"];
    _unit playActionNow _gestureAnimation;
};
private _handle = [_code, 0, [_unit,_gestureAnimation]] call CBA_fnc_addPerFrameHandler;

// Removed pfEH
private _condition = {
    params ["_unit", "_handle","_time","_playTimeSeconds"];
    time > _time + _playTimeSeconds;
};

private _code = {
    params ["_unit", "_handle","_time","_playTimeSeconds"];
    [_handle] call CBA_fnc_removePerFrameHandler;
    _unit forceWalk false;
};

[_condition, _code, [_unit, _handle,_time, _playTimeSeconds]] call CBA_fnc_waitUntilAndExecute;
