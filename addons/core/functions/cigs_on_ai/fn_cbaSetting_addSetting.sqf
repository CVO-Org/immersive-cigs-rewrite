#include "../../script_component.hpp"

/*
* Author: Zorn
* This function will add a CBA Setting for the defined Side 
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

params [ "_cfg", "_side"];

private _className = configName _cfg;
private _displayName = getText (_cfg >> "displayName");

private _defaultValue = switch (_side) do {
    case west:       { _className in ["cigs_morley_cigpack", "cigs_crayons_crayonpack", "cigs_cigars_cigarbox_5"] };
    case east:       { _className in ["cigs_Apollo_cigpack", "cigs_Kosmos_cigpack", "cigs_cigars_cigarbox_5"] };
    case resistance: { _className in ["cigs_baja_blast_cigpack", "cigs_black_devil_cigpack", "cigs_cigars_cigarbox_5"] };
    case civilian:   { _className in ["cigs_morley_cigpack","cigs_pops_poppack"] };
    default { false };
};

[
	[Q(ADDON), "set", "cigsonai", "custom", "#", _side, _className] joinString "_",    //    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                             //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	[_displayName, "Add this to the side's pool"],
                                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_mainCat_cigsonai), str _side],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	_defaultValue,					                        //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,										                //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										                //    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									                //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
