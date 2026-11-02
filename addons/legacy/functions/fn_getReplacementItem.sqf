#include "..\script_component.hpp"
/*
 * Author: DartRuffian
 * Checks for a replacement item for a given class. Replacement class must be of the same type as the original.
 *
 * Arguments:
 * 0: Deprecated class name <STRING>
 *
 * Return Value:
 * Replacement class, or original class name if none is found <STRING>
 *
 * Example:
 * ["TAG_myDeprecatedClass"] call cigs_legacy_fnc_getReplacementItem;
 *
 * Public: No
 */

params ["_class"];

[configFile >> QPVAR(replacementItems), _class, _class] call BIS_fnc_returnConfigEntry;
