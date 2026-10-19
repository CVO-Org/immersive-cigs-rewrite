#include "../../script_component.hpp"

/*
* Author: Zorn
* Server side of the "Make Unit Smoke" Zeus module. Finalizes the request of the Zeus and makes the unit smoke.
* The side based package is resolved here, as the package tables (API, module, defaults) only exist on the server.
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Package classname, or "SIDE" to pick one based upon the side of the unit <STRING>
* 2: Lighter classname <STRING>
* 3: Slot - "GOGGLES" or "HMD" <STRING>
* 4: Add to dynamic smoking <BOOL>
*
* Return Value:
* None
*
* Example:
* [QGVAR(EH_makeUnitSmoke), [_unit, "SIDE", "cigs_matches", "GOGGLES", true]] call CBA_fnc_serverEvent
*
* Public: No
*/

params [
    [ "_unit",                  objNull, [objNull] ],
    [ "_cigpack",               "",      [""]      ],
    [ "_lighter",               "",      [""]      ],
    [ "_slot",                  "",      [""]      ],
    [ "_addToDynamicSmoking",   false,   [false]   ]
];

if ( isNull _unit ) exitWith {};

if ( _cigpack isEqualTo "SIDE" ) then {
    _cigpack = selectRandom ( _unit call EFUNC(ai,getCigItems) );
    if ( isNil "_cigpack" ) then { _cigpack = QEGVAR(nil,cigpack); };
};

// Add package and lighter
[QGVAR(EH_addItem), [_unit, _cigpack, true, true], _unit] call CBA_fnc_targetEvent;
[QGVAR(EH_addItem), [_unit, _lighter, true, true], _unit] call CBA_fnc_targetEvent;

[QEGVAR(ai,EH_startConsuming), [_unit, _cigpack, _slot], _unit] call CBA_fnc_targetEvent;

// Add unit to Framework
if ( _addToDynamicSmoking ) then { [QEGVAR(ai,EH_addUnitToFramework), _unit] call CBA_fnc_localEvent; };
