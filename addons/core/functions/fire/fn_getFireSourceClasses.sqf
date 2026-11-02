#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the CfgVehicles classes that can be fire sources - the topmost ones, the ACE action is inherited.
* Cached for the game session.
*
* Arguments:
* None
*
* Return Value:
* Classnames <ARRAY of STRINGs>
*
* Example:
* [] call cigs_core_fnc_getFireSourceClasses
*
* Public: No
*/

[ QGVAR(fireSourceClasses), {

    private _classes = ( QUOTE(getText (_x >> 'simulation') == 'fire' || { getNumber (_x >> QQPVAR(isFireSource)) == 1 }) configClasses (configFile >> "CfgVehicles") ) apply { configName _x };

    // Only the topmost classes - children inherit the action
    private _classesLower = _classes apply { toLowerANSI _x };
    _classes = _classes select { !( toLowerANSI configName inheritsFrom (configFile >> "CfgVehicles" >> _x) in _classesLower ) };

    // Burning units - ACE Fire
    if (isClass (configFile >> "CfgPatches" >> "ace_fire")) then { _classes pushBack "CAManBase"; };

    _classes
} ] call FUNC(getCached)
