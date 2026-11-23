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
            "UK3CB_Factions_WEI",

            // The officers (CfgVehicles.hpp): their parent classes are defined per side.
            "UK3CB_Factions_AAF_B",
            "UK3CB_Factions_AAF_I",
            "UK3CB_Factions_AAF_O",
            "UK3CB_Factions_ADA_B",
            "UK3CB_Factions_ADA_I",
            "UK3CB_Factions_ADA_O",
            "UK3CB_Factions_ANA_B",
            "UK3CB_Factions_ARD_B",
            "UK3CB_Factions_ARD_I",
            "UK3CB_Factions_ARD_O",
            "UK3CB_Factions_CCM_B",
            "UK3CB_Factions_CCM_I",
            "UK3CB_Factions_CCM_O",
            "UK3CB_Factions_CHD_B",
            "UK3CB_Factions_CHD_I",
            "UK3CB_Factions_CHD_O",
            "UK3CB_Factions_CHD_W_B",
            "UK3CB_Factions_CHD_W_I",
            "UK3CB_Factions_CHD_W_O",
            "UK3CB_Factions_CSAT_A_O",
            "UK3CB_Factions_CSAT_B_O",
            "UK3CB_Factions_CSAT_F_O",
            "UK3CB_Factions_CSAT_G_O",
            "UK3CB_Factions_CSAT_M_O",
            "UK3CB_Factions_CSAT_N_O",
            "UK3CB_Factions_CSAT_S_O",
            "UK3CB_Factions_CSAT_U_O",
            "UK3CB_Factions_CSAT_W_O",
            "UK3CB_Factions_CW_SOV_O_EARLY",
            "UK3CB_Factions_CW_SOV_O_LATE",
            "UK3CB_Factions_CW_US_B_EARLY",
            "UK3CB_Factions_CW_US_B_LATE",
            "UK3CB_Factions_FIA_B",
            "UK3CB_Factions_FIA_I",
            "UK3CB_Factions_FIA_O",
            "UK3CB_Factions_GAF_B",
            "UK3CB_Factions_GAF_I",
            "UK3CB_Factions_GAF_O",
            "UK3CB_Factions_ION_B_Desert",
            "UK3CB_Factions_ION_B_Urban",
            "UK3CB_Factions_ION_B_Winter",
            "UK3CB_Factions_ION_B_Woodland",
            "UK3CB_Factions_ION_I_Desert",
            "UK3CB_Factions_ION_I_Urban",
            "UK3CB_Factions_ION_I_Winter",
            "UK3CB_Factions_ION_I_Woodland",
            "UK3CB_Factions_ION_O_Desert",
            "UK3CB_Factions_ION_O_Urban",
            "UK3CB_Factions_ION_O_Winter",
            "UK3CB_Factions_ION_O_Woodland",
            "UK3CB_Factions_KDF_B",
            "UK3CB_Factions_KDF_I",
            "UK3CB_Factions_KDF_O",
            "UK3CB_Factions_KRG_B",
            "UK3CB_Factions_KRG_I",
            "UK3CB_Factions_KRG_O",
            "UK3CB_Factions_LDF_B",
            "UK3CB_Factions_LDF_I",
            "UK3CB_Factions_LDF_O",
            "UK3CB_Factions_LNM_B",
            "UK3CB_Factions_LNM_I",
            "UK3CB_Factions_LNM_O",
            "UK3CB_Factions_LSM_B",
            "UK3CB_Factions_LSM_I",
            "UK3CB_Factions_LSM_O",
            "UK3CB_Factions_MDF_B",
            "UK3CB_Factions_MDF_I",
            "UK3CB_Factions_MDF_O",
            "UK3CB_Factions_NAP_B",
            "UK3CB_Factions_NAP_I",
            "UK3CB_Factions_NAP_O",
            "UK3CB_Factions_NFA_B",
            "UK3CB_Factions_NFA_I",
            "UK3CB_Factions_NFA_O",
            "UK3CB_Factions_PLM_B",
            "UK3CB_Factions_PLM_I",
            "UK3CB_Factions_PLM_O",
            "UK3CB_Factions_TKA_B",
            "UK3CB_Factions_TKA_I",
            "UK3CB_Factions_TKA_O",
            "UK3CB_Factions_TNM_B",
            "UK3CB_Factions_TNM_I",
            "UK3CB_Factions_TNM_O",
            "UK3CB_Factions_UN_B",
            "UK3CB_Factions_UN_I",
            "UK3CB_Factions_WEI_B",
            "UK3CB_Factions_WEI_I",
            "UK3CB_Factions_WEI_O"
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
