/*
* Author: Zorn
* Runs the tests of every suite and writes the result. Scheduled only.
*
* A suite is a function in description.ext >> CfgFunctions >> autotest_suite that returns its tests:
*   [ [name <STRING>, code <CODE>, timeout in s <NUMBER> (default: 120)], ... ]
* Every test runs in its own spawned script and gets the suite's context hashmap: params ["_ctx"].
* A test that throws a script error or runs past its timeout fails; the next test still runs.
*
* Test ids are numbered by order: T<suite>.<test>, zero-padded to the number of suites and to the
* largest number of tests in one suite (T1.02, T12.7). The last line is the one tools\autotest.ps1 looks for:
* "[ AUTOTEST ] [ DONE  ] 10 / 12 successful - failed: 1 - skipped: 1"
*
* Arguments:
* 0: Only these suites <ARRAY of STRINGs> (default: [] = all)
*
* Return Value:
* Failed tests <NUMBER> (-1 when there were no tests)
*
* Example:
* [] spawn autotest_fnc_runAll;
* [["queue"]] spawn autotest_fnc_runAll;
*
* Public: No
*/

params [ ["_only", [], [[]]] ];

// ---------------------------------------------------------------- collect the tests (runs nothing yet)
private _suites = [];
{
    {
        private _name = configName _x;
        if ( _only isEqualTo [] || { _name in _only } ) then {
            private _tests = [] call ( missionNamespace getVariable ["autotest_suite_fnc_" + _name, {}] );
            if ( isNil "_tests" || { !(_tests isEqualType []) } ) then { _tests = [] };
            _suites pushBack [_name, _tests];
        };
    } forEach ( "true" configClasses _x );
} forEach ( "true" configClasses (missionConfigFile >> "CfgFunctions" >> "autotest_suite") );

private _total = 0;
private _most = 1;
{
    _total = _total + count (_x select 1);
    _most = _most max count (_x select 1);
} forEach _suites;

// id widths: by the number of suites and the largest suite
private _widthSuite = count str (count _suites max 1);
private _widthTest  = count str _most;
private _pad = {
    params ["_number", "_width"];
    private _text = str _number;
    while { count _text < _width } do { _text = "0" + _text };
    _text
};

// between tests, lines are headed AUTOTEST
autotest_currentId = nil;

[format ["%1 suites, total of %2 tests | %3", count _suites, _total, [] call autotest_fnc_banner], false, "INIT"] call autotest_fnc_log;

{
    if ( (_x select 1) isEqualTo [] ) then {
        [format ["suite '%1' has no tests (it must return an array of tests)", _x select 0], true] call autotest_fnc_log;
    };
} forEach _suites;

// ---------------------------------------------------------------- run them
private _counts = createHashMapFromArray [ ["PASSED", 0], ["FAILED", 0], ["SKIPPED", 0] ];

{
    _x params ["_suite", "_tests"];
    private _suiteNumber = [_forEachIndex + 1, _widthSuite] call _pad;
    private _ctx = createHashMapFromArray [ ["suite", _suite] ];

    {
        _x params [ ["_name", "", [""]], ["_code", {}, [{}]], ["_timeout", 120, [0]] ];

        autotest_currentId = format ["T%1.%2", _suiteNumber, [_forEachIndex + 1, _widthTest] call _pad];
        autotest_checks = [];
        autotest_testFinished = false;
        private _start = diag_tickTime;
        [_name, false, "BEGIN"] call autotest_fnc_log;

        // own script: a script error or a hang ends only this test
        private _handle = [_ctx, _code] spawn {
            params ["_ctx", "_code"];
            [_ctx] call _code;
            autotest_testFinished = true;
        };
        private _end = _start + _timeout;
        waitUntil { uiSleep 0.05; scriptDone _handle || { diag_tickTime > _end } };

        private _note = "";
        if !( scriptDone _handle ) then {
            terminate _handle;
            _note = format ["timeout after %1 s", _timeout];
        } else {
            if !( autotest_testFinished ) then { _note = "aborted - script error?" };
        };

        private _passed  = { _x isEqualTo "PASS" } count autotest_checks;
        private _failed  = { _x isEqualTo "FAIL" } count autotest_checks;
        private _skipped = { _x isEqualTo "SKIP" } count autotest_checks;

        private _result = call {
            if ( _note isNotEqualTo "" || { _failed > 0 } ) exitWith { "FAILED" };
            if ( _skipped > 0 ) exitWith { "SKIPPED" };
            if ( _passed > 0 ) exitWith { "PASSED" };
            _note = "no checks";
            "FAILED"
        };
        _counts set [_result, (_counts get _result) + 1];

        private _detail = [
            format [" (%1/%2 checks, %3 s%4)", _passed, _passed + _failed, round (diag_tickTime - _start), ["", " - " + _note] select (_note isNotEqualTo "")],
            ""
        ] select (_result isEqualTo "SKIPPED");
        [format ["Result: %1%2", _result, _detail], _result isEqualTo "FAILED", "END"] call autotest_fnc_log;
    } forEach _tests;
} forEach _suites;

autotest_currentId = nil;

private _failedTests = _counts get "FAILED";
private _done = format ["%1 / %2 successful - failed: %3 - skipped: %4",
    _counts get "PASSED", _total, _failedTests, _counts get "SKIPPED"
];
[_done, true, "DONE"] call autotest_fnc_log;
hint _done;

[_failedTests, -1] select (_total isEqualTo 0)
