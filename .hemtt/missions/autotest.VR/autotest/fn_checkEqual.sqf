/*
* Author: Zorn
* Records one check that compares a value with the expected one (isEqualTo).
* A failed check shows both: "got X, expected Y".
*
* Arguments:
* 0: Name <STRING>
* 1: Got <ANY>
* 2: Expected <ANY>
*
* Return Value:
* Passed <BOOL>
*
* Example:
* ["five houses furnished", _furnished, 5] call autotest_fnc_checkEqual;
*
* Public: No
*/

params [ ["_name", "", [""]], "_got", "_expected" ];

private _ok = _got isEqualTo _expected;
[
    _name,
    _ok,
    ["", format ["got %1, expected %2", _got, _expected]] select !_ok
] call autotest_fnc_check
