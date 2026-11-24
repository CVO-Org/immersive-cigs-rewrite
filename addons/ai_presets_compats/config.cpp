#include "script_component.hpp"

// Compat presets: presets for mods whose units the unit class and faction presets can't reach (e.g. Antistasi),
// registered with AI Cigs through cigs_ai_compats (see cigs_ai_fnc_getCompats).
// One subaddon per mod (a subfolder with its own config.cpp and CfgPatches class, as ACE does with its compats):
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
