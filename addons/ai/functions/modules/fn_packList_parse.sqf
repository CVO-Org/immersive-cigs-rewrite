#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Parses the value of a package list attribute of the aiCigs module.
* Supports the stringified array of the checkbox list and the legacy comma / space separated list of older missions.
*
* Arguments:
* 0: Attribute value <STRING>
*
* Return Value:
* Classnames <ARRAY of STRINGs>
*
* Example:
* "[""cigs_morley_cigpack""]" call cigs_ai_fnc_packList_parse
*
* Public: No
*/

params [
    [ "_value", "", [""] ]
];

if ( _value select [0, 1] isEqualTo "[" ) exitWith { parseSimpleArray _value };

_value splitString " ,"
