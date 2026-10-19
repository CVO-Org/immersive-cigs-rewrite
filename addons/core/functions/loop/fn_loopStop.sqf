#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to stop the Loop
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_loopStop;
*
* Public: No
*/

params [
    "_unit",
    "_loopData",
    [ "_skipAnimation", false, [true] ],
    [ "_forceVanish",   false, [true] ]
];

// Already stopped - e.g. stopped directly while the loop was still waiting
if (isNil { _unit getVariable QPVAR(loopData) }) exitWith {};

private _consumeType = _loopData get "consumeType";

////////////////////////////////////////
// Flag and Data
////////////////////////////////////////
_unit setVariable [QPVAR(isConsuming), false, true];
_unit setVariable [QPVAR(loopData), nil];


////////////////////////////////////////
// Type Dependent Changes
////////////////////////////////////////

switch (_consumeType) do {
    case "SMOKE": { [_unit, _loopData, _skipAnimation, _forceVanish] call FUNC(smoking_stop) };
    case "SUCK": { [_unit, _loopData] call FUNC(sucking_stop) };
};

////////////////////////////////////////
// AI
////////////////////////////////////////
// After the item has been removed, otherwise removing the item would also remove the returned slot item
[_unit] call EFUNC(ai,returnItemToSlot);
if (! isPlayer _unit) then { _unit call EFUNC(AI,updateCanConsumeAgain); };


////////////////////////////////////////
// API
////////////////////////////////////////
switch (_consumeType) do {
    case "SMOKE": { [QEGVAR(api,stopsSmoking), [_unit, _loopData]] call CBA_fnc_localEvent; };
    case "SUCK": {  [QEGVAR(api,stopsSucking), [_unit, _loopData]] call CBA_fnc_localEvent;  };
};
