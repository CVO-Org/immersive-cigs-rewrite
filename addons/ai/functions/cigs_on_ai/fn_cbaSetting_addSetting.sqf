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
    case west:       { _className in [ QEGVAR(morley,cigpack), QEGVAR(crayons,crayonpack) ] };
    case east:       { _className in [ QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) ] };
    case resistance: { _className in [ QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) ] };
    case civilian:   { _className in [ QEGVAR(morley,cigpack), QEGVAR(pops,poppack), QEGVAR(nil,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(crayons,crayonpack) ]  };
    default { false };
};


[
	[Q(ADDON), "set", "cigsonai", "custom", "#", _side, _className] joinString "_",    //    _setting     - Unique setting name. Matches resulting variable name <STRING>
    "CHECKBOX",                                             //    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	[_displayName, format ["%1 will be distributed randomly across %2", _displayName, str _side]],
                                                            //    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
    [LSTRING(set_mainCat_ai), format ["%1 - %2", LLSTRING(set_subCat_cigsonai_sides), _side]],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	_defaultValue,					                        //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,										                //    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										                //    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									                //    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
