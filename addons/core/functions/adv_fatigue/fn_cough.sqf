#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to do a cough
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


params ["_unit", "_coughIntensity"];

if !(isPlayer _unit) exitWith {};

private _sound = selectRandom [QPVAR(cough_0), QPVAR(cough_1), QPVAR(cough_2)];
private _distance = getArray (configFile >> "CfgSounds" >> _sound >> "sound") select 3; 

_distance = linearConversion [
    0,
    0.8,
    _coughIntensity,
    _distance * 0.3,
    _distance,
    true
];


[ _unit, _sound, _distance, true, true, true ] call CBA_fnc_globalSay3d;

if (_unit call EFUNC(core,isPlayer)) then {
    enableCamShake true;
    addCamShake [
        1 + (4 * _coughIntensity),
        3 + (2 * _coughIntensity),
        3 + (3 * _coughIntensity)
    ];
};

if ( 1 * _coughIntensity > random 3 ) then { [QGVAR(EH_cough), [_unit, _distance ]] call CBA_fnc_serverEvent; };
