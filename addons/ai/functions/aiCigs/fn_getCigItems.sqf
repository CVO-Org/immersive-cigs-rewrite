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
* 5. Faction presets                 - cigs_packs[] of the unit's faction, while cigs_ai_set_aiCigs_configPresets_enable is on
* 6. Terrain presets                 - cigs_aiCigs_terrain, the same for all sides, while cigs_ai_set_aiCigs_terrainPresets_enable is on
* 7. Default presets                 - cigs_aiCigs_default, see defaultPacks.hpp
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

    // Faction presets - cigs_packs[] in CfgFactionClasses, see fn_getConfigPresets
    private _configPacks = if ( missionNamespace getVariable [QSET(aiCigs_configPresets_enable), true] ) then { ([_unit] call FUNC(getConfigPresets)) get "packs" } else { nil };
    if ( !isNil "_configPacks" ) exitWith { _configPacks };

    // Terrain presets - packs[] in cigs_terrainPacks >> worldName for all sides, see fn_getTerrainPacks. nil when the terrain has no entry.
    private _terrainPacks = if ( missionNamespace getVariable [QSET(aiCigs_terrainPresets_enable), true] ) then { missionNamespace getVariable QEGVAR(aiCigs,terrain) } else { nil };
    if ( !isNil "_terrainPacks" ) exitWith { _terrainPacks };

    [EGVAR(aiCigs,default)] call _fromMap
};

if ( isNil "_return" ) then { _return = []; };
if !( _return isEqualType [] ) then { _return = [_return]; };

_return
