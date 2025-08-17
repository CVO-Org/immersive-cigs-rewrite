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


GVAR(dynamicSmoking_cleanup_inProgress) = true;
call FUNC(AI_cleanupArray);

[
    {
        isNil QGVAR(dynamicSmoking_cleanup_inProgress)
    },
    {
        [ + GVAR(dynamicSmoking_units) ] call FUNC(AI_loop);
    }
] call CBA_fnc_waitUntilAndExecute;
