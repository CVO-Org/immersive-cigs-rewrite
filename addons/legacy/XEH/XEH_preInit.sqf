#include "../script_component.hpp"


/*	here, you put in your CBA Settings so they are available in the editor!
https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#create-a-custom-setting-for-mission-or-mod

[
	QSET(displayMusic),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	["Display Music Title","This enables the message of the currently played music title by the CVO Music System"],
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	["CVO", "CVO Music"],					//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	false,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
*/

[
	QSET(loudout_replacer_enable_personal),						//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",													//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(loudout_replacer_enable_personal),
																//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[ELSTRING(core,set_mainCat_common), LSTRING(set_subCat_loadout)],	//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,														//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,															//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},															//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false														//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(loudout_replacer_enable_mission),						//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",													//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(loudout_replacer_enable_mission),
																//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[ELSTRING(core,set_mainCat_common), LSTRING(set_subCat_loadout)],	//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,														//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,															//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},															//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false														//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
