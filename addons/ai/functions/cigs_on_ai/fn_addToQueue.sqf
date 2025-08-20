#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle all the units that need to be iterated over. adds them to a queue and waits for cba settings to be initialised.
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


params ["_unit"];

private _code = {

    params ["_unit"];

    private _counter = missionNamespace getVariable [QGVAR(counter_cigsonai), 0];
    _counter = _counter + 1;
    missionNamespace setVariable [QGVAR(counter_cigsonai), _counter];
    diag_log format ['[CVO](debug)(fn_addToQueue) GVAR(counter_cigsonai): %1', GVAR(counter_cigsonai)];

    if (isNull _unit || {isPlayer _unit}) exitWith {};

    private _queue = missionNamespace getVariable [QGVAR(cigsonai_queue), nil];
    private _startPFEH = false;

    if (isNil "_queue") then {
        _queue = [];
        missionNamespace setVariable [QGVAR(cigsonai_queue), _queue];
        _startPFEH = true;
    };

    _queue pushBack _unit;

    if (_startPFEH) then {
        [
            {
                [
                    {
                        missionNamespace getVariable ["cba_settings_ready", false]
                    },
                    {
                        
                        
                        [
                            {
                                params ["_args", "_handle"];

                                private _queue = missionNamespace getVariable [QGVAR(cigsonai_queue), nil];
                                if (isNil "_queue") exitWith { _handle call CBA_fnc_removePerFrameHandler; };

                                [_queue deleteAt 0] call FUNC(apply);

                                if (count _queue == 0) then { missionNamespace setVariable [QGVAR(cigsonai_queue), nil]; };
                            },
                            0.1,
                            []
                        ] call CBA_fnc_addPerFrameHandler;
                    }
                ] call CBA_fnc_waitUntilAndExecute;
            },
            [],
            5
        ] call CBA_fnc_waitAndExecute;  // without, this will clear the queue within one frame because the PFEH will run initially on creation
    };
};

if (missionNamespace getVariable ["cba_settings_ready",false]) then _code else { ["CBA_settingsInitialized",_code,[_unit]] call CBA_fnc_addEventHandler; };
