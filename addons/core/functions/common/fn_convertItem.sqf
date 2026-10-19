#include "../../script_component.hpp"

/*
* Author: Zorn
* Converts a smokable/suckable item between its facewear (CfgGlasses) and NVG (CfgWeapons) version.
* The original item is removed by the CBA context menu (consume).
*
* Equipped items are moved into the other slot if it's free, otherwise into the inventory (or onto the ground).
* Items in a container are converted within that container.
*
* Arguments:
* 0: Unit <OBJECT>
* 1: Container <OBJECT>
* 2: Item classname <STRING>
* 3: Slot - "GOGGLES", "HMD" or a container slot <STRING>
*
* Return Value:
* None
*
* Example:
* [player, objNull, "cigs_morley_cig0", "GOGGLES"] call cigs_core_fnc_convertItem
*
* Public: No
*/

params [ "_unit", "_container", "_item", "_slot" ];

// Facewear -> NVG: append "_nv" - NVG -> Facewear: remove "_nv"
private _toHMD = switch (_slot) do {
    case "GOGGLES": { true };
    case "HMD":     { false };
    default         { isClass (configFile >> "CfgGlasses" >> _item) };
};
private _newItem = if (_toHMD) then { _item + "_nv" } else { _item select [0, count _item - 3] };

switch (true) do {
    // Equipped: into the other slot if it's free
    case ( _slot isEqualTo "GOGGLES" && { hmd _unit isEqualTo "" } ): { _unit linkItem _newItem; };
    case ( _slot isEqualTo "HMD" && { goggles _unit isEqualTo "" } ): { _unit addGoggles _newItem; };
    // In a container: stay in that container
    case ( !(_slot in ["GOGGLES", "HMD"]) && { _container isEqualType objNull && { !isNull _container } } ): { _container addItemCargoGlobal [_newItem, 1]; };
    // Otherwise: inventory, or the ground when it's full
    default { [_unit, _newItem, true] call CBA_fnc_addItem; };
};
