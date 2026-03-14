#include "script_component.hpp"

class CfgPatches {
	class ADDON {

        // Meta information for editor
		name = ADDON_NAME;
		author = "$STR_mod_author";
        authors[] = {"Rebel", "Facel", "Panimala", "OverlordZorn [CVO]", "prisonerMO", "Vespade"};
		
        url = "$STR_mod_URL";

		VERSION_CONFIG;

        // Addon Specific Information
        // Minimum compatible version. When the game's version is lower, pop-up warning will appear when launching the game.
        requiredVersion = REQUIRED_VERSION;

        // Required addons, used for setting load order.
        // When any of the addons is missing, pop-up warning will appear when launching the game.
        requiredAddons[] = {"cba_common", "cigs_main", "cigs_pops"};

		// Optional. If this is 1, if any of requiredAddons[] entry is missing in your game the entire config will be ignored and return no error (but in rpt) so useful to make a compat Mod (Since Arma 3 2.14)
		skipWhenMissingDependencies = 1;
        
        // List of objects (CfgVehicles classes) contained in the addon. Important also for Zeus content (units and groups)
        units[] = { QGVAR(crayonpackItem) };

        // List of weapons (CfgWeapons classes) contained in the addon.
        weapons[] = { QGVAR(crayon_black_nv), QGVAR(crayon_blue_nv), QGVAR(crayon_brown_nv), QGVAR(crayon_gray_nv), QGVAR(crayon_green_nv), QGVAR(crayon_orange_nv), QGVAR(crayon_pink_nv), QGVAR(crayon_purple_nv), QGVAR(crayon_red_nv), QGVAR(crayon_white_nv), QGVAR(crayon_yellow_nv) };

	};
};

#include "poppack.hpp"

#include "pops_glasses.hpp"
#include "pops_hmd.hpp"
