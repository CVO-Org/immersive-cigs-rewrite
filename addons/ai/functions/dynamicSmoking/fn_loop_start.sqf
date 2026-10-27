#include "..\..\script_component.hpp"

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
                { [ 0 ] call FUNC(loop) }
            ] call CBA_fnc_waitUntilAndExecute;
        }
    ] call CBA_fnc_waitUntilAndExecute;
};
