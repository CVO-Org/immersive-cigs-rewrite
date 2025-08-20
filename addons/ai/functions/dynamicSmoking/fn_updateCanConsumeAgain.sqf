#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to update QGVAR(canConsumeAgainAt) of a unit
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* _unit call cigs_ai_fnc_AI_updateCanConsumeAgain;
* _unit call FUNC(updateCanConsumeAgain);
* _unit call EFUNC(AI,updateCanConsumeAgain);
*
* Public: No
*/

params [ "_unit", ["_init", false, [true]] ];

switch (_init) do {
    case true:  { _unit setVariable [ QGVAR(canConsumeAgainAt), round CBA_missionTime + round ( 60 * SET(dynamicSmoking_time_avg) * ( random 1 ) ), true ]; };
    case false: { _unit setVariable [ QGVAR(canConsumeAgainAt), round CBA_missionTime + round ( 60 * SET(dynamicSmoking_time_avg) * ( 0.5 + random 1 ) ), true ]; };
};
