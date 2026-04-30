#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to use the lighter, play sound and remove 1 unit from "magazine type lighters"
* Does NOT start the smoking loop
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

params [
    "_unit",
    ["_forced", false, [true]],
    [ "_mode", "NORMAL", [""] ]
];

if !(_mode in ["NORMAL", "GIVING", "RECIEVING"]) exitWith { systemChat "Someone Fucked Up!" }; 

[ _unit ] call FUNC(getLighter) params [ "_lighterClass", "_lighterType" ];

if ( _lighterClass isEqualTo false && { !_forced } ) exitWith {};

// Reduce Magazine Size if its a Magazine
if ( (_mode isNotEqualTo "RECIEVING") && {_lighterType isEqualTo "typeMagazine"} ) then { [ _unit, _lighterClass ] call FUNC(removeItemFromMag); };


// Play Animation
switch (true) do {
    case (_mode isEqualTo "GIVING"): { [ _unit, "PutDown",           1.5 ] call FUNC(anim); };
    default                          { [ _unit, QEGVAR(anim,cig_in), 3.0 ] call FUNC(anim); };
};

if (_mode isNotEqualTo "GIVING") then {
    // Sound Effect
    private _sound = switch (_lighterType) do {
        case "typeMagazine": { [ configFile >> "CfgMagazines" >> _lighterClass >> QPVAR(LighterSound) ] call CBA_fnc_getCfgDataRandom };
        case "typeItem":     { [ configFile >> "CfgWeapons"   >> _lighterClass >> QPVAR(LighterSound) ] call CBA_fnc_getCfgDataRandom };
        default { QGVAR(matches_01) };
    };
    // Sound and Light Effects
    [ CBA_fnc_globalSay3D , [ _unit, _sound, 50, true, true, true ],      1 ] call CBA_fnc_waitAndExecute;
    [ CBA_fnc_globalEvent , [ QGVAR(EH_light_lighter), [_unit, _sound] ], 1 ] call CBA_fnc_waitAndExecute;
};

// Combustion Event
[ CBA_fnc_serverEvent , [ QGVAR(EH_useLighter_combustion), [_unit] ], 1.5 ] call CBA_fnc_waitAndExecute;

// API Event
[ QEGVAR(api,useLighter),  [ _unit, _lighterClass, _lighterType, _mode ] ] call CBA_fnc_localEvent;
