/*
* Author: Zorn
* Writes one line to the RPT, headed by the running test's id (or AUTOTEST between tests):
*   [ T1.02    ] [ BEGIN ] <line>     with a tag
*   [ T1.02    ]     <line>           without a tag: a message, indented
* Both columns have a fixed width, so the lines align. tools\autotest.ps1 reads these lines.
*
* Arguments:
* 0: Line <STRING>
* 1: Also show in chat <BOOL> (default: false)
* 2: Tag, e.g. "BEGIN" <STRING> (default: "" = an indented message)
*
* Return Value:
* None
*
* Example:
* ["spawned 5 houses"] call autotest_fnc_log;
*
* Public: No
*/

params [ ["_line", "", [""]], ["_chat", false, [false]], ["_tag", "", [""]] ];

// pad to a fixed width with spaces on the right
private _fit = {
    params ["_text", "_width"];
    while { count _text < _width } do { _text = _text + " " };
    _text
};

private _head = [missionNamespace getVariable ["autotest_currentId", "AUTOTEST"], 8] call _fit;
private _body = [
    "    " + _line,
    format ["[ %1 ] %2", [_tag, 5] call _fit, _line]
] select (_tag isNotEqualTo "");

private _full = format ["[ %1 ] %2", _head, _body];
diag_log text _full;
if ( _chat ) then { systemChat _full };
