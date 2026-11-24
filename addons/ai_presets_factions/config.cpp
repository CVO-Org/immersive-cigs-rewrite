#include "script_component.hpp"

// Faction presets: cigs_packs[] on the factions (CfgFactionClasses) and unit classes (CfgVehicles) of a mod or CDLC.
// One subaddon per mod or CDLC (a subfolder with its own config.cpp and CfgPatches class, as ACE does with its compats):
// each one requires its mod and is skipped without an error when the mod isn't loaded (skipWhenMissingDependencies).
// This root addon has no content of its own.

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
        requiredAddons[] = { "cigs_main" };

        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

    };
};
