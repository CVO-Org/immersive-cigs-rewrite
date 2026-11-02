#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3DEN attribute save for the per side package lists of the aiCigs module.
*
* Arguments:
* 0: Attribute controls group <CONTROL>
*
* Return Value:
* Selected classnames as stringified array <STRING>
*
* Example:
* [ _ctrlGroup ] call cigs_ai_fnc_packList_save
*
* Public: No
*/

params [
    [ "_ctrlGroup", controlNull, [controlNull] ]
];

private _selected = + ( _ctrlGroup getVariable [ QGVAR(unknown), [] ] );

{
    if ( cbChecked _x ) then { _selected pushBack ( _x getVariable QGVAR(className) ); };
} forEach ( _ctrlGroup getVariable [ QGVAR(checkboxes), [] ] );

str _selected
