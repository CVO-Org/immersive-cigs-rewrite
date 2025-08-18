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

params [ "_unit" ];

_unit setVariable [ QGVAR(canConsumeAgainAt), round CBA_missionTime + round ( 60 * SET(dynamicSmoking_min_time) * ( 1 + random 1 ) ), true ];
