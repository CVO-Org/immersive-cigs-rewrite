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
* _unit call FUNC(addUnitToFramework);
*
* Public: No
*/

params [ ["_unit", objNull, [objNull] ] ];

if (!isServer || {isNull _unit}) exitWith {};

if ( _unit isNil QGVAR(canConsumeAgainAt) ) then {

    GVAR(dynamicSmoking_units) pushBack _unit;

    diag_log format ['[CVO](debug)(fn_AI_addUnitToFramework) GVAR(dynamicSmoking_units): %1', count GVAR(dynamicSmoking_units)];

    [_unit, true] call FUNC(updateCanConsumeAgain);

};


