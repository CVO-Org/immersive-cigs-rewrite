/*
* Author: Zorn
* Waits until a condition is true or the timeout has passed. Scheduled only.
* Uses uiSleep and diag_tickTime, so it keeps counting while the game is paused.
*
* Arguments:
* 0: Condition <CODE>
* 1: Timeout in seconds <NUMBER> (default: 10)
* 2: Arguments passed to the condition <ANY> (default: [])
*
* Return Value:
* Condition met <BOOL>
*
* Example:
* private _done = [{ ZEIC_queue isEqualTo [] }, 30] call autotest_fnc_waitFor;
*
* Public: No
*/

params [ ["_condition", { true }, [{}]], ["_timeout", 10, [0]], ["_args", []] ];

private _end = diag_tickTime + _timeout;
waitUntil {
    uiSleep 0.05;
    ( _args call _condition ) || { diag_tickTime > _end }
};

_args call _condition
