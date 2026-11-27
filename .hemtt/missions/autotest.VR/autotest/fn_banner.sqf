/*
* Author: Zorn
* The test environment as text: game version, terrain and which common mods are loaded.
* Part of the "Init Autotest" line, to tell "failed" apart from "ran with another modset" in an old RPT.
*
* Arguments:
* None
*
* Return Value:
* Environment <STRING>
*
* Example:
* [] call autotest_fnc_banner; // "2.22.154089 | VR | CBA, ACE, ZEN"
*
* Public: No
*/

private _mods = [
    ["CBA",   "cba_main"],
    ["ACE",   "ace_main"],
    ["ZEN",   "zen_common"],
    ["RHS",   "rhs_main"],
    ["CUP",   "CUP_Editor_Buildings_Config"],
    ["GM",    "gm_core"],
    ["SOGPF", "weapons_f_vietnam_c"]
] select { isClass (configFile >> "CfgPatches" >> (_x select 1)) } apply { _x select 0 };

format ["%1.%2 | %3 | %4",
    (productVersion select 2) / 100,
    productVersion select 3,
    worldName,
    [_mods joinString ", ", "no mods"] select (_mods isEqualTo [])
]
