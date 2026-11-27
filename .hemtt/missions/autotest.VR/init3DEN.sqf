// Autotest: start the preview by itself, and close the game once the suites are done.
// hemtt launch opens this mission in the editor; nobody has to press Play, Continue or Exit.
// Verified chain (2026-11-27), see the arma3-autotest skill (references\unattended-launch.md):
// - do3DENAction "Exit3DEN" does nothing from script, and BIS_fnc_shutdown has no effect while the editor is open
// - scripts spawned here die with the editor, so the last step lives on the main menu display (0)
// To look around after a run instead of quitting, from the debug console:  uiNamespace setVariable ["autotest_keepOpen", true];

// once per game session: init3DEN.sqf runs again when the preview returns to the editor
if ( uiNamespace getVariable ["autotest_started", false] ) exitWith {};
uiNamespace setVariable ["autotest_started", true];

// back in the editor after the suites: close the editor, and let the main menu quit the game
add3DENEventHandler ["OnMissionPreviewEnd", {
    if !( uiNamespace getVariable ["autotest_done", false] ) exitWith {};
    if ( uiNamespace getVariable ["autotest_keepOpen", false] ) exitWith {
        diag_log text "[ AUTOTEST ]     keepOpen set - the game stays open";
    };

    [] spawn {
        uiSleep 1;

        // BIS_fnc_shutdown clicks the main menu's exit button - only works with the main menu on top
        ( findDisplay 0 ) displayAddEventHandler ["ChildDestroyed", {
            params ["_display", "_child", "_exitCode"];
            if ( ctrlIDD _child isNotEqualTo 313 ) exitWith {};
            diag_log text "[ AUTOTEST ]     editor closed - quitting the game";
            call BIS_fnc_shutdown;
        }];

        diag_log text "[ AUTOTEST ]     suites done - closing the editor";
        ( findDisplay 313 ) closeDisplay 2;
    };
}];

// start the preview a few seconds after the editor is up, so loading can catch up
[] spawn {
    waitUntil { !isNull findDisplay 313 };
    uiSleep 3;
    if !( is3DEN ) exitWith { diag_log text "[ AUTOTEST ]     the editor closed before the preview could start"; };
    diag_log text "[ AUTOTEST ]     starting the preview";
    do3DENAction "MissionPreview";
};
