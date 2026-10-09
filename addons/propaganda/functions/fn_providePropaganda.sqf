#include "../script_component.hpp"

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

params ["_player"];

private _items = switch (getPlayerUID _player) do {
    case "76561197970306509": {
        [
            "CVO_SpraypaintWhite",
            "CVO_SpraypaintBlack",
            "CVO_SpraypaintRed",
            "cigs_voron_cigpack",
            "cigs_voron_cigpack",
            "cigs_lighter"
        ]
    };
    default {
        [
            "CVO_SpraypaintBlack",
            "CVO_SpraypaintRed",
            "cigs_voron_cigpack",
            "cigs_voron_cigpack",
            "cigs_lighter"
        ]
    };
};

private _container = switch (true) do {
    case (backpack _player isNotEqualTo ""): { backpackContainer _player };
    case (vest     _player isNotEqualTo ""): {     vestContainer _player };
    case (uniform  _player isNotEqualTo ""): {  uniformContainer _player };
    default { objNull };
};

if (isNull _container) exitWith { [ FUNC(providePropaganda), _this, 300 ] call CBA_fnc_waitAndExecute; };

[ QGVAR(EH_addItemsOverloadServer), [ _container, _items ] ] call CBA_fnc_serverEvent;

[
    {
        [ ["<img image='%1' size=5></img><br/>%2", QPATHTOF(data\cvo_stencil_white_ca.paa), "You recieved your Goverment-Issued CVO-Care-Package!"], 6 ] call ace_common_fnc_displayTextStructured;
        [_this, "cvo_raven_caw", 25, false, false, 0.15] call CBA_fnc_globalSay3D;
    },
    _player,
    3
] call CBA_fnc_waitAndExecute;
