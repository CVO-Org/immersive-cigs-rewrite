#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to return if unit will be kept or removed from the array
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

alive _unit
&& {
    _unit isNil QEGVAR(api,dynamicSmoking_blocked)
    && {
        _unit call EFUNC(core,canTakeFromPack)
    }
}
