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
        // The vanilla factions come from platform data that every Arma 3 install loads (no DLC needed):
        // A3_Data_F, A3_Data_F_Exp (Apex), A3_Data_F_Orange (Laws of War), A3_Data_F_Enoch (Contact platform), A3_Missions_F_Oldman.
        // A3_Data_F_Decade_Loadorder loads after all of them.
        requiredAddons[] = { "cigs_main", "A3_Data_F_Decade_Loadorder" };

        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

    };
};

#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
