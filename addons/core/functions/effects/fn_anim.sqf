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

if (
    !alive _unit || {
    _unit getVariable ["ACE_isUnconscious", false] || {
    _unit getVariable [QEGVAR(api,blockAnimations), false] isEqualTo true
    }}
) exitWith {};

private _oldGesture = gestureState _unit;

private _time = time;
// ACE status effects keep track of other mods forcing walk (carrying, overweight, ...)
private _aceLoaded = isClass (configFile >> "CfgPatches" >> "ace_common");
if (_aceLoaded) then { [_unit, "forceWalk", QPVAR(anim), true] call ace_common_fnc_statusEffect_set } else { _unit forceWalk true };

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
        if (isClass (configFile >> "CfgPatches" >> "ace_common")) then { [_unit, "forceWalk", QPVAR(anim), false] call ace_common_fnc_statusEffect_set } else { _unit forceWalk false };
        if (gestureState _unit isNotEqualTo _oldGesture ) then { _unit playActionNow _oldGesture };
    },
    [ _unit, _gestureName, _oldGesture, _handle ],
    0.1 max _duration
] call CBA_fnc_waitAndExecute;
