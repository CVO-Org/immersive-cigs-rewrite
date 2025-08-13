#include "script_component.hpp"

class CfgPatches {
	class ADDON {

        // Meta information for editor
		name = ADDON_NAME;
		author = "$STR_mod_author";
        authors[] = {"OverlordZorn CVO]", "DartRuffian"};
		
        url = "$STR_mod_URL";

		VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // When any of the addons is missing, pop-up warning will appear when launching the game.
        requiredAddons[] = {"cba_main","cigs_main", QPVAR(core), QPVAR(cigars), QPVAR(morley)};

		// Optional. If this is 1, if any of requiredAddons[] entry is missing in your game the entire config will be ignored and return no error (but in rpt) so useful to make a compat Mod (Since Arma 3 2.14)
		skipWhenMissingDependencies = 1;
        
        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = {};

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = {};

	};

    // Create Dummy CfgPatches Addons to avoid Missing Addons Errors
    class murshun_cigs : ADDON {};
    class immersion_pops : ADDON {};
    class immersion_cigs_animations : ADDON {};
    class murshun_cigs_hotfix : ADDON {};
};

#include "CfgFunctions.hpp"
#include "XEH\CfgXEH.hpp"

#include "CfgGlasses.hpp"
#include "CfgWeapons.hpp"
#include "CfgVehicles.hpp"
#include "CfgMagazines.hpp"

#include "CfgReplacementItems.hpp"
