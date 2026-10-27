#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Itterate over each individual Unit of the SmokerArray and decide if the unit shall smoke and if so, tell it to smoke
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

// Server only - also called by the CBA setting script, which runs on every machine
if (!isServer) exitWith {};

if ( ! SET(dynamicSmoking_enable) ) exitWith { GVAR(dynamicSmoking_LoopRunning) = nil; };

params ["_index", "_loopID"];

// A newer loop has been started - this one is stale and must not touch the shared state
if (_loopID isNotEqualTo GVAR(dynamicSmoking_loopID)) exitWith {};

private _array = GVAR(dynamicSmoking_units);
private _index_end = count _array - 1;
// param instead of select - the array can be replaced by a shorter one (cleanup) while the loop is running
private _unit = _array param [_index, objNull];
private _canConsume = !isNull _unit && { _unit call FUNC(canConsume) };

if ( _canConsume ) then { [QGVAR(EH_startConsuming), _unit, _unit] call CBA_fnc_targetEvent; };

if (_index < _index_end) then {
    // Continue Iterating over the loop
    [ FUNC(loop), [_index + 1, _loopID], LOOP_DELAY ] call CBA_fnc_waitAndExecute;
} else {
    // Restart the loop
    GVAR(dynamicSmoking_LoopRunning) = nil;
    [ FUNC(loop_start), [], LOOP_DELAY_RESTART ] call CBA_fnc_waitAndExecute;
};
