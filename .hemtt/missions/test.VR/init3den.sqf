// Eden editor init - runs every time the mission is opened in 3DEN (also when returning from a preview).
// The faction list only runs once per game session: the flag lives in uiNamespace, which survives mission reloads.
if ( uiNamespace getVariable ["cigs_test_factionList_done", false] ) exitWith {};
uiNamespace setVariable ["cigs_test_factionList_done", true];

[] call compileScript ["tests\factionList.sqf"];
