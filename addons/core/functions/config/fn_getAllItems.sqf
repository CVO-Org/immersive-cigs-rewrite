#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to retrieve modspecific classnames by filter / filter-group
*
* Arguments:
*
* Return Value:
* None
*
* Example: ["PACKAGES", true] call cigs_core_getAllItems;
* 
*
* Public: No
*/



params [
    ["_mode",        "ALL",         ["",[]]    ],
    ["_asConfig",    false,         [true]     ]
];


// If mode is an array it will handle the input as a manual list of filters and ignore the _isConfig parameter
// If its a string, it will take the "preset" and create the filter array based on it.
private _filter = [];
switch (typeName _mode) do {
    case "ARRAY": { _filter = _mode };  
    case "STRING": {
        _filter = switch (true) do {
            case ( (!_asConfig) && { _mode == "ALL"      } ): { ["LIGHTERS", "PACKAGES"] };             // className
            case ( (!_asConfig) && { _mode == "LIGHTERS" } ): { ["LIGHTERS"] };                         // className
            case ( (!_asConfig) && { _mode == "PACKAGES" } ): { ["PACKAGES"] };                         // className
            case (   _asConfig  && { _mode == "ALL"      } ): { ["CFG_LIGHTERS", "CFG_PACKAGES"] };     // CFG
            case (   _asConfig  && { _mode == "LIGHTERS" } ): { ["CFG_LIGHTERS"] };                     // CFG
            case (   _asConfig  && { _mode == "PACKAGES" } ): { ["CFG_PACKAGES"] };                     // CFG
            default { [] };
        };
    };
};


// Fill the return array with the desired content.
private _return = [];

private _cfg_lighters_code = { ["CFG_LIGHTERS", { Q(getNumber (_x >> QQPVAR(isLighter)) == 1 && { getNumber (_x >> QQ(scope)) == 2 }) configClasses (configFile >> "CfgMagazines") }] call FUNC(getCached) };
private _cfg_packages_code = { ["CFG_PACKAGES", { Q(getNumber (_x >> QQPVAR(isPack)   ) == 1 && { getNumber (_x >> QQ(scope)) == 2 }) configClasses (configFile >> "CfgMagazines") }] call FUNC(getCached) };

{
    switch (_x) do {
        case "CFG_LIGHTERS": { _return append ( call _cfg_lighters_code ) };
        case "CFG_PACKAGES": { _return append ( call _cfg_packages_code ) };
        case "LIGHTERS":     { _return append ( ["LIGHTERS", { call _cfg_lighters_code apply { configName _x } } ] call FUNC(getCached) ) };
        case "PACKAGES":     { _return append ( ["PACKAGES", { call _cfg_packages_code apply { configName _x } } ] call FUNC(getCached) ) };
    };
} forEach _filter;

_return
