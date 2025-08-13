#include "../../script_component.hpp"

/*
* Author: Zorn
* Recursive Function - will handle the 
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

params ["_unit","_suckData"];


if (!local _unit) exitWith { [QGVAR(EH_sucking_start), _unit, _unit] call CBA_fnc_targetEvent; };


////////////////////////////////////////
// Get current Variables
////////////////////////////////////////
private _itemClass  = _suckData get "itemClass";
private _currentConfig = _suckData get "currentConfig";
private _itemType = _suckData get "itemType";


////////////////////////////////////////
// Check if unit is still sucking the same sucker
////////////////////////////////////////
private _same = switch (_itemType) do {
    case "HMD":     { _itemClass isEqualTo hmd _unit };
    case "GOGGLES": { _itemClass isEqualTo goggles _unit };
    default { false };
};

if (!_same) exitWith FUNC(sucking_stop);


////////////////////////////////////////
// Establish Suck Value
////////////////////////////////////////
private _suckIntensity = 1 + ( random 0.15 * selectRandom [-1, 1] );


////////////////////////////////////////
// Update Current Sucks
////////////////////////////////////////
private _curSucks = (_suckData get "curSucks") + _suckIntensity;
_suckData set ["curSucks", _curSucks];

////////////////////////////////////////
// Sound Effects
////////////////////////////////////////
private _sound = [(_currentConfig >> QPVAR(sounds))] call CBA_fnc_getCfgDataRandom;
[_unit, _sound, 20 * _suckIntensity, true, true, true] call CBA_fnc_globalSay3D;

 
////////////////////////////////////////
// Check and if Needed, Update Suck Class
////////////////////////////////////////
// If Current Sucks > Total Sucks -> Stop Smoking and Drop Cig
// If Current Sucks > Next Stage Sucks -> remove curr Cig + get new Cig, then continue

if ( _curSucks > (_suckData get "totalSucks") ) exitWith FUNC(sucking_stop); 

private _curStage = _suckData get "curStage";
private _endStage = _suckData get "endStage";


if ( _curStage < _endStage ) then {

    // If there is a follow-up stage, check if Current Sucks > Next Stage Sucks
    private _nextStage = _curStage + 1;
    private _nextStageSucks = _suckData get "stages" get _nextStage;

    if ( _curSucks >= _nextStageSucks ) then {

        // Get new Stage Classname
        private _array = _itemClass splitString "_";
        _array set [2, (_array select 2 trim [str _curStage, 2]) + str _nextStage ];
        private _newClass = _array joinString "_";

        // update Data
        _suckData set ["itemClass", _newClass];
        _suckData set [ "curStage", _nextStage];

        // Replace Item and Update CFG
        switch (_itemType) do {
            case "GOGGLES": {
                _suckData set [ "currentConfig", (configFile >> "CfgGlasses" >> _newClass) ];
                removeGoggles _unit;
                _unit addGoggles _gogglesNew;

            };
            case "HMD": {
                _suckData set [ "currentConfig", (configFile >> "CfgWeapons" >> _newClass) ];
                _unit removeWeapon _itemClass;
                _unit addWeapon  _newClass;
            };
        };
    };
};


////////////////////////////////////////
// Define Delay and Timers
////////////////////////////////////////
private  _delay = 10 + random 20;


////////////////////////////////////////
// Call Recursive Function
////////////////////////////////////////
[
    { 
        !( _this select 0 getVariable [QPVAR(isSucking), false] )
    },  // Condition
    FUNC(sucking_stop),
    [ _unit, _suckData ],
    _delay,
    {
        // Timeout Code ## Unit hasnt stopped sucking -> Can Keep Sucking?
        params ["_unit","_suckData"];
        if ( lifeState _unit in ["HEALTHY", "INJURED"] ) then FUNC(sucking) else FUNC(sucking_stop);
    }
] call CBA_fnc_waitUntilAndExecute;


////////////////////////////////////////
// API 
////////////////////////////////////////
[QGVAR(API_sucking),  [_unit, _suckData]] call CBA_fnc_localEvent;
