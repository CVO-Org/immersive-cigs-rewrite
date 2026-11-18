#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the config presets of a unit's faction: cigs_packs[] and cigs_lighters[] in CfgFactionClasses >> faction.
* Only properties the faction defines are returned. Classnames that are not a loaded pack / lighter are dropped,
* so a faction can list packs of optional brands.
* Cached per faction for the game session, as the config can not change.
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* Presets <HASHMAP> - Keys "packs" and / or "lighters", Value: classnames - empty hashmap when the faction defines none
*
* Example:
* ([_unit] call cigs_ai_fnc_getConfigPresets) get "packs"
*
* Public: No
*/

params [ [ "_unit", objNull, [objNull] ] ];

private _faction = faction _unit;
if ( _faction isEqualTo "" ) exitWith { createHashMap };

[ format ["aiCigs_configPresets_faction_%1", toLowerANSI _faction], {
    params [ "_faction" ];

    private _cfg = configFile >> "CfgFactionClasses" >> _faction;
    private _map = createHashMap;

    {
        _x params [ "_key", "_property", "_marker" ];
        if ( isArray ( _cfg >> _property ) ) then {
            _map set [ _key, getArray ( _cfg >> _property ) select { getNumber ( configFile >> "CfgMagazines" >> _x >> _marker ) isEqualTo 1 } ];
        };
    } forEach [
        [ "packs",    QPVAR(packs),    QPVAR(isPack)    ],
        [ "lighters", QPVAR(lighters), QPVAR(isLighter) ]
    ];

    _map
}, [ _faction ] ] call EFUNC(core,getCached)
