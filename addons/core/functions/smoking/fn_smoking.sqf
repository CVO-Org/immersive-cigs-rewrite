#include "../../script_component.hpp"

/*
* Author: Zorn
* Recursive Function to handle the smoking of the Cigs. Triggers Smoke Particles
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_smoking;
*
* Public: No
*/

params ["_unit","_smokeData"];

if (!local _unit) exitWith {
    _unit setVariable [QPVAR(smokeData), _smokeData, true];
    [QGVAR(EH_smoking), _this, _unit] call CBA_fnc_targetEvent;
    _unit setVariable [QPVAR(smokeData), nil];
};

////////////////////////////////////////
// Stop AI due to Combat Behavior
////////////////////////////////////////
private _exit = if (_unit call EFUNC(core,isPlayer)) then { false } else {
    switch (combatBehaviour _unit) do {
        case "COMBAT": { random 1 > 0.33 };
        case "STEALTH": { true };
        default { false };
    };
};
if (_exit) exitWith FUNC(smoking_stop);


////////////////////////////////////////
// Get current Variables
////////////////////////////////////////
private _itemClass  = _smokeData get "itemClass";
private _currentConfig = _smokeData get "currentConfig";
private _itemType = _smokeData get "itemType";

////////////////////////////////////////
// Check if unit is still smoking the same cigarette
////////////////////////////////////////
private _same = switch (_itemType) do {
    case "HMD":     { _itemClass isEqualTo hmd _unit };
    case "GOGGLES": { _itemClass isEqualTo goggles _unit };
    default { false };
};

if (!_same) exitWith FUNC(smoking_stop);

////////////////////////////////////////
// Establish Puff Value
////////////////////////////////////////
private _puffIntensity = SET(smoking_intensity) + ( random 0.15 * selectRandom [-1, 1] );


////////////////////////////////////////
// Update Current Puffs
////////////////////////////////////////
private _curPuffs = (_smokeData get "curPuffs") + _puffIntensity;
_smokeData set ["curPuffs", _curPuffs];


////////////////////////////////////////
// Sound Effects
////////////////////////////////////////
private _sound = (_currentConfig >> QPVAR(sound)) call CBA_fnc_getCfgDataRandom;
if (isNil "_sound") then { _sound = selectRandom [QPVAR(smoke_3),QPVAR(smoke_4)] };
[_unit, _sound, 20 * _puffIntensity, true, false, true] call CBA_fnc_globalSay3d;

////////////////////////////////////////
// Light Effect
////////////////////////////////////////
[QGVAR(EH_light_cig_glow), [_unit, _sound]] call CBA_fnc_globalEvent;


////////////////////////////////////////
// Smoke Particles
////////////////////////////////////////
[ CBA_fnc_globalEvent, [QGVAR(EH_smoke_effect), [_unit, _currentConfig, _puffIntensity]], 2.5 ] call CBA_fnc_waitAndExecute;


////////////////////////////////////////
// Fatigue
////////////////////////////////////////
_unit setFatigue (getFatigue _unit + 0.01);
[_unit, _puffIntensity] call FUNC(adv_fatigue_addPuffs);


////////////////////////////////////////
// Check and if Needed, Update Cig Class
////////////////////////////////////////
// If Current Puffs > Total Puffs -> Stop Smoking and Drop Cig
// If Current Puffs > Next Stage Puffs -> remove curr Cig + get new Cig, then continue

if ( _curPuffs > (_smokeData get "totalPuffs") ) exitWith FUNC(smoking_stop); 

private _curStage = _smokeData get "curStage";
private _endStage = _smokeData get "endStage";


if ( _curStage < _endStage ) then {

    // If there is a follow-up stage, check if Current Puffs > Next Stage Puffs
    private _nextStage = _curStage + 1;
    private _nextStagePuffs = _smokeData get "stages" get _nextStage;

    if ( _curPuffs >= _nextStagePuffs ) then {

        // Get new Stage Classname
        private _array = _itemClass splitString "_";
        private _n = count _array;
        private _i = if (_array select -1 isEqualTo "nv") then { _n - 2 } else { _n - 1 };
        _array set [_i, (_array select _i trim [str _curStage, 2]) + str _nextStage ];
        private _newClass = _array joinString "_";

        // update Data
        _smokeData set ["itemClass", _newClass];
        _smokeData set [ "curStage", _nextStage];

        // Replace Item and Update CFG
        switch (_itemType) do {
            case "GOGGLES": {
                _smokeData set [ "currentConfig", (configFile >> "CfgGlasses" >> _newClass) ];
                removeGoggles _unit;
                _unit addGoggles _newClass;

            };
            case "HMD": {
                _smokeData set [ "currentConfig", (configFile >> "CfgWeapons" >> _newClass) ];
                _unit removeWeapon _itemClass;
                _unit addWeapon  _newClass;
            };
        };
    };
};


////////////////////////////////////////
// Define Delay and Timers
////////////////////////////////////////
private  _delay = (20 + ceil random 10) / SET(smoking_frequency);



////////////////////////////////////////
// Call Recursive Function
////////////////////////////////////////
[

    { !( _this select 0 getVariable [QPVAR(isSmoking), false] ) },  // Condition
    FUNC(smoking_stop),  
    [_unit,_smokeData],
    _delay,
    {
        // Timeout Code ## Unit hasnt stopped smoking -> Can Keep Smoking?

        params ["_unit","_smokeData"];
        if ( lifeState _unit in ["HEALTHY", "INJURED"] ) then {
            // Can continue smoking
            _this call FUNC(smoking);
        } else {
            _this call FUNC(smoking_stop);
        };
    }
] call CBA_fnc_waitUntilAndExecute;


////////////////////////////////////////
// API 
////////////////////////////////////////
[QGVAR(API_smoking),  [_unit, _smokeData]] call CBA_fnc_localEvent;
