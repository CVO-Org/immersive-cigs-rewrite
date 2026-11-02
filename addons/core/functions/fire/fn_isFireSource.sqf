#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Checks if an object can be used to light a cigarette: a burning fireplace, an object marked with cigs_isFireSource, or a burning unit (ACE Fire).
*
* Arguments:
* 0: Object <OBJECT>
*
* Return Value:
* Is fire source <BOOL>
*
* Example:
* [_object] call cigs_core_fnc_isFireSource
*
* Public: No
*/

params [ ["_object", objNull, [objNull]] ];

!isNull _object
&&
{
    inflamed _object                                                        // Fireplaces (simulation "fire") - only while burning
    ||
    { getNumber (configOf _object >> QPVAR(isFireSource)) == 1 }            // Marked via config
    ||
    { _object getVariable ["ace_fire_intensity", 0] > 0 }                   // Burning units - ACE Fire
}
