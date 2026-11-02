#include "..\..\script_component.hpp"

/*
* Author: Zorn
* "Select all" / "Deselect all" buttons of the per side package lists of the aiCigs module.
*
* Arguments:
* 0: Button <CONTROL>
* 1: Checked <BOOL>
*
* Return Value:
* None
*
* Example:
* [ _ctrlButton, true ] call cigs_ai_fnc_packList_setAll
*
* Public: No
*/

params [
    [ "_ctrlButton", controlNull, [controlNull] ],
    [ "_checked",    true,        [true]        ]
];

{ _x cbSetChecked _checked; } forEach ( ctrlParentControlsGroup _ctrlButton getVariable [ QGVAR(checkboxes), [] ] );

nil
