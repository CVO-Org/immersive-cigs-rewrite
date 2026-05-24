#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle the smoke particles
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

params [ "_unit", ["_cfg", configNull], ["_factor_params", 1, [0]], ["_ignoreLifeState", false, [false]]];

if ( ( !_ignoreLifeState ) && { !(lifeState _unit in ["HEALTHY", "INJURED"]) } ) exitWith {};

private _smokeColor = (_cfg >> QPVAR(smokeColor)) call BIS_fnc_getCfgData;
if (isNil "_smokeColor") then { _smokeColor = [0.2, 0.2, 0.2]; };


private _factor_cig = (_cfg >> QPVAR(smokeMultiplier)) call BIS_fnc_getCfgData;
if (isNil "_factor_cig") then { _factor_cig = 1; };
private _factor_final = ((_factor_cig + _factor_params) / 2) max 0.25; // controls the size/intensity of the smoke, based on the smoker's setting

private _duration = 0.5 * _factor_params;


private _source = "#particleSource" createVehicleLocal getPosATL _unit;
_source setParticleParams [
    "\A3\data_f\cl_basic",          // Particle Shape
    "",                             // animationName ?
    "Billboard",                    // ParticleType (Billboard vs SpaceObject)
    _duration,                      // timer
    2 * _factor_final,              // Particle Lifetime
    [0, 0, 0],                      // pos3d - relative position to particleSource
    [0, 0.1, -0.1],                 // Move Velocity
    1,                              // Rotation Velocity
    1.2,                            // weight
    1,                              // Volume
    0.1,                            // rubbing
    [
        0.1 * _factor_final,
        0.2 * _factor_final,
        0.1 * _factor_final
    ],                              // Size over Lifetime
    [
        _smokeColor + [0.3 * _factor_final], // RGB + Alpha
        [0, 0, 0, 0.01],
        [1, 1, 1, 0]
    ],                              // Color over Lifetime
    [500],                          // Animation Speed over Lifetime
    1,                              // Random Direction Period
    0.04,                           // random Direction Intensity
    "",                             // onTimer Script
    "",                             // beforeDestroy Script
    _source                         // Source Object
];

_source setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];

_source setDropInterval linearConversion [0, 1, SET(smoke_particles), 0.025, 0.005, true]; // controls the quantity of particles, based on the client who "sees" them

_source attachTo [_unit, [0, 0.06, 0], "head"];

[ { deleteVehicle _this; }, _source, _duration ] call CBA_fnc_waitAndExecute;    // Controls the duration of the smoke spawner
