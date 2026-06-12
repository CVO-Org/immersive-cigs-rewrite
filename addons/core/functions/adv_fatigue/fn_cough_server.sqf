#include "../../script_component.hpp"

/*
* Author: Zorn
* Server Function to handle the coughing
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

params ["_instigator", "_range"];


private _groups = [];
{ _groups pushBackUnique (group _x) } forEach ([getPos _instigator, _range, _range, 0, false] nearEntities [["CAManBase"], false, true, true] select { [side _instigator, side _x] call BIS_fnc_sideIsEnemy });

{ [QGVAR(EH_aleart), [_x, _instigator], _x] call CBA_fnc_targetEvent; } forEach _groups;
