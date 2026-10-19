// AI cigs test settings
// Runs before the aiCigs queue starts processing (5s after the first unit is queued), so the units placed in the mission get the chance roll with these values.
// The aiCigs settings are global (isGlobal = 1), so the server source is used - a client value would be ignored.
// Note: Changes server settings, which are stored in the profile.
if (!isServer) exitWith {};

["cigs_ai_set_aiCigs_enable", true, nil, "server"] call CBA_settings_fnc_set;
["cigs_ai_set_aiCigs_chance", 1,    nil, "server"] call CBA_settings_fnc_set;
["cigs_ai_set_aiCigs_delay",  5,    nil, "server"] call CBA_settings_fnc_set;
{ [format ["cigs_ai_set_aiCigs_side_enabled_%1", _x], true, nil, "server"] call CBA_settings_fnc_set; } forEach ["WEST","EAST","GUER","CIV"];

diag_log text format ["[cigs][test] AI cigs test settings applied - chance: %1 - delay: %2", cigs_ai_set_aiCigs_chance, cigs_ai_set_aiCigs_delay];
systemChat "AI cigs test settings applied";
