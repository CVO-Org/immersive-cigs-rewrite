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

if (isNil "_map") exitWith {};

private _consumables = [];

for "_i" from 1 to (ceil random 3) do {
    // Add cig package to unit
    private _array = (_map get str side _unit);
    if (_array isEqualTo []) exitWith { ERROR_1("array empty - No Cigs enabled for %1",str side _unit) };
    private _package = selectRandom _array;
    if (isNil "_package") then {
        ERROR_2("package nil - Unit %1 Side %2 undefined - Default: NIL Cigs",_unit,str side _unit);
        _package = QEGVAR(nil,cigpack);
    };

    private _packageSize = getNumber ( configFile >> "CfgMagazines" >> _package >> "count");

    private _remove_amount = floor random _packageSize;
    _unit addMagazine [_package, _packageSize - _remove_amount];

    _consumables pushBack ( getText ( configFile >> "CfgMagazines" >> _package >> QPVAR(item_glasses) ) );
};



// Add lighter is a Package is a smokeable
if ( _consumables findIf { getNumber ( configFile >> "CfgGlasses" >> _x >> QPVAR(isSmokable) ) == 1 } isNotEqualTo -1 ) then {

    for "_i" from 1 to (ceil random 3) do {
        private _lighterCfg = selectRandom (["LIGHTERS", true] call cigs_core_fnc_getAllItems);
        private _lighterSize = getNumber (_lighterCfg >> "count");
        private _removeAmount = round random _lighterSize;
        _unit addMagazine [configName _lighterCfg, _lighterSize - _removeAmount];
    };
};

// DynamicSmoking
_unit call FUNC(addUnitToFramework);
