#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to use the lighter, play sound and remove 1 unit from "magazine type lighters"
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


// Why check if it can be checked before ?
/*
if (!(QPVAR(matches) in (magazines _unit)) && !(QPVAR(lighter) in (magazines _unit))) exitWith {
    [QGVAR(EH_notify), [LLSTRING(no_matches_or_lighter), 2.5], _unit] call CBA_fnc_targetEvent;
    false
};
*/

params [ "_unit", ["_forced", false, [true]] ];

[_unit] call FUNC(getLighter) params [ "_lighterClass", "_lighterType" ];

if ( _lighterClass isEqualTo false && {!_forced} ) exitWith {};

// Reduce Magazine Size if its a Magazine
if ( _lighterType isEqualTo "typeMagazine" ) then { [ _unit, _lighterClass ] call FUNC(removeItemFromMag); };

// Sound Effect
private _sound = switch (_lighterType) do {
    case "typeMagazine": { [ configFile >> "CfgMagazines" >> _lighterClass >> QPVAR(LighterSound) ] call CBA_fnc_getCfgDataRandom };
    case "typeItem":     { [ configFile >> "CfgWeapons"   >> _lighterClass >> QPVAR(LighterSound) ] call CBA_fnc_getCfgDataRandom };
    default { QGVAR(matches_01) };
};
[_unit, _sound, 50, true, true, true] call CBA_fnc_globalSay3D;

// Light Source Effect
[QGVAR(EH_light_lighter), [_unit, _sound]] call CBA_fnc_globalEvent;

// Combustion Event
[ CBA_fnc_serverEvent , [QGVAR(EH_useLighter_combustion), [_unit] ], 1.5 ] call CBA_fnc_waitAndExecute;

// API Event
[QGVAR(API_useLighter),  [_unit, _lighterClass, _lighterType]] call CBA_fnc_localEvent;
