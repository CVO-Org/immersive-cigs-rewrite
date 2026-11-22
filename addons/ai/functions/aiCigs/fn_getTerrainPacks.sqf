#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the terrain presets of the current terrain: packs[] in cigs_terrainPacks >> worldName (see terrainPacks.hpp).
* The same packs for all sides. Classnames that are not a loaded pack are dropped, so a terrain can list packs of optional brands.
*
* Arguments:
* None
*
* Return Value:
* Classnames <ARRAY of STRINGs>, or nil when the terrain has no entry
*
* Example:
* [] call cigs_ai_fnc_getTerrainPacks
*
* Public: No
*/

private _cfg = configFile >> QPVAR(terrainPacks) >> worldName >> "packs";

if ( !isArray _cfg ) exitWith { nil };

getArray _cfg select { getNumber ( configFile >> "CfgMagazines" >> _x >> QPVAR(isPack) ) isEqualTo 1 }
