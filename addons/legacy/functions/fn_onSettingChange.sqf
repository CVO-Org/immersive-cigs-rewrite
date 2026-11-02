#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to handle changed settings across the addon.
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

["CBA_SettingChanged", {
    params ["_setting", "_value"];


    switch (_setting) do {
        case QSET(loudout_replacer_enable_personal): {
            if (_value) then {
                private _id = missionNamespace getVariable [QGVAR(eh_id_loudout_replacer), "404"];
                if (_id isEqualTo "404") then {
                    _id = ["featureCamera", FUNC(onArsenalOpen)] call CBA_fnc_addPlayerEventHandler;
                    missionNamespace setVariable [QGVAR(eh_id_loudout_replacer), _id];
                };
            } else {
                private _id = missionNamespace getVariable [QGVAR(eh_id_loudout_replacer), "404"];
                if (_id isNotEqualTo "404") then { ["featureCamera", _id] call CBA_fnc_removePlayerEventHandler; };
            };            
        };
        case QSET(loudout_replacer_enable_mission): {

            if (_value) then {
                [{ 
                    [] call FUNC(update_defaultLoadouts);
                } , [], 10] call CBA_fnc_waitAndExecute;
            };
        };
    };

}] call CBA_fnc_addEventHandler;
