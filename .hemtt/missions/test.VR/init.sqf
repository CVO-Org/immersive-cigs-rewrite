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


// Tests - see tests\. They run once at mission start, one after the other, never side by side:
// 1. aiPresets:    the level order, by asking getCigItems directly (waits for the CBA settings, then 5 s)
// 2. liveFactions: one unit per faction through the real chain, with the mission's module cleared
// 3. officers:     every unit class with cigs_packsExtra[] (the officer presets of the loaded mods), config and live
// 4. slotSwap:     the player's own facewear / NVG slot (#295), about 2 minutes
// Each test adds its failures to cigs_test_failed; the runner reports them per test and in a summary at the end.
// To run one again, from the debug console (server): [] spawn cigs_test_fnc_officers; (or _aiPresets, _liveFactions, _slotSwap)
// To run all again: [] spawn cigs_test_fnc_runAll;
cigs_test_list = ["aiPresets", "liveFactions", "officers", "slotSwap"];
{ missionNamespace setVariable ["cigs_test_fnc_" + _x, compileScript ["tests\" + _x + ".sqf"]]; } forEach cigs_test_list;

cigs_test_fnc_runAll = {
    private _log = { params ["_line"]; diag_log text ("[cigs][test] " + _line); systemChat _line; };
    cigs_test_failed = 0;
    private _results = [];
    private _start = time;

    {
        private _before = cigs_test_failed;
        private _t = time;
        [format ["==== %1 (%2/%3) ====", _x, _forEachIndex + 1, count cigs_test_list]] call _log;
        [] call (missionNamespace getVariable ("cigs_test_fnc_" + _x));
        private _failed = cigs_test_failed - _before;
        _results pushBack [_x, _failed, round (time - _t)];
        [format ["==== %1: %2 ====", _x, ["PASSED", format ["%1 FAILED", _failed]] select (_failed > 0)]] call _log;
    } forEach cigs_test_list;

    ["==== Summary ===="] call _log;
    { _x params ["_name", "_failed", "_secs"]; [format ["%1  %2 (%3 s)", ["PASS", "FAIL"] select (_failed > 0), _name, _secs]] call _log; } forEach _results;
    private _summary = format ["All tests: %1 failed, %2 s", cigs_test_failed, round (time - _start)];
    [_summary] call _log;
    hint _summary;
};

[] spawn {
    [] call cigs_test_fnc_runAll;

    // Autotest (tools\autotest.ps1 starts the game with -autotest): the mission ends as END1 when no test failed, else
    // LOSER. The game then quits and writes a failure to the RPT (<AutoTest result=...>).
    if (isAutotest) then {
        diag_log text format ["[cigs][test] ---- Autotest done: %1 failed ----", cigs_test_failed];
        // uiSleep, not sleep: sleep stops while the game is paused (e.g. the window lost focus), and the game would never quit
        private _end = ["LOSER", "END1"] select (cigs_test_failed isEqualTo 0);
        endMission _end;
        uiSleep 10;
        diag_log text "[cigs][test] Mission still running 10 s after endMission - forcing the end";
        forceEnd;
    };
};
