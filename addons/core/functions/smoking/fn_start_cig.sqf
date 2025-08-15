#include "../../script_component.hpp"

/*
* Author: Zorn
* [Description]
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* [this, true] call cigs_core_fnc_start_cig; // the be used to start ai's cig, overwriting the need and usage for lighters.
*
* Public: No
*/

params ["_unit", ["_force", false, [true]]];

if (!_force && { !([_unit] call FUNC(hasLighter)) } ) exitWith {};


// Holsters the weapon before using the lighter
if ( SET(require_holstered_weapon) && {currentWeapon _unit != ""} ) then {

    [_unit] call FUNC(putWeaponAway);
    // Nested Wait Until
    // 1. Wait until animation phase is not 0 and the "put weapon on back" animation has started"
    // 2. Wait until animation phase is 0 again and the "put weapon on back" animation is done
    [
        {
            getUnitMovesInfo (_this#2#0) select 5 isNotEqualTo 0
        },
        CBA_fnc_waitUntilAndExecute,
        [
            {
                getUnitMovesInfo (_this#0) select 5 isEqualTo 0
                
            },
            {
                params ["_unit", ["_force", false, [true]]];
                [_unit, _force] call FUNC(useLighter);
                [_unit] call FUNC(smoking_start);
            },
            _this,
            3
        ],
        2,
        CBA_fnc_waitUntilAndExecute
    ] call CBA_fnc_waitUntilAndExecute;

} else {

    [_unit, _force] call FUNC(useLighter);
    [_unit] call FUNC(smoking_start);

};
