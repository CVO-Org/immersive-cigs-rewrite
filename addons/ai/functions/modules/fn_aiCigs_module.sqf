#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function to be triggered by the aiCigs Module
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

diag_log format ['[CVO](debug)(fn_aiCigs_module) _this: %1', _this];

params [
	["_logic", objNull, [objNull]],		// Argument 0 is module logic
	["_units", [], [[]]],				// Argument 1 is a list of affected units (affected by value selected in the 'class Units' argument))
	["_activated", true, [true]]		// True when the module was activated, false when it is deactivated (i.e., synced triggers are no longer active)
];

// Get and Validate Input
private _isPack = { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isPack)) isEqualTo 1 };
private _west = (_logic getVariable [QEGVAR(aiCigs,west), ""] call FUNC(packList_parse)) select _isPack;
private _east = (_logic getVariable [QEGVAR(aiCigs,east), ""] call FUNC(packList_parse)) select _isPack;
private _guer = (_logic getVariable [QEGVAR(aiCigs,guer), ""] call FUNC(packList_parse)) select _isPack;
private _civ  = (_logic getVariable [QEGVAR(aiCigs,civ),  ""] call FUNC(packList_parse)) select _isPack;

// Sides without packages are stored as well - they are disabled for aiCigs
private _map = createHashMapFromArray [["WEST",_west], ["EAST", _east], ["GUER", _guer], ["CIV", _civ]];

missionNamespace setVariable [QEGVAR(aiCigs,module), _map];
INFO_1("Immersive Cigs - aiCigs Module has been stored: %1",_map);
