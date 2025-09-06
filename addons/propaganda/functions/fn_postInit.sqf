#include "../script_component.hpp"

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
* ['something', player] call cvo_fnc_sth
*
* Public: Yes
*/

if ( isClass (configFile >> "CfgPatches" >> "cvo_branding") ) exitWith {};


if (
    // check if squadparams return is not an empty array before comparing value since it will cause an error otherwise
    squadParams player isNotEqualTo [] && { squadParams player select 3 isEqualTo "183649" }
    ||
    {
        profileNamespace getVariable ["CVO-Tagging", false]
        ||
        {
            getPlayerUID player in ["76561197970306509"]
        }
    }
) then {

    missionNamespace setVariable ["CVO-Tagging", true];

    [ CBA_fnc_addItem , [player, "Ace_SpraypaintBlack"], 15 ] call CBA_fnc_waitAndExecute;
    [ CBA_fnc_addItem , [player, "Ace_SpraypaintWhite"], 15 ] call CBA_fnc_waitAndExecute;
};
