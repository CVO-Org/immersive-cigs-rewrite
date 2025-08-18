#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add a unit to the dynamicSmoking Framework
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* _unit call FUNC(AI_addUnitToFramework);
*
* Public: No
*/

params [ ["_unit", objNull, [objNull] ] ];

if (isNull _unit) exitWith {};

GVAR(dynamicSmoking_units) pushBack _unit;
_unit call FUNC(AI_updateCanConsumeAgain);

