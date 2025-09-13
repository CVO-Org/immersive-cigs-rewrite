#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add the items to an individual unit
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

params ["_unit"];

if ( isNull _unit || { _unit call EFUNC(core,isPlayer) } ) exitWith {};

// Statements
private _addCigsOnAi = { [FUNC(addCigItemsToUnit), [_unit], SET(cigsonai_delay)] call CBA_fnc_waitAndExecute; };
private _addToDynamicAI = { _unit call FUNC(addUnitToFramework); };

// Conditions
private _checkUnitInventory =  { SET(dynamicSmoking_checkUnitInventory) && { [_unit] call EFUNC(core,canTakeFromPack) } };
private _checkCigsOnAiChance = { SET(cigsonai_enable)                   && { random 1 < SET(cigsonai_chance)    } };


switch (true) do {
    case ( call _checkUnitInventory  ): _addToDynamicAI;
    case ( call _checkCigsOnAiChance ): _addCigsOnAi;
};
