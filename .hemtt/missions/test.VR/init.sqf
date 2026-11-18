// Test functions - see tests\. Compiled everywhere, as the actions call them on the client and they hand over to the server.
cigs_test_fnc_aiPresets      = compileScript ["tests\aiPresets.sqf"];
cigs_test_fnc_spawnFactions  = compileScript ["tests\spawnFactions.sqf"];
cigs_test_fnc_reportFactions = compileScript ["tests\reportFactions.sqf"];

// Actions (scroll menu) for the player
if (hasInterface) then {
    [] spawn {
        waitUntil { !isNull player };
        player addAction ["<t color='#c0a060'>Cigs test: check AI pack levels</t>",      { [] remoteExec ["cigs_test_fnc_aiPresets", 2] }, nil, 0.5, false, true];
        player addAction ["<t color='#c0a060'>Cigs test: spawn one unit per faction</t>", { [getPosATL player, getDir player] remoteExec ["cigs_test_fnc_spawnFactions", 2] }, nil, 0.4, false, true];
        player addAction ["<t color='#c0a060'>Cigs test: report the faction row</t>",    { [] remoteExec ["cigs_test_fnc_reportFactions", 2] }, nil, 0.3, false, true];
    };
};

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

// Check the AI pack levels once at mission start (the script waits for the CBA settings, then 5 s)
[] spawn cigs_test_fnc_aiPresets;
