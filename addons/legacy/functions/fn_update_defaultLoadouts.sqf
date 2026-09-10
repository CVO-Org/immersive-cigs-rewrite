#include "..\script_component.hpp"
/*
 * Author: DartRuffian & Overlord Zorn
 * Replaces deprecated classes in mission defined ace arsenal default loadouts.
 *
 * Arguments:
 * 0: Unused
 * 1: Camera type <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call cigs_legacy_fnc_udpate_defaultLoadouts;
 *
 * Public: No
 */

private _loadouts = missionNamespace getVariable ["ace_arsenal_defaultloadoutslist", []];

// From: https://github.com/acemod/ACE3/blob/master/addons/arsenal/functions/fnc_verifyLoadout.sqf#L39-L85
private _fnc_filterLoadout = {
    _this apply {
        if (_x isEqualType "" && {_x != ""}) then {
            _name = _x call FUNC(getReplacementItem);
            _name
        } else {
            if (_x isEqualType []) then {
                _itemArray = _x call _fnc_filterLoadout;
                if (count _itemArray == 2 && {(_itemArray select 0) isEqualTo ""} && {(_itemArray select 1) isEqualType []}) then {
                    _itemArray = [];
                };
                _itemArray
            } else {
                _x
            };
        };
    };
};

_loadouts = _loadouts apply {
    if (_x isEqualType "") then {
        _x; // For vanilla loadout names
    } else {
        _x call _fnc_filterLoadout;
    };
};

missionNamespace setVariable ["ace_arsenal_defaultloadoutslist", _loadouts];
nil;
