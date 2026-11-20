#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the config presets of a unit, from two places:
* - Its own class in CfgVehicles (through config inheritance): cigs_packs[], cigs_lighters[] and cigs_packsExtra[]
* - Its faction in CfgFactionClasses: cigs_packs[] and cigs_lighters[]
* A property the unit class defines replaces the faction's. cigs_packsExtra[] only exists on unit classes.
* Only properties that are defined are returned. Classnames that are not a loaded pack / lighter are dropped,
* so a preset can list packs of optional brands.
* Cached per unit class and per faction for the game session, as the config can not change.
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* Presets <HASHMAP> - Keys "packs", "lighters" and / or "packsExtra", Value: classnames - empty hashmap when nothing is defined
*
* Example:
* ([_unit] call cigs_ai_fnc_getConfigPresets) get "packs"
*
* Public: No
*/

params [ [ "_unit", objNull, [objNull] ] ];

if ( isNull _unit ) exitWith { createHashMap };

// Reads the given properties of a config class: [ [ key, property, marker ], ... ]
private _fnc_read = {
    params [ "_cfg", "_properties" ];
    private _map = createHashMap;
    {
        _x params [ "_key", "_property", "_marker" ];
        if ( isArray ( _cfg >> _property ) ) then {
            _map set [ _key, getArray ( _cfg >> _property ) select { getNumber ( configFile >> "CfgMagazines" >> _x >> _marker ) isEqualTo 1 } ];
        };
    } forEach _properties;
    _map
};

private _packs    = [ "packs",    QPVAR(packs),    QPVAR(isPack)    ];
private _lighters = [ "lighters", QPVAR(lighters), QPVAR(isLighter) ];
private _extra    = [ "packsExtra", QPVAR(packsExtra), QPVAR(isPack) ];

private _faction = faction _unit;
private _map = if ( _faction isEqualTo "" ) then { createHashMap } else {
    [ format ["aiCigs_configPresets_faction_%1", toLowerANSI _faction], {
        params [ "_faction", "_fnc_read", "_properties" ];
        [ configFile >> "CfgFactionClasses" >> _faction, _properties ] call _fnc_read
    }, [ _faction, _fnc_read, [ _packs, _lighters ] ] ] call EFUNC(core,getCached)
};

private _class = typeOf _unit;
private _classMap = [ format ["aiCigs_configPresets_class_%1", toLowerANSI _class], {
    params [ "_class", "_fnc_read", "_properties" ];
    [ configFile >> "CfgVehicles" >> _class, _properties ] call _fnc_read
}, [ _class, _fnc_read, [ _packs, _lighters, _extra ] ] ] call EFUNC(core,getCached);

// getCached returns copies, so merging does not change the cache
_map merge [ _classMap, true ];
_map
