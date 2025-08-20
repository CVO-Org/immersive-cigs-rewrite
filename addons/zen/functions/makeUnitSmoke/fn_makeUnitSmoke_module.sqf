#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
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

params ["_posASL", "_unit"];

if  ( isNull _unit                                ) exitWith { [objNull, LLSTRING(module_makeUnitSmoke_noUnit)]         call BIS_fnc_showCuratorFeedbackMessage; };
if  ( _unit call EFUNC(core,isPlayer)             ) exitWith { [objNull, LLSTRING(module_makeUnitSmoke_player)]         call BIS_fnc_showCuratorFeedbackMessage; };
if !( _unit isKindOf "CAManBase"                  ) exitWith { [objNull, LLSTRING(module_makeUnitSmoke_notUnit)]        call BIS_fnc_showCuratorFeedbackMessage; };
if !( _unit getVariable [QPVAR(isSmoking), false] ) exitWith { [objNull, LLSTRING(module_makeUnitSmoke_alreadySmoking)] call BIS_fnc_showCuratorFeedbackMessage; };
if !( _unit getVariable [QPVAR(isSucking), false] ) exitWith { [objNull, LLSTRING(module_makeUnitSmoke_alreadySucking)] call BIS_fnc_showCuratorFeedbackMessage; };


/////////////////////////////
///////////// COMBO CIGPACKS 
/////////////////////////////

private _return_cigpacks = ["SIDE", "RANDOM"];
// can have Displayname, tooltip, picture, text color
private _displayName_cigpacks = [
    ["Based on Side", "Will select a random Brand based on the CBA Settings for Cigs On AI System"],
    ["Random", "Will select a random Brand from all loaded brands"]
];

{
    private _cfg = _x;
    _return_cigpacks pushBack (configName _cfg);
    _displayName_cigpacks pushBack [ getText (_cfg >> "displayName"), nil, getText (_cfg >> "picture") ];
} forEach (["PACKAGES", true] call EFUNC(core,getAllItems));


private _combo_cigpacks = [
    "COMBO",         // Control Type,
    MODLSTRING(makeUnitSmoke_brand),    // DisplayName and Tooltop
    [
        _return_cigpacks,
        _displayName_cigpacks, 
        0 // Default Index
    ],         // Specific Arguments
    false       // Force Default
];

/////////////////////////////
///////////// COMBO LIGHTER 
/////////////////////////////

private _return_lighters = ["RANDOM"];
// can have Displayname, tooltip, picture, text color
private _displayName_lighters = [
    ["Random", "Will select a random Brand from all loaded brands"]
];

{
    private _cfg = _x;
    _return_lighters pushBack (configName _cfg);
    _displayName_lighters pushBack [ getText (_cfg >> "displayName"), nil, getText (_cfg >> "picture") ];
} forEach (["LIGHTERS", true] call EFUNC(core,getAllItems));

private _combo_lighter = [
    "COMBO",         // Control Type,
    MODLSTRING(makeUnitSmoke_lighter),    // DisplayName and Tooltop
    [
        _return_lighters,
        _displayName_lighters, 
        0 // Default Index
    ],         // Specific Arguments
    false       // Force Default
];

/////////////////////////////
///////////// COMBO PREFFERED SLOT 
/////////////////////////////

private _combo_slot = [
    "COMBO",         // Control Type,
    MODLSTRING(makeUnitSmoke_slot),    // DisplayName and Tooltop
    [
        ["GOGGLES", "HMD", "RANDOM"],
        ["Goggles/Facewear", "Nightvision", "Random"], 
        0 // Default Index
    ],         // Specific Arguments
    false       // Force Default
];

/////////////////////////////
///////////// CHECKBOX Register Unit
/////////////////////////////

private _checkbox_add = [
    "CHECKBOX",                         // Control Type,
    MODLSTRING(makeUnitSmoke_add),     // DisplayName and Tooltop
    true,                               // Specific Arguments
    false                               // Force Default
];

/////////////////////////////
///////////// Open Dialog
/////////////////////////////

[
    format ["%1 - %2", LELSTRING(core,editor_category_main), LLSTRING(module_makeUnitSmoke)]
    ,[
            _combo_cigpacks,            // Combo of "Cigarette Packages"
            _combo_lighter,             // Combo of "Add Lighter, Matches or Random"
            _combo_slot,                // Combo of "Prefered Slot to make Free"
            _checkbox_add               // Checkbox: Register Unit to Dynamic AI Smoking System

    ]                                   // Content
    ,FUNC(makeUnitSmoke_statement)      // on Confirm
    ,{}     // On Cancel
    ,_this  // Arguments
] call zen_dialog_fnc_create;


/*

[
    "",         // Control Type,
    ["",""],    // DisplayName and Tooltop
    [],         // Specific Arguments
    false       // Force Default
]



[
    "CHECKBOX",             // Control Type,
    ["NAME","TOOLTIP"],     // DisplayName and Tooltop
    BOOL Default,           // Specific Arguments
    false                   // Force Default
]

[
    "COMBO",         // Control Type,
    ["NAME","TOOLTIP"],    // DisplayName and Tooltop
    [
        [
            [RETURN,Values],
            [Pretty,Names], // can have Displayname, tooltip, picture, text color
            0 // Default Index

        ]
    ],         // Specific Arguments
    false       // Force Default
]

[
    "COMBO",         // Control Type,
    ["NAME","TOOLTIP"],    // DisplayName and Tooltop
    [
        [
            [RETURN,Values],
            [Pretty,Names], // can have Displayname, tooltip, picture, text color
            0 // Default Index

        ]
    ],         // Specific Arguments
    false       // Force Default
]

*/

