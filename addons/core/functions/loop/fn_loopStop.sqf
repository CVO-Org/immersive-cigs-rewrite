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

ZRN_LOG_1(_this);

params [
    "_unit",
    "_loopData",
    [ "_skipAnimation", false, [true] ],
    [ "_forceVanish",   false, [true] ]
];

private _consumeType = _loopData get "consumeType";

////////////////////////////////////////
// Flag and Data
////////////////////////////////////////
_unit setVariable [QPVAR(isConsuming), false, true];
_unit setVariable [QPVAR(loopData), nil];


////////////////////////////////////////
// AI
////////////////////////////////////////
[_unit] call EFUNC(ai,returnItemToSlot);
if (! isPlayer _unit) then { _unit call EFUNC(AI,updateCanConsumeAgain); };

////////////////////////////////////////
// Type Dependent Changes
////////////////////////////////////////

switch (_consumeType) do {
    case "SMOKE": { [_unit, _loopData, _skipAnimation, _forceVanish] call FUNC(smoking_stop) };
    case "SUCK": { [_unit, _loopData] call FUNC(sucking_stop) };
};


////////////////////////////////////////
// API
////////////////////////////////////////
switch (_consumeType) do {
    case "SMOKE": { [QEGVAR(api,stopsSmoking), [_unit, _loopData]] call CBA_fnc_localEvent; };
    case "SUCK": {  [QEGVAR(api,stopsSucking), [_unit, _loopData]] call CBA_fnc_localEvent;  };
};
