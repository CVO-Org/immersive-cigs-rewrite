


class Cfg3DEN {
    class Object {
        class AttributeCategories {
            class ADDON {
                displayName = CSTRING(3den_category_api);   // Category name visible in Edit Attributes window
                collapsed = 1;                          // When 1, the category is collapsed by default
                class Attributes {
                    class EGVAR(api,blockDynamicSmoking) {

                        //--- Mandatory properties
                        displayName = CSTRING(blockDynamicSmoking_displayName); // Name assigned to UI control class Title
                        tooltip = CSTRING(blockDynamicSmoking_tooltip); // Tooltip assigned to UI control class Title
                        property = QEGVAR(api,blockDynamicSmoking); // Unique config property name saved in SQM
                        control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                            // The expression is called twice - first for data validation, and second for actual saving
                            // Entity is passed as _this, value is passed as _value
                            // %s is replaced by attribute config name
                            // In MP scenario, the expression is called only on server.
                        expression = "_this setVariable ['%s',_value, true];";

                            // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
                            // Entity (unit, group, marker, comment etc.) is passed as _this
                            // Returned value is the default value
                            // Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
                            // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
                        defaultValue = "false";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectControllable"; // Condition for attribute to appear (see the table below)
                        typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants. This is a scripted feature and has no engine support. See code in (configFile >> "Cfg3DEN" >> "Attributes" >> "Combo" >> "attributeSave")
                    };
                    class EGVAR(api,blockAnimations) {
                        //--- Mandatory properties
                        displayName = CSTRING(blockAnimations_displayName); // Name assigned to UI control class Title
                        tooltip = CSTRING(blockAnimations_tooltip); // Tooltip assigned to UI control class Title
                        property = QEGVAR(api,blockAnimations); // Unique config property name saved in SQM
                        control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                            // The expression is called twice - first for data validation, and second for actual saving
                            // Entity is passed as _this, value is passed as _value
                            // %s is replaced by attribute config name
                            // In MP scenario, the expression is called only on server.
                        expression = "_this setVariable ['%s',_value, true];";

                            // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
                            // Entity (unit, group, marker, comment etc.) is passed as _this
                            // Returned value is the default value
                            // Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
                            // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
                        defaultValue = "false";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectControllable"; // Condition for attribute to appear (see the table below)
                        typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants. This is a scripted feature and has no engine support. See code in (configFile >> "Cfg3DEN" >> "Attributes" >> "Combo" >> "attributeSave")
                    };
                    class EGVAR(api,blockCigsOnAI) {
                        //--- Mandatory properties
                        displayName = CSTRING(blockCigsOnAI_displayName); // Name assigned to UI control class Title
                        tooltip = CSTRING(blockCigsOnAI_tooltip); // Tooltip assigned to UI control class Title
                        property = QEGVAR(api,blockCigsOnAI); // Unique config property name saved in SQM
                        control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

                        // Expression called when applying the attribute in Eden and at the scenario start
                            // The expression is called twice - first for data validation, and second for actual saving
                            // Entity is passed as _this, value is passed as _value
                            // %s is replaced by attribute config name
                            // In MP scenario, the expression is called only on server.
                        expression = "_this setVariable ['%s',_value, true];";

                            // Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
                            // Entity (unit, group, marker, comment etc.) is passed as _this
                            // Returned value is the default value
                            // Used when no value is returned, or when it is of other type than NUMBER, STRING or ARRAY
                            // Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
                        defaultValue = "false";

                        //--- Optional properties
                        unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
                        validate = "none"; // Validate the value before saving. If the value is not of given type e.g. "number", the default value will be set. Can be "none", "expression", "condition", "number" or "variable"
                        condition = "objectControllable"; // Condition for attribute to appear (see the table below)
                        typeName = "BOOL"; // Defines data type of saved value, can be STRING, NUMBER or BOOL. Used only when control is "Combo", "Edit" or their variants. This is a scripted feature and has no engine support. See code in (configFile >> "Cfg3DEN" >> "Attributes" >> "Combo" >> "attributeSave")
                    };
                };
            };
        };
    };
};
