#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to stop smoking
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_smoking_stop;
*
* Public: No
*/

params [
    "_unit",
    "_loopData",
    [ "_skipAnimation", false, [true] ],
    [ "_forceVanish",   false, [true] ]
];

////////////////////////////////////////
// Animation
////////////////////////////////////////
private _isAwake = lifeState _unit in ["HEALTHY", "INJURED"];
private _isBurning = _unit getVariable ["ace_fire_intensity", 0] > 0;
if ( !_skipAnimation && { _isAwake && (!_isBurning) } ) then { [_unit, QEGVAR(anim,cig_out), 1] call FUNC(anim); };

////////////////////////////////////////
// Uncon
////////////////////////////////////////
// 5% Chance for the unit to keep their cig when getting uncon/dead
if ( !_isAwake && { random 1 > 0.05 } ) exitWith {};

////////////////////////////////////////
// Remove Item
////////////////////////////////////////
private _vanish = switch (true) do {
    case (_forceVanish): { true };
    case (_isBurning): { true };
    case (_isAwake): { selectRandom [false, true] };
    default { false };
};

[_unit, _loopData, _vanish] call FUNC(drop_cig);
