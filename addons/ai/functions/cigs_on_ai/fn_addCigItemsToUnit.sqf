#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add packages based on hashmap to units.
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

params ["_unit"];

private _map = missionNamespace getVariable [QGVAR(cigsOnAI_hashmap), nil];

if ( isNull _unit || { isNil "_map" } ) exitWith {};

// Check if Unit has a Uniform Container

private _uniformContainer = uniformContainer _unit;
if (isNull _uniformContainer) exitWith {};


//Prep Possible Package Classes
private _packagePool = (_map get str side _unit);
if (_packagePool isEqualTo []) exitWith { ERROR_2("No Cigs enabled for %1 - %2",_unit,str side _unit) };


// Nested Array of ["Classname", AmmoCount, isSmokable]
private _consumables = [];
private _smokablesAmount = 0;

// Add Random Amount of Packages
for "_i" from 1 to (ceil random 3) do {
 
    private _packClassname = selectRandom _packagePool;
    if (isNil "_packClassname") then { ERROR_2("package nil - Unit %1 Side %2 undefined - Default: NIL Cigs",_unit,str side _unit); _packClassname = QEGVAR(nil,cigpack); };

    private _packCfg = (configFile >> "CfgMagazines" >> _packClassname);
 
    private _packageSize = getNumber ( _packCfg >> "count");
    private _packageSmokable = getNumber (configFile >> "CfgGlasses" >> (getText (_packCfg >> QPVAR(item_glasses))) >> QPVAR(isSmokable)) isEqualTo 1;
    
    private _ammoCount = ceil random [1, _packageSize * 0.66, _packageSize];

    if (_packageSmokable) then { _smokablesAmount = _smokablesAmount + _ammoCount; };

    _consumables pushBack [_packClassname, _ammoCount, _packageSmokable];
};

// Add lighter if any package is a smokeable
if ( _smokablesAmount isNotEqualTo 0 ) then {

    private _lighterClass = switch (true) do {
        case ( PVAR(isLoaded_SOG) ): { "vn_b_item_lighter_01" };
        case ( _smokablesAmount > 40 ): { QPVAR(lighter) };
        default { QPVAR(matches) };
    };

    private _lighterCfg = configFile >> "CfgMagazines" >> _lighterClass;
    private _lighterSize = getNumber (_lighterCfg >> "count");

    private _lighterAmount = 0;

    while { _lighterAmount < _smokablesAmount } do {

            
        private _amount = ceil random [1, _lighterSize * 0.66, _lighterSize];

        _lighterAmount = _lighterAmount + _amount;
        _consumables pushBack [ _lighterClass, _amount ];
    };
};

if (_consumables isEqualTo []) exitWith {};


// Add items to Uniform Container (Can Overfill)
{ _uniformContainer addMagazineAmmoCargo [_x#0, 1, _x#1]; } forEach _consumables;

// DynamicSmoking
_unit call FUNC(addUnitToFramework);
