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
* 4. Compat presets                  - cigs_ai_compats in configFile / missionConfigFile (e.g. Antistasi), per unit. Units they return nil for go on.
* 5. Unit class presets              - cigs_packs[] of the unit's CfgVehicles class
* 6. Faction presets                 - cigs_packs[] of the unit's faction
* 7. Terrain presets                 - cigs_aiCigs_terrain, the same for all sides, while cigs_ai_set_aiCigs_terrainPresets_enable is on
* 8. Default presets                 - cigs_aiCigs_default, see defaultPacks.hpp
* Levels 4-6 are the config presets (see fn_getConfigPresets), used while cigs_ai_set_aiCigs_configPresets_enable is on.
* On levels 4-8, the cigs_packsExtra[] of the unit class (or of the compat presets) is added to the list.
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

    // Config presets - compat presets, then cigs_packs[] in CfgVehicles, then in CfgFactionClasses, see fn_getConfigPresets
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
