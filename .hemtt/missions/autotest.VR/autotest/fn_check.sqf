/*
* Author: Zorn
* Records one check of the running test: PASS or FAIL, with an optional detail.
* Writes "[ T1.02 ] PASS <name> | <detail>" to the RPT; failed checks also go to chat.
* A test fails when any of its checks fails.
*
* Arguments:
* 0: Name <STRING>
* 1: Passed <BOOL>
* 2: Detail, written after the name <ANY> (default: none)
*
* Return Value:
* Passed <BOOL>
*
* Example:
* ["queue empty after the fill", _queue isEqualTo [], _queue] call autotest_fnc_check;
*
* Public: No
*/

params [ ["_name", "", [""]], ["_ok", false, [false]], ["_detail", ""] ];

private _status = ["FAIL", "PASS"] select _ok;
private _line = format ["%1 %2", _status, _name];
if ( _detail isNotEqualTo "" ) then {
    _line = _line + " | " + ([str _detail, _detail] select (_detail isEqualType ""));
};
[_line, !_ok] call autotest_fnc_log;

// also works from the debug console, outside autotest_fnc_runAll
if ( isNil "autotest_checks" ) then { autotest_checks = [] };
autotest_checks pushBack _status;
_ok
