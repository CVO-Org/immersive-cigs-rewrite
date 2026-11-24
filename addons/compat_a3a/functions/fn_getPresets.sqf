#include "..\script_component.hpp"

/*
* Author: Zorn
* Returns the Antistasi template presets of a unit. Called by cigs_ai_fnc_getConfigPresets through cigs_ai_compats (see cigs_ai_compats.hpp).
*
* Antistasi units are generic classes of the FIA factions (a3a_unit_west, a3a_unit_east, a3a_unit_reb*, a3a_unit_civ),
* dressed with setUnitLoadout. Their real faction is the Antistasi template loaded for their role, so the template
* replaces the unit class and faction presets: configFile >> "A3A" >> "Templates" >> <template> with cigs_packs_<tier>[]
* (tier from the unit's "unitType": militia, military, sf, police, other), then cigs_packs[], and cigs_lighters[].
* Police are the local force, so they only take cigs_packs_police[]: without it they get the terrain presets, not cigs_packs[].
*
* Classnames that are not a loaded pack / lighter are dropped, so a template can list packs of optional brands.
* Cached per template and tier for the game session, as the config can not change.
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* nil when the unit is not an Antistasi unit, so the unit class and faction presets decide.
* Otherwise the presets <HASHMAP> - Keys "packs" and / or "lighters", Value: classnames.
* An empty hashmap when the template has none: the unit goes on to the terrain and default presets, not to FIA.
*
* Example:
* [_unit] call cigs_compat_a3a_fnc_getPresets
*
* Public: No
*/

params [ [ "_unit", objNull, [objNull] ] ];

// "unitType" is "loadouts_<role>_<tier>_<loadout>" (e.g. loadouts_occ_military_Rifleman, loadouts_civ_Man),
// set by A3A_fnc_createUnit. It can also be a loadout array. Units created without it fall back to their a3a_unit_* class for the role.
private _type = _unit getVariable ["unitType", ""];
private _parts = if ( _type isEqualType "" && { (_type select [0, 9]) == "loadouts_" } ) then { _type splitString "_" } else { [] };

if ( _parts isEqualTo [] ) then {
    private _class = toLowerANSI typeOf _unit;
    if ( (_class select [0, 9]) != "a3a_unit_" ) exitWith {};
    private _role = createHashMapFromArray [ ["west", "occ"], ["east", "inv"], ["reb", "reb"], ["civ", "civ"] ] get ( (_class splitString "_") param [2, ""] );
    if ( !isNil "_role" ) then { _parts = [ "", _role ]; };
};

// Not an Antistasi unit (e.g. placed by Zeus): the normal presets decide
if ( _parts isEqualTo [] ) exitWith { nil };

// The loaded templates, set on the server by A3A_fnc_initVarServer before Antistasi creates its first unit:
// A3A_Occ_template, A3A_Inv_template, A3A_Reb_template, A3A_Civ_template
private _template = missionNamespace getVariable [ format ["A3A_%1_template", _parts select 1], "" ];
if !( _template isEqualType "" && { _template isNotEqualTo "" } ) exitWith { createHashMap };

private _tier = toLowerANSI ( _parts param [2, ""] );
if !( _tier in ["militia", "military", "sf", "police", "other"] ) then { _tier = ""; };

[ format ["aiCigs_configPresets_a3a_%1_%2", toLowerANSI _template, _tier], {
    params [ "_template", "_tier" ];

    private _cfg = configFile >> "A3A" >> "Templates" >> _template;
    private _map = createHashMap;

    // [ key, property, marker ] - only defined properties, only loaded classnames
    private _fnc_read = {
        params [ "_key", "_property", "_marker" ];
        if ( isArray ( _cfg >> _property ) ) then {
            _map set [ _key, getArray ( _cfg >> _property ) select { getNumber ( configFile >> "CfgMagazines" >> _x >> _marker ) isEqualTo 1 } ];
        };
    };

    [ "packs",    QPVAR(packs),    QPVAR(isPack)    ] call _fnc_read;
    [ "lighters", QPVAR(lighters), QPVAR(isLighter) ] call _fnc_read;

    // cigs_packs_<tier>[] replaces cigs_packs[]
    if ( _tier isNotEqualTo "" ) then {
        private _hasTier = isArray ( _cfg >> format ["%1_%2", QPVAR(packs), _tier] );
        // Police are local: without their own preset they go on to the terrain presets of the map being played
        if ( _tier isEqualTo "police" && { !_hasTier } ) then { _map deleteAt "packs"; };
        if ( _hasTier ) then { [ "packs", format ["%1_%2", QPVAR(packs), _tier], QPVAR(isPack) ] call _fnc_read; };
    };

    _map
}, [ _template, _tier ] ] call EFUNC(core,getCached)
