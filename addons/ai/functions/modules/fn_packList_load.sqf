#include "..\..\script_component.hpp"

/*
* Author: Zorn
* 3DEN attribute load for the per side package lists of the aiCigs module.
* Fills the list with one checkbox per package. Checked = package will be distributed.
*
* Arguments:
* 0: Attribute controls group <CONTROL>
* 1: Attribute value - selected classnames as stringified array, or legacy comma separated list <STRING>
*
* Return Value:
* None
*
* Example:
* [ _ctrlGroup, "[]" ] call cigs_ai_fnc_packList_load
*
* Public: No
*/

params [
    [ "_ctrlGroup", controlNull, [controlNull] ],
    [ "_value",     "",          [""]          ]
];

private _display = ctrlParent _ctrlGroup;
private _ctrlList = _ctrlGroup controlsGroupCtrl IDC_PACKLIST_LIST;
if ( isNull _ctrlList ) exitWith { ERROR_1("Package list control not found in %1",ctrlClassName _ctrlGroup); };

private _selected = _value call FUNC(packList_parse);
private _selectedLower = _selected apply { toLowerANSI _x };

// [ displayName, className ] - sorted by displayName
private _packs = ( ["PACKAGES", true] call EFUNC(core,getAllItems) ) apply {
    private _displayName = getText ( _x >> "displayName" );
    private _className = configName _x;
    [ [ _displayName, _className ] select ( _displayName isEqualTo "" ), _className ]
};
_packs sort true;

private _classesLower = _packs apply { toLowerANSI ( _x select 1 ) };

// Keep selected entries which are not available right now (e.g. from an addon not loaded in the editor), so saving does not drop them.
_ctrlGroup setVariable [ QGVAR(unknown), _selected select { !( toLowerANSI _x in _classesLower ) } ];

private _rowH = ATTR_ROW_H * ATTR_GRID_H;
private _labelW = ( ATTR_CONTENT_W - ATTR_ROW_H - ATTR_SCROLLBAR_W ) * ATTR_GRID_W;

private _checkboxes = [];
{
    _x params [ "_displayName", "_className" ];
    private _y = _forEachIndex * _rowH;
    private _tooltip = [ _displayName, _className ] joinString endl;

    private _ctrlCheckbox = _display ctrlCreate [ "ctrlCheckbox", -1, _ctrlList ];
    _ctrlCheckbox ctrlSetPosition [ 0, _y, ATTR_ROW_H * ATTR_GRID_W, _rowH ];
    _ctrlCheckbox ctrlCommit 0;
    _ctrlCheckbox cbSetChecked ( toLowerANSI _className in _selectedLower );
    _ctrlCheckbox ctrlSetTooltip _tooltip;
    _ctrlCheckbox setVariable [ QGVAR(className), _className ];

    private _ctrlLabel = _display ctrlCreate [ "ctrlStatic", -1, _ctrlList ];
    _ctrlLabel ctrlSetPosition [ ATTR_ROW_H * ATTR_GRID_W, _y, _labelW, _rowH ];
    _ctrlLabel ctrlCommit 0;
    _ctrlLabel ctrlSetText _displayName;
    _ctrlLabel ctrlSetTooltip _tooltip;

    _checkboxes pushBack _ctrlCheckbox;
} forEach _packs;

_ctrlGroup setVariable [ QGVAR(checkboxes), _checkboxes ];

nil
