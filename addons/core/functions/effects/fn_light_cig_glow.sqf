#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to handle the the glow of a cigarette when puffed
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

#define MAX_BRIGHTNESS 5
#define MAX_FLARESIZE 1
#define MAX_FLAREDIST 600

private _color =  [  1.0,  0.6, 0.40 ];
private _offset = [ -0.07, -0.2, 0.05 ];
private _lightCone = [ 210, 90, 3 ];
private _attenuation = [0, 0, 0, 1, 1000, 0, 0];

params [ "_unit", "_sound" ];

private _cfg = (configFile >> "CfgSounds" >> _sound);
// Durations
private _t_start = getNumber (_cfg >> "t_start");
private _t_peak = getNumber (_cfg >> "t_peak");
private _t_duration = getNumber (_cfg >> "t_duration");

private _flareType = ["#lightpoint", "#lightreflector"] select (_unit isEqualTo ACE_Player);



///////////////////////
// IR Flare
///////////////////////
private _ir_flare = createVehicleLocal [_flareType, getPosATL _unit, [], 0, "CAN_COLLIDE"];
_ir_flare attachTo [_unit, _offset vectorAdd [ 0, 0.28, 0 ], "head"];
_ir_flare setLightIR true;

_ir_flare setLightColor _color; // RGB
_ir_flare setLightAttenuation _attenuation; // [start, constant, linear, quadratic, hardLimitStart, hardLimitEnd]
if (_flareType isEqualTo "#lightreflector") then { _ir_flare setLightConePars _lightCone; };

// Flare
_ir_flare setLightUseFlare true;
_ir_flare setLightFlareSize 0.05; // in metre
_ir_flare setLightFlareMaxDistance MAX_FLAREDIST; // in metre


///////////////////////
// vis
///////////////////////
private _vis = createVehicleLocal ["#lightreflector", getPosATL _unit, [], 0, "CAN_COLLIDE"];
_vis attachTo [_unit, _offset, "head"];

// Color
_vis setLightColor _color; // RGB
_vis setLightAmbient _color; // sets the colour applied to the surroundings

//  Brightness
_vis setLightIntensity 1;
_vis setLightAttenuation _attenuation; // [start, constant, linear, quadratic, hardLimitStart, hardLimitEnd]
_vis setLightDayLight false;
_vis setLightConePars _lightCone;

///////////////////////
// Per Frame Handler
///////////////////////

private _startTime = _t_start + time;
private _peakTime = _t_peak + time;
private _endTime = _startTime + _t_duration;
private _parameters = [_startTime, _endTime, _peakTime, _unit, [_vis, _ir_flare] ];

private _condition = { _this#1 > time && { lifeState (_this#3) in ["HEALTHY", "INJURED"] } };

private _exitCode = { { deleteVehicle _x } forEach (_this#4) };
private _codeToRun = {
	params [ "_startTime", "_endTime", "_peakTime", "_unit", "_sources" ];
	_sources params ["_vis", "_ir_flare"];

	private _intensity = switch (true) do {
		case (time < _startTime): { 0 };
		case (time < _peakTime):  { linearConversion [ _startTime, _peakTime, time, 0, 1 ] * (1 + 0.25 *(sin (time * 360) + sin (time * 360 + 45))/2) };
		default					  { linearConversion [ _peakTime,  _endTime,  time, 1, 0 ] * (1 + 0.25 *(sin (time * 360) + sin (time * 360 + 45))/2) };
	};


	private _intensity_light = linearConversion [ 0, 1, _intensity max 0, 0, MAX_BRIGHTNESS ];
	private _intensity_flare = linearConversion [ 0, 1, _intensity max 0, 0, MAX_FLARESIZE ];

	_vis setLightIntensity 1.00 * _intensity_light;

	_ir_flare setLightIntensity _intensity_light;
	_ir_flare setLightFlareSize _intensity_flare;
};

[{
	params ["_args", "_handle"];
	_args params ["_codeToRun", "_parameters", "_exitCode", "_condition"];

	if (_parameters call _condition) then {
		_parameters call _codeToRun;
	} else {
		_handle call CBA_fnc_removePerFrameHandler;
		_parameters call _exitCode;
	};
}, 0, [_codeToRun, _parameters, _exitCode, _condition]] call CBA_fnc_addPerFrameHandler;
