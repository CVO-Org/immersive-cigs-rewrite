#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to Start the Loop
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call cigs_core_fnc_loopStop;
*
* Public: No
*/

params ["_unit", "_consumeType"];

////////////////////////////////////////
// Initial Check
////////////////////////////////////////
if !(local _unit) exitWith {};
if !(_consumeType in ["SMOKE", "SUCK"] ) exitWith {};


////////////////////////////////////////
// Set Flag
////////////////////////////////////////
if (_unit getVariable [QPVAR(isConsuming), false] isNotEqualTo false) exitWith {};
_unit setVariable [QPVAR(isConsuming), _consumeType, true];

////////////////////////////////////////
// Get itemType
////////////////////////////////////////

private _property = switch (_consumeType) do {
    case "SMOKE": { QPVAR(isSmokable) };
    case "SUCK":  { QPVAR(isSuckable) };
};

private _itemType = switch (true) do {
    case (getNumber (configFile >> "CfgGlasses" >> goggles _unit >> _property) == 1): { "GOGGLES" };
    case (getNumber (configFile >> "CfgWeapons" >>     hmd _unit >> _property) == 1): { "HMD" };
};

////////////////////////////////////////
// Get itemConfig
////////////////////////////////////////
private _itemConfig = switch (_itemType) do {
    case ("GOGGLES"):   { (configFile >> "CfgGlasses" >> goggles _unit ); };
    case ("HMD"):       { (configFile >> "CfgWeapons" >>     hmd _unit ); };
};

////////////////////////////////////////
// Get "stages" and "consumes"
////////////////////////////////////////
private _curStage = getNumber (_itemConfig >> QPVAR(curStage));
private _endStage = getNumber (_itemConfig >> QPVAR(endStage));

private _totalConsumes = switch (_consumeType) do {
    case "SMOKE": { getNumber (_itemConfig >> QPVAR(totalPuffs)) };
    case "SUCK":  { getNumber (_itemConfig >> QPVAR(totalSucks)) };
    default { "" };
};

private _stages = createHashMap; 
for "_stage" from 0 to _endStage do {
    _stages set [
        _stage,
        switch (_stage) do {
            case 0: { 0 };
            case 1: { 0.1 };
            default { round ( _totalConsumes / _endStage * (_stage - 1) ) };
        }
    ]
};

private _currConsumes = _stages get _curStage;


////////////////////////////////////////
// Initial add_slotItemChanged_EH
////////////////////////////////////////
_unit call FUNC(add_slotItemChanged_EH);


////////////////////////////////////////
// Create Data Hashmap
////////////////////////////////////////
private _loopData = createHashMapFromArray [
    [ "consumeType",    _consumeType ],
    
    [ "itemType",       _itemType ],
    [ "currentConfig",  _itemConfig ],
    [ "itemClass",      configName _itemConfig ],
    
    ["curStage",        _curStage ],
    ["endStage",        _endStage ],

    ["curConsumes",     _currConsumes ],
    ["totalConsumes",   _totalConsumes ]
];
_unit setVariable [QPVAR(loopData), _loopData];




////////////////////////////////////////
// Initial Effects - GLOBAL
////////////////////////////////////////
// Flavor Notification
private _flavor = [(_itemConfig >> QPVAR(flavor))] call CBA_fnc_getCfgDataRandom;
if (!isNil "_flavor") then { [ { [QGVAR(EH_notify), format [LLSTRING(taste_flavor), _this]] call CBA_fnc_localEvent; } , _flavor, 15 + random 30] call CBA_fnc_waitAndExecute; };


////////////////////////////////////////
// Initial Effects - consumeType
////////////////////////////////////////

private _delay = 0;

switch (_consumeType) do {
    case "SMOKE": {
        // Smoke Effect
        _delay = _delay + 2.5;
        [ CBA_fnc_globalEvent, [ QGVAR(EH_smoke_effect), [_unit, _itemConfig] ], _delay] call CBA_fnc_waitAndExecute;
        _delay = _delay + 1;
    };

    case "SUCK":  {
        // Sounds
        private _sound = [(_itemConfig >> QPVAR(sounds))] call CBA_fnc_getCfgDataRandom;
        [_unit, _sound, 25, true, true, true] call CBA_fnc_globalSay3D;        
        _delay = _delay + 2;
    };
};

////////////////////////////////////////
// Start Loop
////////////////////////////////////////
[FUNC(loop), ["_unit","_loopData"], _delay] call CBA_fnc_waitAndExecute;


////////////////////////////////////////
// API
////////////////////////////////////////
switch (_consumeType) do {
    case "SMOKE": { [ QEGVAR(api,startsSmoking), [_unit, _loopData] ] call CBA_fnc_localEvent; };
    case "SUCK":  { [ QEGVAR(api,startsSucking), [_unit, _loopData] ] call CBA_fnc_localEvent; };
};
