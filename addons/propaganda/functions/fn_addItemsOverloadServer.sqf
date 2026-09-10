#include "..\script_component.hpp"

/*
* Author: Zorn
* Function to add an item to a container and if needed, increases the size of said container.
*
* Arguments:
* _container
* _item
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

if (!isServer) exitWith {};

params [ "_container", "_items" ];

// Get Additional Mass
private _addedLoad = 0;
{
    private _mass = getNumber (configFile >> "CfgWeapons" >> _x >> "ItemInfo" >> "mass");
    if (_mass == 0) then { _mass = getNumber (configFile >> "CfgMagazines" >> _x >> "mass") };
    _addedLoad = _addedLoad + _mass;
} forEach _items;

// Check load capacity
private _totalLoadNeeded = loadAbs _container + _addedLoad;
if (_totalLoadNeeded > maxLoad _container) then { _container setMaxLoad _totalLoadNeeded; };

// Add items
{ _container addItemCargoGlobal [_x, 1] } forEach _items;
