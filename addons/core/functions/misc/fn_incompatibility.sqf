#include "../../script_component.hpp"

/*
* Author: DartRuffian, Zorn
* Logs an error to systemChat and RPT if loaded with incompatible mods.
*
* Please provide proper credits to those who participate in development.
* This function was developed for Legion Studios: Core.
* Do not place in any other mod without permission.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* 
*
* Public: No
*/

#if _DEV_VERSION_ == 1
    #define REWRITE_MOD "3518473416"
#else
    #define REWRITE_MOD "3375788189"
#endif


private _incompatibleMods = [
    //"450814997",    // CBA - For Testing
    REWRITE_MOD,    // Immersion Cigs - Rewrite - The alternate Version - Stable or DEV

    "2975583316",   // ACE - D.U.M.P - some animations get stuck orsomething
    "2311516767",   // Immersion Crayons

    "3174419638",   // Kneely's WW2 Cigs 
    "3169315082",   // Kneely's WW2 Cigs - discontinued American
    "3169574837",   // Kneely's WW2 Cigs - discontinued British

    "2489446192",   // ciggy m8 "hotfix" version
    "3438220500",   // "russian version"
    "3209907282",   // apricot version
    
    "2493500261",   // Compat Mod: SOG
    "2975033007",   // Compat Mod: KJW Imposter
    
    "753946944"    // Original Immersion Cigs
];

private _loadedIncompatibleMods = getLoadedModsInfo select { (_x select 7) in _incompatibleMods };

if (_loadedIncompatibleMods isNotEqualTo []) then {
    {
        private _log = format [
            "[%1] ERROR: Incompatible mod loaded, '%2' is not compatible with %3.",
            toUpper QUOTE(PREFIX_BEAUTIFIED), _x select 0, QUOTE(PREFIX_BEAUTIFIED)
        ];
        systemChat _log;
        diag_log text _log;
    } forEach _loadedIncompatibleMods;

    private _message = format [
        "[%1] ERROR: These mods should not be loaded together, you may experience unexpected behavior and issues.",
        QUOTE(PREFIX_BEAUTIFIED)
    ];
    systemChat _message;
    diag_log text _message;


    private _array = [ LLSTRING(incompat_message1), "<br/>" ];

    { _array append ["<br/>", _x#0] } forEach _loadedIncompatibleMods;
   
    _array append [ "<br/>", "<br/>", LLSTRING(incompat_message2), LLSTRING(incompat_message3) ];
    
    private _title = format [LLSTRING(incompat_title), QUOTE(PREFIX_BEAUTIFIED) ];

    [
        {
            params ["_array", "_title"];

            _array = _array apply { if (_x == "<br/>") then { lineBreak } else { _x } };

            [composeText _array, _title] spawn BIS_fnc_guiMessage;
        },
        [ _array, _title ],
        1
    ] call CBA_fnc_waitAndExecute;
};
