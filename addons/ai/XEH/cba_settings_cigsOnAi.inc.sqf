
// Common Settings

[
	QSET(cigsonai_enable),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"CHECKBOX",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(cigsonai_enable),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_cigsonai)],			//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	true,									//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	true									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(cigsonai_chance),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(cigsonai_chance),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_cigsonai)],				//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[0,1,0.33,0, true],						//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;

[
	QSET(cigsonai_delay),					//    _setting     - Unique setting name. Matches resulting variable name <STRING>
	"SLIDER",								//    _settingType - Type of setting. Can be "CHECKBOX", "EDITBOX", "LIST", "SLIDER" or "COLOR" <STRING>
	SETLSTRING(cigsonai_delay),
											//    _title       - Display name or display name + tooltip (optional, default: same as setting name) <STRING, ARRAY>
	[LSTRING(set_mainCat_ai), LSTRING(set_subCat_cigsonai)],				//    _category    - Category for the settings menu + optional sub-category <STRING, ARRAY>
	[5,120,5,0, false],					//    _valueInfo   - Extra properties of the setting depending of _settingType. See examples below <ANY>
	1,										//    _isGlobal    - 1: all clients share the same setting, 2: setting can't be overwritten (optional, default: 0) <NUMBER>
	{},										//    _script      - Script to execute when setting is changed. (optional) <CODE>
	false									//    _needRestart - Setting will be marked as needing mission restart after being changed. (optional, default false) <BOOL>
] call CBA_fnc_addSetting;


// Enable individual Sides
{
	private _sideStr = str _x;

	[
		[Q(ADDON), "set", "cigsonai", "side", "enabled", _sideStr] joinString "_",
		"CHECKBOX",
		[format [LLSTRING(set_cigsonai_side_enabled), _sideStr], format [LLSTRING(set_cigsonai_side_enabled_desc), _sideStr]],
		[LSTRING(set_mainCat_ai), LSTRING(set_subCat_cigsonai_sides_enabled)],
		true,
		1,
		{},
		true
	] call CBA_fnc_addSetting;

} forEach [west,east,independent,civilian];


// Select Cigs based on Side
{ [_x] call FUNC(cbaSetting_perSide); } forEach [west,east,independent,civilian];
