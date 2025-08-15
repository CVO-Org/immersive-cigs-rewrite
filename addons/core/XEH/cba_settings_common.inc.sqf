// Adv. Fatigue
[
	QSET(adv_fatigue_enabled),						//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(adv_fatigue_enabled),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_common), localize "STR_ACE_Advanced_Fatigue_DisplayName"], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,											//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	FUNC(adv_fatigue_enable),						//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(adv_fatigue_modifier),						//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(adv_fatigue_modifier),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_common), localize "STR_ACE_Advanced_Fatigue_DisplayName"], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[0.10, 3, 1, 0, true],							//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},						//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(adv_fatigue_cough_modifier),				//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(adv_fatigue_cough_modifier),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_common), localize "STR_ACE_Advanced_Fatigue_DisplayName"], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[0.0, 3, 1, 0, true],							//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},						//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(adv_fatigue_decrease_delay),						//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(adv_fatigue_decrease_delay),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_common), localize "STR_ACE_Advanced_Fatigue_DisplayName"], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[1, 30, 5, 0, false],							//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},												//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


// Effects
[
	QSET(effect_combustion_chance),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(effect_combustion_chance),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_common),LSTRING(set_subCat_effects)], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[0, 1, 0.1, 2, true],						//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},												//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
