#include "../script_component.hpp"


/*
* Author: Zorn
* post Init Function
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


// Common
[ QGVAR(EH_notify), CBA_fnc_notify ] call CBA_fnc_addEventHandler;

[ QGVAR(EH_sucking), FUNC(sucking) ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_smoking), FUNC(smoking) ] call CBA_fnc_addEventHandler;

[ QGVAR(EH_smoke_effect),   FUNC(smoke_effect)   ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_light_lighter),  FUNC(light_lighter)  ] call CBA_fnc_addEventHandler;
[ QGVAR(EH_light_cig_glow), FUNC(light_cig_glow) ] call CBA_fnc_addEventHandler;

// Advanced Fatigue
[QGVAR(EH_cough), FUNC(cough_server)] call CBA_fnc_addEventHandler;
[QGVAR(EH_aleart), FUNC(cough_aleart)] call CBA_fnc_addEventHandler;



// Stops unit smoking when unconscious
if ( isServer && { isClass (configFile >> "CfgPatches" >> "ace_medical") } ) then {
    ["ace_unconscious", {
        params ["_unit", "_isUncon"];
        if (_isUncon && { _unit getVariable [QPVAR(isSmoking), false] } ) then {
            _unit setVariable [QPVAR(isSmoking), false, true];
        };
    }] call CBA_fnc_addEventHandler;
};

if !(hasInterface) exitWith {};

// I dont remember why this waits for cba settings :harold:
private _code = {
    // reset isSmoking/isSucking variable on respawn
    player addEventHandler ["Respawn", {
        player setVariable [QPVAR(isSmoking), false];
        player setVariable [QPVAR(isSucking), false];
    }];

    // if 2 suckable/smokable items are equipped, it will put the nvg one back in the inventory.
    player addEventHandler ["InventoryClosed", {
        params ["_unit", "_container"];
        if (
            (
                getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSmokable)) == 1
                ||
              { getNumber (configFile >> "CfgGlasses" >> goggles _unit >> QPVAR(isSuckable)) == 1 }
            )
            &&
            {
                getNumber (configFile >> "CfgWeapons" >> hmd     _unit >> QPVAR(isSmokable)) == 1
                ||
              { getNumber (configFile >> "CfgWeapons" >> hmd     _unit >> QPVAR(isSuckable)) == 1 }
            }
        ) then {
            _unit addItem (hmd _unit);
            _unit unlinkItem (hmd _unit);
        };
    }];
};

if (missionNamespace getVariable ["cba_settings_ready",false]) then _code else { ["CBA_settingsInitialized",_code,[]] call CBA_fnc_addEventHandler; };
