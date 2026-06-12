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
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

// Event: When using the Lighter, is there something flammable nearby?
// Only runs on the server.

if (!isClass (configFile >> "CfgPatches" >> "ace_fire")) exitWith {};

[
    QGVAR(EH_useLighter_combustion),
    {
        if ( !(missionNamespace getVariable ["ace_fire_enabled", false]) || { SET(effect_combustion_chance) isEqualTo 0 } ) exitWith {};

        params ["_unit"];
        private _nearbyObjs = nearestObjects [_unit, [], 7, true] select {
            //exclude Filter:
            !( typeOf _x in ["ace_refuel_fuelHoseSegment", "#soundonvehicle"] )
            &&
            { isClass (configOf _x) };
        };

        _nearbyObjs = _nearbyObjs select {
            private _className = typeOf _x;
            _className in ["ace_refuel_fuelNozzle"]
            ||
            {
                getNumber (configFile >> "CfgVehicles" >> _className >> QPVAR(canCauseCombustion) ) > 0
                ||
                {
                    private _fuel = [_x] call ace_refuel_fnc_getFuel;
                    _fuel > 0 || { _fuel isEqualTo -10 } // -10 infinite fuel source
                }
            }
        };
        {
            [FUNC(combustion_check), [_unit], 1.0] call CBA_fnc_waitAndExecute;
        } forEach _nearbyObjs;
    }
] call CBA_fnc_addEventHandler;


// Event: When starting Refueling, is the unit doing it smoking?
["ace_refuel_started", {
    if ( !(missionNamespace getVariable ["ace_fire_enabled", false]) || { SET(effect_combustion_chance) isEqualTo 0 } ) exitWith {};
    [ FUNC(combustion_check) , [_this#3], 1 + ceil random 5 ] call CBA_fnc_waitAndExecute;
}] call CBA_fnc_addEventHandler;

[QGVAR(EH_burn), ace_fire_fnc_burn] call CBA_fnc_addEventHandler;
[QGVAR(EH_drop_cig), FUNC(drop_cig)] call CBA_fnc_addEventHandler;
