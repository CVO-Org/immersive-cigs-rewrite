#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the default packages per side, resolved from the presets in cigs_ai_defaultPacks (see defaultPacks.hpp).
* Per side, the active preset with the highest priority that defines the side is used.
* Resolved once per game session and cached, as the loaded addons can not change.
*
* Arguments:
* 0: Side - "WEST", "EAST", "GUER" or "CIV" - empty to return all sides <STRING>
*
* Return Value:
* Classnames of the side <ARRAY of STRINGs>, or all sides <HASHMAP> - Key: side as string, Value: classnames
*
* Example:
* ["WEST"] call cigs_ai_fnc_getDefaultPacks
*
* Public: No
*/

params [
    [ "_side", "", [""] ]
];

private _map = [ QGVAR(defaultPacks), {

    // Active presets: all required addons loaded and condition met
    private _presets = ( "true" configClasses ( configFile >> QGVAR(defaultPacks) ) ) select {
        getArray ( _x >> "requiredAddons" ) findIf { !isClass ( configFile >> "CfgPatches" >> _x ) } isEqualTo -1
        &&
        {
            private _condition = getText ( _x >> "condition" );
            _condition isEqualTo "" || { call compile _condition }
        }
    };

    _presets = [ _presets, [], { getNumber ( _x >> "priority" ) }, "DESCEND" ] call BIS_fnc_sortBy;

    createHashMapFromArray ( [ "WEST", "EAST", "GUER", "CIV" ] apply {
        private _key = _x;
        private _index = _presets findIf { isArray ( _x >> _key ) };
        [ _key, if ( _index isEqualTo -1 ) then { [] } else { getArray ( _presets # _index >> _key ) } ]
    } )
} ] call EFUNC(core,getCached);

if ( _side isEqualTo "" ) exitWith { _map };

_map getOrDefault [ _side, [] ]
