// Common Settings
// https://github.com/CBATeam/CBA_A3/wiki/CBA-Settings-System#setting-type-specific-arguments-_valueinfo

[
	QSET(dynamicSmoking_enable),												//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",																	//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(dynamicSmoking_enable),
																				//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_dynamicAiSmoking)],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,																		//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,																			//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	FUNC(AI_loop_start),														//    _script      - Script to execute when setting is changed. (optional) <CODE>
	true																		//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
	QSET(dynamicSmoking_slot),												//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"LIST",																	//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(dynamicSmoking_slot),
																				//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_dynamicAiSmoking)],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[["GOGGLES", "HMD", "RANDOM"],["GOGGLES", "HMD", "RANDOM"],0],				//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,																			//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},																			//    _script      - Script to execute when setting is changed. (optional) <CODE>
	true																		//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
	QSET(dynamicSmoking_slot_remove),												//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",																	//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(dynamicSmoking_slot_remove),
																				//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_dynamicAiSmoking)],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,																		//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,																			//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},																			//    _script      - Script to execute when setting is changed. (optional) <CODE>
	true																		//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


[
	QSET(dynamicSmoking_min_time),												//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",																	//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(dynamicSmoking_min_time),
																				//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_dynamicAiSmoking)],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[ 5, 60, 15, 0 ],															//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,																			//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},																			//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false																		//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
