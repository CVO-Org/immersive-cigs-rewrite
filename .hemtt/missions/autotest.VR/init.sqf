// Autotest: run every suite once, then end the mission. init3DEN.sqf closes the game afterwards.
// To run the suites again from the debug console:  [] spawn autotest_fnc_runAll;
// To run some suites:                              [["example"]] spawn autotest_fnc_runAll;

if !( isServer ) exitWith {};

[] spawn {
    // let the mission and other mods settle (CBA settings, postInit)
    if ( isClass (configFile >> "CfgPatches" >> "cba_settings") ) then {
        [{ missionNamespace getVariable ["cba_settings_ready", false] }, 60] call autotest_fnc_waitFor;
    };
    uiSleep 1;

    private _failed = [] call autotest_fnc_runAll;

    // flag for init3DEN.sqf: the editor quits the game once the preview has ended
    uiNamespace setVariable ["autotest_done", true];
    endMission (["LOSER", "END1"] select (_failed isEqualTo 0));

    // uiSleep, not sleep: sleep stops while the game is paused
    uiSleep 10;
    diag_log text "[ AUTOTEST ]     mission still running 10 s after endMission - forcing the end";
    forceEnd;
};
