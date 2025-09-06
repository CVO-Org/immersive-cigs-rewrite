#include "../../script_component.hpp"

/*
* Author: Zorn
* FNC to process the changes of the Setting
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

[QGVAR(eh_startCig), EFUNC(core,start_cig)] call CBA_fnc_addEventHandler;
[QGVAR(eh_startSuck), EFUNC(core,start_Suck)] call CBA_fnc_addEventHandler;

[QGVAR(EH_startConsuming), FUNC(startConsuming)] call CBA_fnc_addEventHandler;
[QGVAR(EH_addUnitToFramework), FUNC(addUnitToFramework)] call CBA_fnc_addEventHandler;

if (!isServer) exitWith {};

//////////////////////////////////////////////////
///////////// Cigs on AI
//////////////////////////////////////////////////

["CBA_SettingChanged", FUNC(handleSettingChange)] call CBA_fnc_addEventHandler;
addMissionEventHandler ["EntityCreated", FUNC(onEntityCreated)];

//////////////////////////////////////////////////
///////////// Dynamic AI Smoking
//////////////////////////////////////////////////

GVAR(dynamicSmoking_units) = [];

