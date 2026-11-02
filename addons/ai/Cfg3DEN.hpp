// https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes

class ctrlStatic;
class ctrlButton;
class ctrlControlsGroup;
class ctrlControlsGroupNoScrollbars;

class Cfg3DEN {
    // Custom attribute control: dynamic list of checkboxes, one per package. Checked = package will be distributed.
    // Filled by cigs_ai_fnc_packList_load, saved as stringified array of the checked classnames.
    // Derived classes need to redeclare every child in Controls - inherited children are not created by the engine.
    class Attributes {
        class GVAR(packList): ctrlControlsGroupNoScrollbars {
            idc = -1;
            x = 0;
            y = 0;
            w = QUOTE((ATTR_TITLE_W + ATTR_CONTENT_W) * ATTR_GRID_W);
            h = QUOTE(ATTR_LIST_ROWS * ATTR_ROW_H * ATTR_GRID_H);

            attributeLoad = QUOTE([ARR_2(_this,_value)] call FUNC(packList_load));
            attributeSave = QUOTE(_this call FUNC(packList_save));

            class Controls {
                class Title: ctrlStatic {
                    idc = -1;
                    style = 1; // ST_RIGHT
                    tooltip = ECSTRING(aiCigs,module_packList_tooltip);
                    x = 0;
                    y = 0;
                    w = QUOTE((ATTR_TITLE_W - 2) * ATTR_GRID_W);
                    h = QUOTE(ATTR_ROW_H * ATTR_GRID_H);
                };
                class SelectAll: ctrlButton {
                    idc = -1;
                    text = ECSTRING(aiCigs,module_packList_selectAll);
                    onButtonClick = QUOTE([ARR_2(_this select 0,true)] call FUNC(packList_setAll));
                    x = QUOTE((ATTR_TITLE_W - 26) * ATTR_GRID_W);
                    y = QUOTE((ATTR_ROW_H + 1) * ATTR_GRID_H);
                    w = QUOTE(24 * ATTR_GRID_W);
                    h = QUOTE(ATTR_ROW_H * ATTR_GRID_H);
                };
                class DeselectAll: SelectAll {
                    text = ECSTRING(aiCigs,module_packList_deselectAll);
                    onButtonClick = QUOTE([ARR_2(_this select 0,false)] call FUNC(packList_setAll));
                    y = QUOTE((2 * ATTR_ROW_H + 2) * ATTR_GRID_H);
                };
                class Background: ctrlStatic {
                    idc = -1;
                    x = QUOTE(ATTR_TITLE_W * ATTR_GRID_W);
                    y = 0;
                    w = QUOTE(ATTR_CONTENT_W * ATTR_GRID_W);
                    h = QUOTE(ATTR_LIST_ROWS * ATTR_ROW_H * ATTR_GRID_H);
                    colorBackground[] = {0, 0, 0, 0.3};
                };
                class List: ctrlControlsGroup {
                    idc = IDC_PACKLIST_LIST;
                    x = QUOTE(ATTR_TITLE_W * ATTR_GRID_W);
                    y = 0;
                    w = QUOTE(ATTR_CONTENT_W * ATTR_GRID_W);
                    h = QUOTE(ATTR_LIST_ROWS * ATTR_ROW_H * ATTR_GRID_H);
                    class Controls {}; // Filled by cigs_ai_fnc_packList_load
                };
            };
        };

        class GVAR(packList_west): GVAR(packList) {
            class Controls: Controls {
                class Title: Title { text = "WEST"; };
                class SelectAll: SelectAll {};
                class DeselectAll: DeselectAll {};
                class Background: Background {};
                class List: List {};
            };
        };
        class GVAR(packList_east): GVAR(packList) {
            class Controls: Controls {
                class Title: Title { text = "EAST"; };
                class SelectAll: SelectAll {};
                class DeselectAll: DeselectAll {};
                class Background: Background {};
                class List: List {};
            };
        };
        class GVAR(packList_guer): GVAR(packList) {
            class Controls: Controls {
                class Title: Title { text = "GUER"; };
                class SelectAll: SelectAll {};
                class DeselectAll: DeselectAll {};
                class Background: Background {};
                class List: List {};
            };
        };
        class GVAR(packList_civ): GVAR(packList) {
            class Controls: Controls {
                class Title: Title { text = "CIV"; };
                class SelectAll: SelectAll {};
                class DeselectAll: DeselectAll {};
                class Background: Background {};
                class List: List {};
            };
        };
    };
};
