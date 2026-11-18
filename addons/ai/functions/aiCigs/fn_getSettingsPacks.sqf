#include "..\..\script_component.hpp"

/*
* Author: Zorn
* Returns the packages per side, as ticked in the pack selection CBA settings (cigs_ai_set_aiCigs_packSelection_<SIDE>_<classname>).
* Built on demand and cached in cigs_aiCigs_settings - any change of those settings clears the cache.
* Whether the settings are used at all is up to cigs_ai_set_aiCigs_packSelection_enable, see cigs_ai_fnc_getCigItems.
*
* Arguments:
* None
*
* Return Value:
* Packages per side <HASHMAP> - Key: side as string, Value: classnames - sides without ticked packs have an empty array
*
* Example:
* [] call cigs_ai_fnc_getSettingsPacks
*
* Public: No
*/

private _map = missionNamespace getVariable QEGVAR(aiCigs,settings);
if ( !isNil "_map" ) exitWith { _map };

private _packs = ["PACKAGES"] call EFUNC(core,getAllItems);

_map = createHashMapFromArray (
    [ "WEST", "EAST", "GUER", "CIV" ] apply {
        private _sideStr = _x;
        [
            _sideStr,
            _packs select { missionNamespace getVariable [ [QSET(aiCigs_packSelection), _sideStr, _x] joinString "_", false ] }
        ]
    }
);

EGVAR(aiCigs,settings) = _map;

_map
