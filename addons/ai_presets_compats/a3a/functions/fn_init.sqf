#include "..\script_component.hpp"

/*
* Author: Zorn
* Checks whether the mission is an Antistasi mission and, if so, sets cigs_ai_presets_compats_a3a_active.
* The addon itself only loads with the Antistasi mod, but the mod can be loaded for any mission.
* cigs_ai_presets_compats_a3a_active is the condition of this addon's entry in cigs_ai_compats, see cigs_ai_compats.hpp.
*
* Arguments:
* None
*
* Return Value:
* None
*
* Example:
* preInit
*
* Public: No
*/

if !( isClass ( missionConfigFile >> "A3A" ) ) exitWith {};

GVAR(active) = true;
