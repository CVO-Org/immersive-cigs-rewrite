#include "script_component.hpp"

class CfgPatches {
    class ADDON {

        // Meta information for editor
        name = ADDON_NAME;
        author = ECSTRING(main,author);
        authors[] = { "OverlordZorn [CVO]" };

        url = ECSTRING(main,url);

        VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // The BAF faction is defined in uk3cb_baf_units_common, the officers in one addon per camo.
        requiredAddons[] = {
            "cigs_main",
            "UK3CB_BAF_Units_Common",
            "UK3CB_BAF_Units_Arctic",
            "UK3CB_BAF_Units_Desert",
            "UK3CB_BAF_Units_MTP",
            "UK3CB_BAF_Units_Temperate",
            "UK3CB_BAF_Units_Tropical",
            "UK3CB_BAF_Units_Woodland",
            "UK3CB_BAF_Units_Woodland_CW"
        };

        // Skip this addon without an error when the mod isn't loaded.
        skipWhenMissingDependencies = 1;

        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

    };
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
