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
        // The USAF factions are defined in rhsusf_main, the officers in rhsusf_c_troops.
        requiredAddons[] = { "cigs_main", "rhsusf_main", "rhsusf_c_troops" };

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
