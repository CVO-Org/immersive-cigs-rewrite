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
* ['something', player] call cigs_core_fnc_smoking_start;
*
* Public: No
*/  

params ["_unit"];

////////////////////////////////////////
// Initial Check
////////////////////////////////////////
if (!(local _unit)) exitWith {};


////////////////////////////////////////
// Check if smoking & set flag
////////////////////////////////////////
if (_unit getVariable [QPVAR(isSmoking), false]) exitWith {};
_unit setVariable [QPVAR(isSmoking), true, true];


////////////////////////////////////////
// Identify current used Cig and Type
////////////////////////////////////////
private _itemType = switch (true) do {
    case (getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1): { "GOGGLES" };
    case (getNumber (configFile >> "CfgWeapons" >>     hmd _unit >> QPVAR(isSmokable)) == 1): { "HMD" };
    default { "" };
};
if (_itemType == "") exitWith {};


////////////////////////////////////////
// Create Data Hashmap
////////////////////////////////////////
private _smokeData = createHashMap;
_unit setVariable [QPVAR(smokeData), _smokeData];
_smokeData set ["itemType", _itemType ];


////////////////////////////////////////
// Start "SlotItemChanged" Event Handler
////////////////////////////////////////
// TODO
// if (isPlayer _unit) then {};


////////////////////////////////////////
// Get Item Config
////////////////////////////////////////
private _itemConfig = switch (_itemType) do {
    case ("GOGGLES"):   { (configFile >> "CfgGlasses" >> goggles _unit ); };
    case ("HMD"):       { (configFile >> "CfgWeapons" >>     hmd _unit ); };
};

_smokeData set ["currentConfig", _itemConfig ];
_smokeData set ["currentClass",  configName _itemConfig ];


////////////////////////////////////////
// Identify cigarette stages and current Puffs
////////////////////////////////////////
private _curStage = getNumber (_itemConfig >> QPVAR(curStage));
private _endStage = getNumber (_itemConfig >> QPVAR(endStage));

private _totalPuffs = getNumber (_itemConfig >> QPVAR(totalPuffs));

private _stages = createHashMap; 

for "_stage" from 0 to _endStage do {
    _stages set [
        _stage,
        switch (_stage) do {
            case 0: { 0 };
            case 1: { 0.1 };
            default { round ( _totalPuffs / _endStage * (_stage - 1) ) };
        }
    ]
};

private _curPuffs = _stages get _curStage;

_smokeData set ["curStage",   _curStage   ];
_smokeData set ["endStage",   _endStage   ];
_smokeData set ["stages",     _stages     ];
_smokeData set ["curPuffs",   _curPuffs   ];
_smokeData set ["totalPuffs", _totalPuffs ];


////////////////////////////////////////
// Initial Smoke Puffs 
////////////////////////////////////////
private _delay = 2.5;
[ CBA_fnc_globalEvent, [ QGVAR(EH_smoke_effect), [_unit, _itemConfig] ], _delay] call CBA_fnc_waitAndExecute;


////////////////////////////////////////
// Flavor Notification
////////////////////////////////////////
private _flavor = [(_itemConfig >> QPVAR(flavor))] call CBA_fnc_getCfgDataRandom;
if (!isNil "_flavor") then { [ { [QGVAR(EH_notify), format [LLSTRING(taste_flavor), _this]] call CBA_fnc_localEvent; } , _flavor, 15 + random 30] call CBA_fnc_waitAndExecute; };


////////////////////////////////////////
// Start Recursive Loop
////////////////////////////////////////
[ FUNC(smoking), [_unit, _smokeData], _delay + 1] call CBA_fnc_waitAndExecute;

