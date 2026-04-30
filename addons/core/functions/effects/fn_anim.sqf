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

params ["_unit", "_gestureName", "_duration"];

if (!alive _unit) exitWith {};

if (
    !alive _unit || {
    _unit getVariable ["ACE_isUnconscious", false] || {
    _unit getVariable [QEGVAR(api,blockAnimations), false] isEqualTo true
    }}
) exitWith {};

private _oldGesture = gestureState _unit;

private _time = time;
_unit forceWalk true;

private _handle = [
    {
        _this#0 params ["_unit","_gestureName"];
        _unit playActionNow _gestureName;
    },
    0,
    [_unit,_gestureName]
] call CBA_fnc_addPerFrameHandler;

// Removed pfEH
[
    {   // Statement
        params ["_unit", "_gestureName", "_oldGesture", "_handle"];
        [_handle] call CBA_fnc_removePerFrameHandler;
        _unit forceWalk false;
        if (gestureState _unit isNotEqualTo _oldGesture ) then { _unit playActionNow _oldGesture };
    },
    [ _unit, _gestureName, _oldGesture, _handle ],
    0.1 max _duration
] call CBA_fnc_waitAndExecute;
