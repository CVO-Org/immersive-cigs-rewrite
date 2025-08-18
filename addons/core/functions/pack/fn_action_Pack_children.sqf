#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to return Child Actions for "Take Cig from Pack" Interaction - one child per type of cigpacks.
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

params ["_player"];

private _actions = [];

private _cigPacks = magazines _player select { getNumber (configFile >> "CfgMagazines" >> _x >> QPVAR(isPack)) == 1};
private _cigPacks = _cigPacks arrayIntersect _cigPacks;

{
    private _cigPack = _x;

    private _params = [_cigPack];
    private _code = {
        params ["_target", "_player", "_actionParams"];
        _actionParams params ["_class_cigpack"];
        [_player, _class_cigpack] call FUNC(takeFromPack);
    };
    
    private _action = [
        _cigPack            // * 0: Action name <STRING>
        ,getText (configFile >> "CfgMagazines" >> _cigPack >> "displayName")            //  * 1: Name of the action shown in the menu <STRING>
        ,getText (configFile >> "CfgMagazines" >> _cigPack >> "picture")                //  * 2: Icon <STRING> "\A3\ui_f\data\igui\cfg\simpleTasks\types\backpack_ca.paa"
        ,_code                                                                          //  * 3: Statement <CODE>
        ,{true}                                                                         //  * 4: Condition <CODE>
        ,{}                                                                             //  * 5: Insert children code <CODE> (Optional)
        ,_params                                                                        //  * 6: Action parameters <ANY> (Optional)
    ] call ace_interact_menu_fnc_createAction;
    _actions pushBack [_action, [], _target];
} forEach _cigPacks;

_actions

