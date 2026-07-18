#include "../../script_component.hpp"

/*
* Author: Zorn
* This function adds the CBA Context Menu for each item.
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


// Take from Pack
[
    "#All"                                      // item - Classname or itemType or wildcard
    ,["CONTAINER"]                              // Slots - STRING or ARRAY of Strings
    ,LLSTRING(takeFromPack)                   // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                                         // Text Color
    ,QPATHTOF(data\ui\take_cig.paa)             // Icon path
    ,[                                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            getNumber (configFile >> "CfgMagazines" >> _item >> QPVAR(isPack)) == 1
        },
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            getNumber (configFile >> "CfgMagazines" >> _item >> QPVAR(isPack)) == 1
        }
    ],
    {                          // statement - CODE - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];
        [_unit, _item, _slot] call FUNC(takeFromPack);
        _unit action ["Gear", objNull];
        false
    }
] call CBA_fnc_addItemContextMenuOption;


// Start Smoking
[
    "#All"                      // item - Classname or itemType or wildcard
    ,["GOGGLES", "HMD"]         // Slots - STRING or ARRAY of Strings
    ,[LLSTRING(start_cig_own), LLSTRING(start_cig_own_desc)]    // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                         // Text Color
    ,QPATHTOF(data\ui\light_cig.paa)                // Icon path
    ,[                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStartSmoking);
            [_unit] call FUNC(hasLighter);
        },{
            params ["_unit", "_container", "_item", "_slot", "_params"];
            _hasCig = switch (_slot) do {
                case "GOGGLES": { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSmokable)) == 1 };
                case "HMD":     { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSmokable)) == 1 };
                default { false };
            };
            _hasCig && { [_unit] call FUNC(canStartSmoking) };
        }
    ],
    {                          // statement - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];

        //(findDisplay 602) closeDisplay 2;
        [_unit] call FUNC(start_cig);
    }
] call CBA_fnc_addItemContextMenuOption;


// Stop Smoking
[
    "#All"                      // item - Classname or itemType or wildcard
    ,["GOGGLES", "HMD"]         // Slots - STRING or ARRAY of Strings
    ,LLSTRING(stop_cig)    // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                         // Text Color
    ,QPATHTOF(data\ui\light_cig.paa)                // Icon path
    ,[                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStopSmoking);
        },
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStopSmoking)
            &&
            {
                switch (_slot) do {
                    case "GOGGLES": { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSmokable)) == 1 };
                    case "HMD":     { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSmokable)) == 1 };
                    default { false };
                }
            }
        }
    ],
    {                          // statement - CODE - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];
        [_unit] call FUNC(stop_cig);
        false
    }
] call CBA_fnc_addItemContextMenuOption;


// Start Smoking
[
    "#All"                      // item - Classname or itemType or wildcard
    ,["GOGGLES", "HMD"]         // Slots - STRING or ARRAY of Strings
    ,[LLSTRING(sucking_start), LLSTRING(sucking_start_desc)]    // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                         // Text Color
    ,QPATHTOF(data\ui\pop_consume.paa)                // Icon path
    ,[                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStartSucking);
        },{
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStartSucking)
            &&
            {
                switch (_slot) do {
                    case "GOGGLES": { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSuckable)) == 1 };
                    case "HMD":     { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSuckable)) == 1 };
                    default { false };
                }
            };
        }
    ],
    {                          // statement - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];

        //(findDisplay 602) closeDisplay 2;
        [_unit] call FUNC(start_suck);
    }
] call CBA_fnc_addItemContextMenuOption;

// Stop Sucking
[
    "#All"                      // item - Classname or itemType or wildcard
    ,["GOGGLES", "HMD"]         // Slots - STRING or ARRAY of Strings
    ,LLSTRING(sucking_stop)    // Display Name - STRING or ARRAY of Strings - [displayName, Tooltip]
    ,[]                         // Text Color
    ,QPATHTOF(data\ui\pop_consume.paa)                // Icon path
    ,[                          // condition - CODE or ARRAY of Code [_conditionEnable, _conditionShow] - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStopSucking);
        },
        {
            params ["_unit", "_container", "_item", "_slot", "_params"];
            [_unit] call FUNC(canStopSucking)
            &&
            {
                switch (_slot) do {
                    case "GOGGLES": { getNumber (configFile >> "CfgGlasses" >> _item >> QPVAR(isSuckable)) == 1 };
                    case "HMD":     { getNumber (configFile >> "CfgWeapons" >> _item >> QPVAR(isSuckable)) == 1 };
                    default { false };
                }
            }
        }
    ],
    {                          // statement - CODE - Arguments: params ["_unit", "_container", "_item", "_slot", "_params"];
        params ["_unit", "_container", "_item", "_slot", "_params"];
        [_unit] call FUNC(sucking_stop);
        false
    }
] call CBA_fnc_addItemContextMenuOption;
