#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the packages a unit can get from AI Cigs.
*
* The first active level decides. A level that is active but has no packages for the unit's side gives none,
* it does not fall through to the next level:
* 1. cigs_aiCigs_api                 - HASHMAP per side, set by a script
* 2. aiCigs module                   - HASHMAP per side, set by the module in 3DEN
* 3. Pack selection CBA settings     - while cigs_ai_set_aiCigs_packSelection_enable is on
* 4. cigs_aiCigs_api_lesser          - HASHMAP per side, or CODE per unit. CODE returning nil hands this unit to the next level.
* 5. Unit class presets              - cigs_packs[] of the unit's CfgVehicles class, while cigs_ai_set_aiCigs_configPresets_enable is on
* 6. Faction presets                 - cigs_packs[] of the unit's faction, while cigs_ai_set_aiCigs_configPresets_enable is on
* 7. Terrain presets                 - cigs_aiCigs_terrain, the same for all sides, while cigs_ai_set_aiCigs_terrainPresets_enable is on
* 8. Default presets                 - cigs_aiCigs_default, see defaultPacks.hpp
* On levels 5-8, the unit class's cigs_packsExtra[] is added to the list.
* Antistasi units take levels 5 and 6 from their Antistasi faction template instead, see fn_getConfigPresets.
*
* Arguments:
* 0: Unit <OBJECT>
*
* Return Value:
* Classnames of the packages <ARRAY of STRINGs>
*
* Example:
* [_unit] call cigs_ai_fnc_getCigItems
*
* Public: No
*/

params [ "_unit" ];

private _sideStr = str side _unit;
private _fromMap = { params ["_map"]; _map getOrDefault [ _sideStr, [] ] };

private _return = call {
    if ( !isNil QEGVAR(aiCigs,api) )                                               exitWith { [EGVAR(aiCigs,api)] call _fromMap };
    if ( !isNil QEGVAR(aiCigs,module) )                                            exitWith { [EGVAR(aiCigs,module)] call _fromMap };
    if ( missionNamespace getVariable [QSET(aiCigs_packSelection_enable), false] ) exitWith { [[] call FUNC(getSettingsPacks)] call _fromMap };

    // Lesser API - below the server admin's pack selection, for gamemodes and missions that bring their own defaults
    private _lesser = missionNamespace getVariable QEGVAR(aiCigs,api_lesser);
    private _packs = switch (true) do {
        case ( isNil "_lesser" ):                   { nil };
        case ( _lesser isEqualType {} ):            { [_unit] call _lesser };
        case ( _lesser isEqualType createHashMap ): { [_lesser] call _fromMap };
        default {
            ERROR_1("cigs_aiCigs_api_lesser must be a HASHMAP or CODE - got %1 - ignored",typeName _lesser);
            nil
        };
    };
    if ( !isNil "_packs" ) exitWith { _packs };

    // Unit class and faction presets - cigs_packs[] in CfgVehicles, then in CfgFactionClasses, see fn_getConfigPresets
    private _presets = if ( missionNamespace getVariable [QSET(aiCigs_configPresets_enable), true] ) then { [_unit] call FUNC(getConfigPresets) } else { createHashMap };
    private _configPacks = _presets get "packs";

    // Terrain presets - packs[] in cigs_terrainPacks >> worldName for all sides, see fn_getTerrainPacks. nil when the terrain has no entry.
    if ( isNil "_configPacks" && { missionNamespace getVariable [QSET(aiCigs_terrainPresets_enable), true] } ) then {
        _configPacks = missionNamespace getVariable QEGVAR(aiCigs,terrain);
    };

    // Default presets
    if ( isNil "_configPacks" ) then { _configPacks = [EGVAR(aiCigs,default)] call _fromMap; };
    if !( _configPacks isEqualType [] ) then { _configPacks = [_configPacks]; };

    // cigs_packsExtra[] of the unit class is added to whichever of these levels decides.
    // Only the extras that aren't in the list yet: a pack listed twice is drawn twice as often, so that weighting stays.
    private _extra = _presets getOrDefault [ "packsExtra", [] ];
    if ( _extra isEqualTo [] ) exitWith { _configPacks };
    _configPacks + ( (_extra arrayIntersect _extra) - _configPacks )
};

if ( isNil "_return" ) then { _return = []; };
if !( _return isEqualType [] ) then { _return = [_return]; };

_return
