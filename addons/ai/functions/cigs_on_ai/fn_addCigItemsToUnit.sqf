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

// Add cig package to unit
private _package = selectRandom (_map get str side _unit);
if (isNil "_package") exitWith { ERROR_2("package nil - Unit %1 Side %2 undefined",_unit,str side _unit) };

private _packageSize = getNumber ( configFile >> "CfgMagazines" >> _package >> "count");
private _remove_amount = floor random _packageSize;
_unit addMagazine [_package, _packageSize - _remove_amount];


private _item = getText ( configFile >> "CfgMagazines" >> _package >> QPVAR(item_glasses) );
private _isSmokeable = getNumber ( configFile >> "CfgGlasses" >> _item >> QPVAR(isSmokable) ) == 1;


// Add lighter is the Package is a smokeable
if (_isSmokeable) then {

    GVAR(dynamicSmoking_units) pushBack _unit;

    _remove_amount = _remove_amount + ceil (random 0.3 * _remove_amount);
    private _lighterCfg = selectRandom (["LIGHTERS", true] call cigs_core_fnc_getAllItems);
    private _lighterSize = getNumber (_lighterCfg >> "count");
    while { _lighterSize < _remove_amount } do { _remove_amount = _remove_amount - _lighterSize };
    _unit addMagazine [configName _lighterCfg, _lighterSize - _remove_amount];
};
