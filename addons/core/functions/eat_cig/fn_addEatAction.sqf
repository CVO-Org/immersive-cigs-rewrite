#include "../../script_component.hpp"

/*
* Author: Zorn
* PostInit Function for the Eating of cigarettes
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

// Start Smoking
[
    "#All"                      // item - Classname or itemType or wildcard
    ,["GOGGLES", "HMD"]         // Slots - STRING or ARRAY of Strings
    ,[LLSTRING(eat_cig), LLSTRING(eat_cig_desc)]    // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                         // Text Color
    ,QPATHTOF(data\ui\eat_cig.paa)                        // Icon path
    ,[                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canEat)
        },{
            params ["_unit", "_container", "_item", "_slot", "_params"];
            _hasCig = switch (_slot) do {
                case "GOGGLES": { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSmokable)) == 1 || { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSuckable)) == 1 } };
                case "HMD":     { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSmokable)) == 1 || { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSuckable)) == 1 } };
                default { false };
            };
            _hasCig && { [_unit] call FUNC(canEat) };
        }
    ],
    {
        // statement - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];

        // Play Sound
        private _sound = selectRandom [QPVAR(eat_bread_1), QPVAR(eat_bread_2), QPVAR(eat_bread_3), QPVAR(eat_bread_4), QPVAR(eat_bread_5)];
        [_unit, _sound, nil, true, true, true] call CBA_fnc_globalSay3D;

        // Add Damage when Unit was Smoking
        if (_unit getVariable [QPVAR(isConsuming), false] isEqualTo "SMOKE") then {
            [_unit, 0.5 + random 0.5, "head", "burn", _unit] call ace_medical_fnc_addDamageToUnit;
        };

        // API
        [QEGVAR(api,eatCig),  [_unit, _item, _slot]] call CBA_fnc_localEvent;
    },
    true    // Consumes Item on Action
] call CBA_fnc_addItemContextMenuOption;
