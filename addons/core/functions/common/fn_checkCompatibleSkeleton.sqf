#include "../../script_component.hpp"

/*
* Author: Zorn
* Check if Skeleton is Custom or Not
*
* Arguments:
*
* Return Value:
* boolean - Returns true if the skeleton is incompatible
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params ["_unit"];

private _skeleton = getText (configFile >> getText (configFile >> "CfgVehicles" >> typeOf _unit >> "moves") >> "skeletonName");

// return
_skeleton in [ "OFP2_ManSkeleton" ]
