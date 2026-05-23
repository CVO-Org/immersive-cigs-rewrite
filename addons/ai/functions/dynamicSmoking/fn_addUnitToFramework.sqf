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

// Add Unit to SmokerArray
if ( _unit isNil QGVAR(canConsumeAgainAt) ) then {

    GVAR(dynamicSmoking_units) pushBack _unit;

    [_unit, true] call FUNC(updateCanConsumeAgain);

};
