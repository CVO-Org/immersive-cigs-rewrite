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
        // The 3CB faction classes, one CfgPatches per faction.
        requiredAddons[] = {
            "cigs_main",
            "UK3CB_Factions_AAF",
            "UK3CB_Factions_ADA",
            "UK3CB_Factions_ADC",
            "UK3CB_Factions_ADE",
            "UK3CB_Factions_ADG",
            "UK3CB_Factions_ADM",
            "UK3CB_Factions_ADP",
            "UK3CB_Factions_ADR",
            "UK3CB_Factions_ANA",
            "UK3CB_Factions_ANP",
            "UK3CB_Factions_APD",
            "UK3CB_Factions_ARD",
            "UK3CB_Factions_CCM",
            "UK3CB_Factions_CHC",
            "UK3CB_Factions_CHD",
            "UK3CB_Factions_CHD_W",
            "UK3CB_Factions_CPD",
            "UK3CB_Factions_CST",
            "UK3CB_Factions_CW_SOV",
            "UK3CB_Factions_CW_US",
            "UK3CB_Factions_FIA",
            "UK3CB_Factions_GAF",
            "UK3CB_Factions_ION",
            "UK3CB_Factions_KDF",
            "UK3CB_Factions_KRG",
            "UK3CB_Factions_LDF",
            "UK3CB_Factions_LFR",
            "UK3CB_Factions_LNM",
            "UK3CB_Factions_LSM",
            "UK3CB_Factions_MDF",
            "UK3CB_Factions_MEC",
            "UK3CB_Factions_MEE",
            "UK3CB_Factions_MEI",
            "UK3CB_Factions_NAP",
            "UK3CB_Factions_NFA",
            "UK3CB_Factions_NPD",
            "UK3CB_Factions_PLM",
            "UK3CB_Factions_TKA",
            "UK3CB_Factions_TKC",
            "UK3CB_Factions_TKM",
            "UK3CB_Factions_TKP",
            "UK3CB_Factions_TNM",
            "UK3CB_Factions_TPD",
            "UK3CB_Factions_UN",
            "UK3CB_Factions_WEI"
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
