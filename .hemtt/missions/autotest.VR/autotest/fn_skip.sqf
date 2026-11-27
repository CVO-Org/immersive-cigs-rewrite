/*
* Author: Zorn
* Marks the running test as skipped: it can't run here (a mod, DLC or terrain is missing).
* A skipped test counts neither as successful nor as failed. Leave the test right after (exitWith).
*
* Arguments:
* 0: Reason <STRING>
*
* Return Value:
* None
*
* Example:
* if !( isClass (configFile >> "CfgPatches" >> "zen_common") ) exitWith { ["ZEN not loaded"] call autotest_fnc_skip };
*
* Public: No
*/

params [ ["_reason", "", [""]] ];

[format ["SKIP %1", _reason]] call autotest_fnc_log;
if ( isNil "autotest_checks" ) then { autotest_checks = [] };
autotest_checks pushBack "SKIP";
