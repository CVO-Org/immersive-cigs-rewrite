#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function create/adjust/destroy the the effects over time
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

params [ "_intensity", [ "_duration", 30, [0] ] ];


if (!hasInterface) exitWith {};

///////////////////////////
// Sanitize Inputs
///////////////////////////
_intensity = 0 max _intensity min 1;
_duration = 0.1 max _duration min 30;


///////////////////////////
// Handle Individual Effects
///////////////////////////
{
    private _effectName = _x;
    private _variableNameID = [QADDON, "id", _effectName] joinString "_";
    private _id = missionNamespace getVariable _variableNameID;

    ZRN_LOG_4(_effectName,_variableNameID,_id,_intensity);

    if ( isNil "_id" && { _intensity isEqualTo 0 } ) then { ZRN_LOG_MSG(skip); continue };

    ///////////////////////////
    // Create Effect
    ///////////////////////////
    if ( isNil "_id" ) then {
        private _effectPriority = switch (_effectName) do {
            case "RadialBlur":      {  100 };
            case "ChromAberration": {  200 };
            case "WetDistortion":   {  300 };
            case "ColorInversion":  { 2500 };
            default { 0 };
        };
        diag_log format ['[CVO](debug)(fn_spikedEffectAdjust) _effectName: %1 - _effectPriority: %2', _effectName , _effectPriority];
        _id = ppEffectCreate [ _effectName, _effectPriority ];
        _id ppEffectEnable true;
        _id ppEffectAdjust ( [_effectName] call FUNC(getPPEffectArray) );
        _id ppEffectCommit 0;

        missionNamespace setVariable [ _variableNameID, _id ];
        ZRN_LOG_1(_id);
    };

    ///////////////////////////
    // Get Adjustment Array
    ///////////////////////////
    // 1. Array for intensity  > 0
    // 2. Array for intensity == 0

    private _effectArray = [_effectName, _intensity] call FUNC(getPPEffectArray);

    ZRN_LOG_1(_effectArray);

    if (_effectArray isEqualTo []) then { continue };

    ///////////////////////////
    // Get Handle Edgecases
    ///////////////////////////
    private _individualDuration = _duration;
    switch (_effectName) do {
        case "WetDistortion": { _individualDuration = 10 max _duration; };
    };

    ///////////////////////////
    // Apply the Effect
    ///////////////////////////
    _id ppEffectAdjust _effectArray;
    _id ppEffectCommit _individualDuration;

    ZRN_LOG_1(_individualDuration);


    ///////////////////////////
    // Cleanup
    ///////////////////////////
    // Wait duration to destroy and nil GVARs
    if (_intensity isEqualTo 0) then {
        private _variableNameIDDestroy = [QADDON, "destroy", _effectName] joinString "_";
        if (isNil _variableNameIDDestroy) then {
            [
                CBA_fnc_waitUntilAndExecute,
                [
                    {
                        CBA_missionTime > (missionNamespace getVariable [_this#0, 0])
                    },
                    {
                        private _id = missionNamespace getVariable (_this#1);
                        if !(isNil "_id") then {
                            ppEffectDestroy _id;
                            missionNamespace setVariable [_this#0, nil];
                            missionNamespace setVariable [_this#1, nil];
                        };
                    },
                    [_variableNameIDDestroy, _variableNameID]
                ]
            ] call CBA_fnc_execNextFrame;
        };
        missionNamespace setVariable [_variableNameIDDestroy, CBA_missionTime + _individualDuration];
    };

} forEach [ "RadialBlur", "ChromAberration", "WetDistortion" /*, "ColorInversion"*/ ];
