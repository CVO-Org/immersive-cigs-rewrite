class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class AttributesBase {
            class Default;
            // class Edit;                 // Default edit box (i.e. text input field)
            // class Combo;                // Default combo box (i.e. drop-down menu)
            // class Checkbox;             // Default checkbox (returned value is Boolean)
            // class CheckboxNumber;       // Default checkbox (returned value is Number)
            // class ModuleDescription;    // Module description
            // class Units;                // Selection of units on which the module is applied
        };

        // Description base classes (for more information see below):
        class ModuleDescription {
            // class AnyBrain;
        };
    };

    class EGVAR(aiCigs,module): Module_F {
        // Standard object definitions:
        scope = 2;                                                      // Editor visibility; 2 will show it in the menu, 1 will hide it.
        scopeCurator = 1;                                               // Zeus visibility
        displayName = ECSTRING(aiCigs,module_displayName);                   // Name displayed in the menu
        icon = QPATHTOEF(core,data\UI\light_cig.paa);    // Map icon. Delete this entry to use the default icon.
        category = QEGVAR(aiCigs,factionClass);

        function = QFUNC(aiCigs_module);        // Name of function triggered once conditions are met
        functionPriority = 10;                  // Execution priority, modules with lower number are executed first. 0 is used when the attribute is undefined
        isGlobal = 0;                           // 0 for server only execution, 1 for global execution, 2 for persistent global execution
        isTriggerActivated = 0;                 // 1 for module waiting until all synced triggers are activated
        isDisposable = 1;                       // 1 if modules is to be disabled once it is activated (i.e. repeated trigger activation will not work)
        is3DEN = 0;                             // 1 to run init function in Eden Editor as well
        curatorCanAttach = 0;                   // 1 to allow Zeus to attach the module to an entity

        // 3DEN Attributes Menu Options
        canSetArea = 0;                         // Allows for setting the area values in the Attributes menu in 3DEN
        canSetAreaShape = 0;                    // Allows for setting "Rectangle" or "Ellipse" in Attributes menu in 3DEN
        canSetAreaHeight = 0;                   // Allows for setting height or Z value in Attributes menu in 3DEN

        // Module attributes (uses https://community.bistudio.com/wiki/Eden_Editor:_Configuring_Attributes#Entity_Specific):
        class Attributes: AttributesBase {
            // Module-specific arguments:
            // Value: stringified array of the selected classnames - older missions hold a comma separated list, see cigs_ai_fnc_packList_parse
            // Default: the default packages of the side, see defaultPacks.hpp / cigs_ai_fnc_getDefaultPacks
            class EGVAR(aiCigs,west): Default {
                property = QEGVAR(aiCigs,west);
                control = QGVAR(packList_west);
                defaultValue = QUOTE(str (['WEST'] call FUNC(getDefaultPacks)));
            };
            class EGVAR(aiCigs,east): Default {
                property = QEGVAR(aiCigs,east);
                control = QGVAR(packList_east);
                defaultValue = QUOTE(str (['EAST'] call FUNC(getDefaultPacks)));
            };
            class EGVAR(aiCigs,guer): Default {
                property = QEGVAR(aiCigs,guer);
                control = QGVAR(packList_guer);
                defaultValue = QUOTE(str (['GUER'] call FUNC(getDefaultPacks)));
            };
            class EGVAR(aiCigs,civ): Default {
                property = QEGVAR(aiCigs,civ);
                control = QGVAR(packList_civ);
                defaultValue = QUOTE(str (['CIV'] call FUNC(getDefaultPacks)));
            };

            class ModuleDescription: ModuleDescription {}; // Module description should be shown last
        };


        // Module description (must inherit from base class, otherwise pre-defined entities won't be available)
        class ModuleDescription: ModuleDescription {
            description = "Defines which pop or cigarette packages will be allocated to each side.";    // Short description, will be formatted as structured text
            sync[] = {};                // Array of synced entities (can contain base classes)
        };
    };
};
