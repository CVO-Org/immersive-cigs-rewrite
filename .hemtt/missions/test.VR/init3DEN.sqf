// Autotest (tools\autotest.ps1 starts the game with -autotest): hemtt launch opens this mission in the editor, where it
// would wait for someone to press Play. Start the preview from here instead - once per game session, a few seconds after
// the editor is up. init.sqf runs the tests in the preview and ends the mission, and the game then quits.
// Without -autotest (a normal hemtt launch) this does nothing.
if (!isAutotest) exitWith {};
if (uiNamespace getVariable ["cigs_test_autotestPreviewStarted", false]) exitWith {};
uiNamespace setVariable ["cigs_test_autotestPreviewStarted", true];

// init3DEN.sqf can't suspend: wait in a spawned script. uiSleep, not sleep: the editor has no mission time.
[] spawn {
    waitUntil { !isNull findDisplay 313 };
    uiSleep 5;
    if (!is3DEN) exitWith { diag_log text "[cigs][test] Autotest: the editor closed before the preview could start"; };
    diag_log text "[cigs][test] Autotest: starting the preview from the editor";
    do3DENAction "MissionPreview";
};
