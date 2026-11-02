#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Function will return cigs/pop packages based upon a units side
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

params [ "_unit" ];

// Priotize 
private _map = switch (true) do {
    case (! isNil QEGVAR(aiCigs,api) ):      { missionNamespace getVariable QEGVAR(aiCigs,api) };
    case (! isNil QEGVAR(aiCigs,module) ):   { missionNamespace getVariable QEGVAR(aiCigs,module) };
    default { EGVAR(aiCigs,default) };
};

// get and return array of possible cig/pop packages
private _return = _map getOrDefault [ str side _unit, [] ];
if !(_return isEqualType []) then { _return = [_return]; };

_return
