#include "script_component.hpp"

class CfgPatches {
    class SUBADDON {
        addonRootClass = QUOTE(ADDON);

        // Meta information for editor
        name = SUBADDON_NAME;
        author = ECSTRING(main,author);
        authors[] = { "OverlordZorn [CVO]" };

        url = ECSTRING(main,url);

        VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // 3CB BAF Units has one addon per camo, each with its factions and officers.
        requiredAddons[] = {
            "cigs_main",
            "UK3CB_BAF_Units_Arctic",
            "UK3CB_BAF_Units_Desert",
            "UK3CB_BAF_Units_MTP",
            "UK3CB_BAF_Units_Temperate",
            "UK3CB_BAF_Units_Tropical",
            "UK3CB_BAF_Units_Woodland"
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
