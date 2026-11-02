#include "..\..\script_component.hpp"

/*
* Author: Zorn
* function to chache some arrays of things
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


params [
    ["_name",       "",     [""]    ],
    ["_code",       {},     [{}]    ],
    ["_params",     [],     [[]]    ],
    ["_update",     false,  [false] ]
];

private _cacheMap = uiNamespace getVariable [QPVAR(cacheMap), "404"];

private _return = [];

if (_cacheMap isEqualTo "404") then {
    _cacheMap = createHashMap;
    uiNamespace setVariable [QPVAR(cacheMap), _cacheMap];
};

if ( _update || { !(_name in _cacheMap) } ) then {
    _return = _params call _code;
    _cacheMap set [_name, _return];
} else {
    _return = _cacheMap get _name;
};

// Create new Instance of Array, Hashmap type returns to break chain of reference.
if ( typeName _return in ["ARRAY", "HASHMAP"] ) then { _return = + _return };
_return
