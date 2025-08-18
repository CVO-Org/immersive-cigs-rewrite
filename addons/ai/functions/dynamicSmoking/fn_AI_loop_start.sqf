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

diag_log format ['[CVO](debug)(fn_AI_loop_start) SET(dynamicSmoking_enable): %1', SET(dynamicSmoking_enable)];

private _statement = {

    GVAR(dynamicSmoking_isWaiting) = nil;

    private _startPFH = {

        private _codeToRun = {
            GVAR(dynamicSmoking_cleanup_inProgress) = true;
            [] call FUNC(AI_cleanupArray);

            [
                { isNil QGVAR(dynamicSmoking_cleanup_inProgress) },
                {
                private _array = + GVAR(dynamicSmoking_units);
                diag_log format ['[CVO](debug)(fn_AI_loop_start) count _array: %1', count _array];
                [ _array ] call FUNC(AI_loop);
                }
            ] call CBA_fnc_waitUntilAndExecute;
        };

        private _condition = { SET(dynamicSmoking_enable) };
        private _exitCode =  { GVAR(dynamicSmoking_PFH_ID) = nil };

        GVAR(dynamicSmoking_PFH_ID) = [{
            params ["_args", "_handle"];
            _args params ["_codeToRun", "_parameters", "_exitCode", "_condition"];

            if (_parameters call _condition) then {
                _parameters call _codeToRun;
            } else {
                _handle call CBA_fnc_removePerFrameHandler;
                _parameters call _exitCode;
            };
        }, 300, [_codeToRun, [], _exitCode, _condition]] call CBA_fnc_addPerFrameHandler;

    };

    switch (true) do {
        case (     SET(dynamicSmoking_enable)   && {   isNil QGVAR(dynamicSmoking_PFH_ID) } ): { call _startPFH };
        case ( ( ! SET(dynamicSmoking_enable) ) && { ! isNil QGVAR(dynamicSmoking_PFH_ID) } ): { GVAR(dynamicSmoking_PFH_ID) call CBA_fnc_removePerFrameHandler };
    };

};


if (isNil QGVAR(dynamicSmoking_isWaiting)) then {
    GVAR(dynamicSmoking_isWaiting) = true;
    [{ GVAR(dynamicSmoking_units) isNotEqualTo [] && { isNil QGVAR(cigsonai_queue) } }, _statement] call CBA_fnc_waitUntilAndExecute;
};

