#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the config presets of a unit, from two places:
* - Its own class in CfgVehicles (through config inheritance): cigs_packs[], cigs_lighters[] and cigs_packsExtra[]
* - Its faction in CfgFactionClasses: cigs_packs[] and cigs_lighters[]
* A property the unit class defines replaces the faction's. cigs_packsExtra[] only exists on unit classes.
*
* Antistasi units are generic classes of the FIA factions (a3a_unit_west, a3a_unit_east, a3a_unit_reb*, a3a_unit_civ),
* dressed with setUnitLoadout. Their real faction is the Antistasi template loaded for their role, so for them the template
* replaces both places above: configFile >> "A3A" >> "Templates" >> <template> with cigs_packs_<tier>[] (tier from the unit's
* "unitType": militia, military, sf, police, other), then cigs_packs[], and cigs_lighters[].
* Police are the local force, so they only take cigs_packs_police[]: without it they get the terrain presets, not cigs_packs[].
* A template without these properties returns an empty hashmap: the unit goes on to the terrain and default presets, not to FIA.
*
* Only properties that are defined are returned. Classnames that are not a loaded pack / lighter are dropped,
* so a preset can list packs of optional brands.
* Cached per unit class, per faction and per Antistasi template and tier for the game session, as the config can not change.
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

private _class = typeOf _unit;

// Antistasi - "unitType" is "loadouts_<role>_<tier>_<loadout>" (e.g. loadouts_occ_military_Rifleman, loadouts_civ_Man),
// set by A3A_fnc_createUnit. Units created without it fall back to their a3a_unit_* class for the role.
private _a3aType = _unit getVariable ["unitType", ""];
private _a3aParts = if ( _a3aType isEqualType "" && { (_a3aType select [0, 9]) == "loadouts_" } ) then { _a3aType splitString "_" } else { [] };
if ( _a3aParts isEqualTo [] && { (toLowerANSI _class select [0, 9]) == "a3a_unit_" } ) then {
    private _role = createHashMapFromArray [ ["west", "occ"], ["east", "inv"], ["reb", "reb"], ["civ", "civ"] ] get ( (toLowerANSI _class splitString "_") param [2, ""] );
    if ( !isNil "_role" ) then { _a3aParts = [ "", _role ]; };
};
// The loaded templates only exist in an Antistasi game, on the server: A3A_Occ_template, A3A_Inv_template, A3A_Reb_template, A3A_Civ_template
private _a3aTemplate = if ( _a3aParts isEqualTo [] ) then { "" } else { missionNamespace getVariable [ format ["A3A_%1_template", _a3aParts select 1], "" ] };

if ( _a3aTemplate isEqualType "" && { _a3aTemplate isNotEqualTo "" } ) exitWith {
    private _tier = toLowerANSI ( _a3aParts param [2, ""] );
    if !( _tier in ["militia", "military", "sf", "police", "other"] ) then { _tier = ""; };

    [ format ["aiCigs_configPresets_a3a_%1_%2", toLowerANSI _a3aTemplate, _tier], {
        params [ "_template", "_tier", "_fnc_read", "_packs", "_lighters" ];
        private _cfg = configFile >> "A3A" >> "Templates" >> _template;
        private _map = [ _cfg, [ _packs, _lighters ] ] call _fnc_read;
        // cigs_packs_<tier>[] replaces cigs_packs[]
        if ( _tier isNotEqualTo "" ) then {
            _packs params [ "_key", "_property", "_marker" ];
            private _tierMap = [ _cfg, [ [ _key, format ["%1_%2", _property, _tier], _marker ] ] ] call _fnc_read;
            // Police are local: without their own preset they go on to the terrain presets of the map being played
            if ( _tier isEqualTo "police" && { !(_key in _tierMap) } ) then { _map deleteAt _key; };
            _map merge [ _tierMap, true ];
        };
        _map
    }, [ _a3aTemplate, _tier, _fnc_read, _packs, _lighters ] ] call EFUNC(core,getCached)
};

private _faction = faction _unit;
private _map = if ( _faction isEqualTo "" ) then { createHashMap } else {
    [ format ["aiCigs_configPresets_faction_%1", toLowerANSI _faction], {
        params [ "_faction", "_fnc_read", "_properties" ];
        [ configFile >> "CfgFactionClasses" >> _faction, _properties ] call _fnc_read
    }, [ _faction, _fnc_read, [ _packs, _lighters ] ] ] call EFUNC(core,getCached)
};

private _classMap = [ format ["aiCigs_configPresets_class_%1", toLowerANSI _class], {
    params [ "_class", "_fnc_read", "_properties" ];
    [ configFile >> "CfgVehicles" >> _class, _properties ] call _fnc_read
}, [ _class, _fnc_read, [ _packs, _lighters, _extra ] ] ] call EFUNC(core,getCached);

// getCached returns copies, so merging does not change the cache
_map merge [ _classMap, true ];
_map
