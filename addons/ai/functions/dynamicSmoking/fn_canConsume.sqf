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
&& {
    ! (_unit call EFUNC(core,isPlayer))
    && {
        simulationEnabled _unit
        && {
            lifeState _unit in ["HEALTHY", "INJURED"]
            && {
                vehicle _unit isEqualTo _unit
                && {
                    combatBehaviour _unit in ["CARELESS", "SAFE", "AWARE"]
                    && {
                        !(_unit getVariable [QEGVAR(api,blockDynamicSmoking), false])
                        && {
                            _unit getVariable [QPVAR(isConsuming), false] isEqualTo false
                            && {
                                if (_ignoreTime) then {
                                    true
                                } else {
                                    private _prevTime = _unit getVariable [QGVAR(canConsumeAgainAt), -1];
                                    if (_prevTime == -1) then { true } else { _prevTime < CBA_missionTime }
                                }
                                && {
                                    _unit call EFUNC(core,canTakeFromPack)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
