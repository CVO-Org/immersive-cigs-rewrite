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

// Holsters the weapon before using the lighter, but only if its a player and the setting is enabled and its not already holstered
if ( SET(require_holstered_weapon) && {currentWeapon _unit != ""} ) then {

    private _weaponState = weaponState _unit;
    _weaponState resize 3;
    _unit setVariable [QGVAR(lighter_weaponState), _weaponState];

    // 1. Put weapon on back
    [_unit] call FUNC(putWeaponAway);

    // 2. Wait until weapon is on the back
    private _condition = { gestureState _unit select [1, 3] isNotEqualTo "mov" };
    private _statement = {
        params ["_unit", "_force"];

        if !(lifeState _unit in ["HEALTHY", "INJURED"]) exitWith {};
        // 3. Use Lighter
        [_unit, _force] call FUNC(useLighter);
        [_unit] call FUNC(smoking_start);

        // 4. Add Event Handler: Gesture Done: cig_in.
        _unit addEventHandler ["GestureDone", {
            params ["_unit", "_gesture"];

            if (_gesture isNotEqualTo QEGVAR(anim,cig_in)) exitWith {};

            // Remove current EH
            _unit removeEventHandler [_thisEvent, _thisEventHandler];

            // 5. Reqeuip weapon.
            if (_unit isNil QGVAR(lighter_weaponState)) exitWith {};
            _unit selectWeapon (_unit getVariable QGVAR(lighter_weaponState));
            _unit setVariable [QGVAR(lighter_weaponState), nil];
        }];
    };
    [ _condition, _statement, [_unit, _force], 2,_statement] call CBA_fnc_waitUntilAndExecute;

} else {

    [_unit, _force] call FUNC(useLighter);
    [_unit] call FUNC(smoking_start);

};
