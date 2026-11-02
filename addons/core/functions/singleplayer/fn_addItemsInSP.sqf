#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function which will add Items in Singleplayer when enabled.
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


private _code = {

    // Add items to Player in SP
    ["unit", {
        params ["_player"];


        if (!isMultiplayer && !is3DENPreview && SET(sp_addItems)) then {
            if (SET(sp_addLighter)) then { _player addItem SET(sp_addLighter_type) };
            if (SET(sp_addCigpack)) then { _player addItem SET(sp_addCigpack_type) };
        };
    },true] call CBA_fnc_addPlayerEventHandler;
};

if (missionNamespace getVariable ["cba_settings_ready",false]) then _code else { ["CBA_settingsInitialized",_code,[]] call CBA_fnc_addEventHandler; };
