// Smoking Habbits of the individual player
[
	QSET(smoking_intensity),									//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"LIST",														//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(smoking_intensity),
																//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_habits_smoking)], 	//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	// 
	[[0.75, 1.00, 1.25, 1.50], [ LLSTRING(set_smoking_intensity_entry_short), LLSTRING(set_smoking_intensity_entry_normal), LLSTRING(set_smoking_intensity_entry_long), LLSTRING(set_smoking_intensity_entry_thomas) ], 1],										
																//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,															//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},															//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false														//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(smoking_frequency),									//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"LIST",														//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(smoking_frequency),
																//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_habits_smoking)], 	//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	// 
	[[0.66, 1.00, 1.33, 1.66], [ LLSTRING(set_smoking_frequency_entry_less), LLSTRING(set_smoking_frequency_entry_normal), LLSTRING(set_smoking_frequency_entry_often), LLSTRING(set_smoking_frequency_entry_thomas) ], 1],										
																//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,															//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},															//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false														//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


// Singleplayer setLightnings
[
	QSET(sp_addItems),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(sp_addItems),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_sp)],				//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	false,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	2,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


private _code = {
	_displayName = getText ( _x >> "displayName" );

	switch (configName _x) do {
		case "vn_b_item_lighter_01": { _displayName = "Savage " + _displayName };
	};
	_displayName
};


// Auto-Detect Possible Cig Packs (including suckers)
private _cfgs = ["LIGHTERS", true] call FUNC(getAllItems);
private _array_lighters = [ _cfgs apply { configName _x }, _cfgs apply _code, 0 ];



[
	QSET(sp_addLighter),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(sp_addLighter),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_sp)],		//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	2,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(sp_addLighter_type),				//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"LIST",									//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(sp_addLighter_type),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_sp)],		//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	_array_lighters,						//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	2,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(sp_addCigpack),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(sp_addCigpack),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_sp)],					//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	2,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


// Auto-Detect Possible Cig Packs (including suckers)
private _cfgs = ["PACKAGES", true] call FUNC(getAllItems);
private _array_packs = [ _cfgs apply { configName _x }, _cfgs apply { getText ( _x >> "displayName" ) }, 0 ];

[
	QSET(sp_addCigpack_type),				//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"LIST",									//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(sp_addCigpack_type),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_sp)],		//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	_array_packs,							//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	2,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

// Ace Arsenal Tab
private _aceLoaded = isClass (configFile >> "CfgPatches" >> "ace_arsenal");

if (_aceLoaded) then {
	[
		QSET(ace_arsenal_tab),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
		"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
		SETLSTRING(ace_arsenal_tab),
												//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
		[LSTRING(set_mainCat_player),LSTRING(set_subCat_ace_arsenal)],		//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
		true,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
		0,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
		FUNC(arsenalTab),		//    _script      - Script to execute when setting is changed. (optional) <CODE>
		false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
	] call CBA_fnc_addSetting;
};


// Smoke Particle Intensity
[
	QSET(smoke_particles),							//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",										//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(effect_smoke_particles),
													//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_player),LSTRING(set_subCat_effects)], //    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[0.01, 1, 1, 2, true],						    //    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	0,												//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},												//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false											//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;
