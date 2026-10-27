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


// Server only - also called by the CBA setting script, which runs on every machine
if (!isServer) exitWith {};

if ( ! SET(dynamicSmoking_enable) ) exitWith { GVAR(dynamicSmoking_LoopRunning) = nil; };

if (isNil QGVAR(dynamicSmoking_LoopRunning)) then {

    GVAR(dynamicSmoking_LoopRunning) = true;

    // Each start gets a new ID - an older iteration still pending in CBA's queue will see the mismatch and stop
    GVAR(dynamicSmoking_loopID) = GVAR(dynamicSmoking_loopID) + 1;

    // Wait until There are any smokers defined + the aiCigs queue is empty
    [
        {
            GVAR(dynamicSmoking_units) isNotEqualTo []
            &&
            { isNil QGVAR(aiCigs_queue) }
        },
        {
            // Start Cleanup
            GVAR(dynamicSmoking_cleanup_inProgress) = true;
            [] call FUNC(cleanupArray);

            // Wait until the Array Cleanup is done
            [
                { isNil QGVAR(dynamicSmoking_cleanup_inProgress) },
                { [ 0, _this ] call FUNC(loop) },
                _this
            ] call CBA_fnc_waitUntilAndExecute;
        },
        GVAR(dynamicSmoking_loopID)
    ] call CBA_fnc_waitUntilAndExecute;
};
