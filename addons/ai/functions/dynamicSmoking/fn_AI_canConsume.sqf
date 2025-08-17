#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to determine if the unit can start smoking now
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

params [ "_unit", ["_ignoreTime", false, [true]] ];

! isNull _unit
&&
{
    ! isPlayer _unit
    &&
    {
        simulationEnabled _unit
        &&
        {
            lifeState _unit in ["HEALTHY", "INJURED"]
            &&
            {
                combatBehaviour _unit in ["CARELESS", "SAFE", "AWARE"]
                &&
                {
                    _unit isNil QGVAR(dynamicSmoking_blocked)
                    &&
                    {
                        !( _unit getVariable [QPVAR(isSmoking), false] ) && !( _unit getVariable [QPVAR(isSucking), false] )
                        &&
                        {
                            if (_ignoreTime) then {
                                true
                            } else {
                                private _prevTime = _unit getVariable [QPVAR(lastConsumed), -1];
                                if (_prevTime == -1) then {
                                    true 
                                } else {
                                    ( _prevTime + 60 * SET(dynamicSmoking_min_time) ) < CBA_missionTime
                                }
                            }
                            &&
                            {
                                _unit call EFUNC(core,canTakeFromPack)
                            }
                        }
                    }
                }
            }
        }
    }
}
