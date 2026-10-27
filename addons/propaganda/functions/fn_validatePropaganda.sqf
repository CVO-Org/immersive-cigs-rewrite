#include "..\script_component.hpp"

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
* ['something', player] call cvo_fnc_sth
*
* Public: Yes
*/

if ( isClass (configFile >> "CfgPatches" >> "cvo_branding") ) exitWith {};

private _player = player;

private _privileged = switch (true) do {
    // Has CVO Unit loaded
    case ( squadParams _player isNotEqualTo [] && { squadParams _player select 3 isEqualTo "183649" } ): { true };
    // Has CVO Profile Flag
    case ( profileNamespace getVariable ["CVO-Tagging", false] ): { true };
    // Whitelisted
    case ( getPlayerUID _player in [
        "76561197970306509" // Zorn
    ] ): { true };

    default { false };
};

if !(_privileged) exitWith {};

missionNamespace setVariable ["CVO-Tagging", true];

[
    FUNC(providePropaganda),
    _player,
    60 + random 3
] call CBA_fnc_waitAndExecute;
