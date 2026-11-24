// Unit class presets for the 3CB Factions officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]).
//
// - 3CB has no shared officer base class: every faction and side has its own officer (UK3CB_<X>_<side>_OFF), so each
//   gets its own entry. Child classes inherit it (the ANA commando officer from the ANA officer).
// - Officers and field officers only: no junior officers, crew commanders or police (APD, TPD, ADP, ANP / ABP, TKP),
//   whose "officers" are constables.
// - Each class is declared with its real parent, read from the 3CB configs, or the inheritance breaks. The parents are
//   defined in the per-side CfgPatches (UK3CB_Factions_<X>_<side>), listed in config.cpp.

class CfgVehicles {
    OFFICER_CIGARS(UK3CB_AAF_B_OFF,UK3CB_AAF_B_Officer_base);                               // AAF - Officer
    OFFICER_CIGARS_SAME_PARENT(UK3CB_AAF_B_SF_OFF,UK3CB_AAF_B_Officer_base);                       // AAF - SF Officer
    OFFICER_CIGARS(UK3CB_AAF_I_OFF,UK3CB_AAF_I_Officer_base);                               // AAF - Officer
    OFFICER_CIGARS_SAME_PARENT(UK3CB_AAF_I_SF_OFF,UK3CB_AAF_I_Officer_base);                       // AAF - SF Officer
    OFFICER_CIGARS(UK3CB_AAF_O_OFF,UK3CB_AAF_O_Officer_base);                               // AAF - Officer
    OFFICER_CIGARS_SAME_PARENT(UK3CB_AAF_O_SF_OFF,UK3CB_AAF_O_Officer_base);                       // AAF - SF Officer

    OFFICER_CIGARS(UK3CB_ADA_B_OFF,UK3CB_ADA_B_Officer_base);                               // African Desert Army - Officer
    OFFICER_CIGARS(UK3CB_ADA_I_OFF,UK3CB_ADA_I_Officer_base);                               // African Desert Army - Officer
    OFFICER_CIGARS(UK3CB_ADA_O_OFF,UK3CB_ADA_O_Officer_base);                               // African Desert Army - Officer

    OFFICER_CIGARS(UK3CB_ANA_B_OFF,UK3CB_ANA_B_Officer_base);                               // Afghan National Army - Officer

    OFFICER_CIGARS(UK3CB_ARD_B_OFF,UK3CB_ARD_B_Officer_base);                               // Ardistan Army - Officer
    OFFICER_CIGARS(UK3CB_ARD_I_OFF,UK3CB_ARD_I_Officer_base);                               // Ardistan Army - Officer
    OFFICER_CIGARS(UK3CB_ARD_O_OFF,UK3CB_ARD_O_Officer_base);                               // Ardistan Army - Officer

    OFFICER_CIGARS(UK3CB_CCM_B_OFF,UK3CB_CCM_B_Infantry_base);                              // Chernarus Local Defence Volunteers - Officer
    OFFICER_CIGARS(UK3CB_CCM_I_OFF,UK3CB_CCM_I_Infantry_base);                              // Chernarus Nationalist Militia - Officer
    OFFICER_CIGARS(UK3CB_CCM_O_OFF,UK3CB_CCM_O_Infantry_base);                              // Chernarus Communist Militia - Officer

    OFFICER_CIGARS(UK3CB_CHD_B_OFF,UK3CB_CHD_B_Officer_base);                               // ChDSZ (Blue Star) - Officer
    OFFICER_CIGARS(UK3CB_CHD_I_OFF,UK3CB_CHD_I_Officer_base);                               // ChDZZ (Green Star) - Officer
    OFFICER_CIGARS(UK3CB_CHD_O_OFF,UK3CB_CHD_O_Officer_base);                               // ChDKZ (Red Star) - Officer

    OFFICER_CIGARS(UK3CB_CHD_W_B_OFF,UK3CB_CHD_W_B_Officer_base);                           // ChDSZ Winter (Blue Star) - Officer
    OFFICER_CIGARS(UK3CB_CHD_W_I_OFF,UK3CB_CHD_W_I_Officer_base);                           // ChDZZ Winter (Green Star) - Officer
    OFFICER_CIGARS(UK3CB_CHD_W_O_OFF,UK3CB_CHD_W_O_Officer_base);                           // ChDKZ Winter (Red Star) - Officer

    OFFICER_CIGARS(UK3CB_CSAT_A_O_FIELD_OFF,UK3CB_CSAT_A_O_Infantry_base);                  // CSAT - Africa - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_A_O_OFF,UK3CB_CSAT_A_O_Officer_base);                         // CSAT - Africa - Officer
    OFFICER_CIGARS(UK3CB_CSAT_B_O_FIELD_OFF,UK3CB_CSAT_B_O_Infantry_base);                  // CSAT - Middle East - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_B_O_OFF,UK3CB_CSAT_B_O_Officer_base);                         // CSAT - Middle East - Officer
    OFFICER_CIGARS(UK3CB_CSAT_F_O_FIELD_OFF,UK3CB_CSAT_F_O_Infantry_base);                  // CSAT - Navy - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_F_O_OFF,UK3CB_CSAT_F_O_Officer_base);                         // CSAT - Navy - Officer
    OFFICER_CIGARS(UK3CB_CSAT_G_O_FIELD_OFF,UK3CB_CSAT_G_O_Infantry_base);                  // CSAT - Pacific - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_G_O_OFF,UK3CB_CSAT_G_O_Officer_base);                         // CSAT - Pacific - Officer
    OFFICER_CIGARS(UK3CB_CSAT_M_O_FIELD_OFF,UK3CB_CSAT_M_O_Infantry_base);                  // CSAT - Mediterranean - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_M_O_OFF,UK3CB_CSAT_M_O_Officer_base);                         // CSAT - Mediterranean - Officer
    OFFICER_CIGARS(UK3CB_CSAT_N_O_FIELD_OFF,UK3CB_CSAT_N_O_Infantry_base);                  // CSAT - Navy (Pacific) - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_N_O_OFF,UK3CB_CSAT_N_O_Officer_base);                         // CSAT - Navy (Pacific) - Officer
    OFFICER_CIGARS(UK3CB_CSAT_S_O_FIELD_OFF,UK3CB_CSAT_S_O_Infantry_base);                  // CSAT - Winter - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_S_O_OFF,UK3CB_CSAT_S_O_Officer_base);                         // CSAT - Winter - Officer
    OFFICER_CIGARS(UK3CB_CSAT_U_O_FIELD_OFF,UK3CB_CSAT_U_O_Infantry_base);                  // CSAT - Urban - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_U_O_OFF,UK3CB_CSAT_U_O_Officer_base);                         // CSAT - Urban - Officer
    OFFICER_CIGARS(UK3CB_CSAT_W_O_FIELD_OFF,UK3CB_CSAT_W_O_Infantry_base);                  // CSAT - Europe - Field Officer
    OFFICER_CIGARS(UK3CB_CSAT_W_O_OFF,UK3CB_CSAT_W_O_Officer_base);                         // CSAT - Europe - Officer

    OFFICER_CIGARS(UK3CB_CW_SOV_O_EARLY_FIELD_OFF,UK3CB_CW_SOV_O_Early_Infantry_base);      // Cold War USSR - Early - MSV Field Officer
    OFFICER_CIGARS(UK3CB_CW_SOV_O_EARLY_OFF,UK3CB_CW_SOV_O_Early_Officer_base);             // Cold War USSR - Early - MSV Officer
    OFFICER_CIGARS(UK3CB_CW_SOV_O_EARLY_VDV_FIELD_OFF,UK3CB_CW_SOV_O_EARLY_VDV_Infantry_base);// Cold War USSR - Early - VDV Field Officer
    OFFICER_CIGARS(UK3CB_CW_SOV_O_LATE_FIELD_OFF,UK3CB_CW_SOV_O_Late_Infantry_base);        // Cold War USSR - Late - MSV Field Officer
    OFFICER_CIGARS(UK3CB_CW_SOV_O_LATE_OFF,UK3CB_CW_SOV_O_Late_Officer_base);               // Cold War USSR - Late - MSV Officer
    OFFICER_CIGARS(UK3CB_CW_SOV_O_LATE_VDV_FIELD_OFF,UK3CB_CW_SOV_O_LATE_VDV_Infantry_base);// Cold War USSR - Late - VDV Field Officer

    OFFICER_CIGARS(UK3CB_CW_US_B_EARLY_FIELD_OFF,UK3CB_CW_US_B_Early_Infantry_base);        // Cold War US - Early - Field Officer
    OFFICER_CIGARS(UK3CB_CW_US_B_EARLY_OFF,UK3CB_CW_US_B_Early_Officer_base);               // Cold War US - Early - Officer
    OFFICER_CIGARS(UK3CB_CW_US_B_LATE_FIELD_OFF,UK3CB_CW_US_B_LATE_Infantry_base);          // Cold War US - Late - Field Officer
    OFFICER_CIGARS(UK3CB_CW_US_B_LATE_OFF,UK3CB_CW_US_B_LATE_Officer_base);                 // Cold War US - Late - Officer

    OFFICER_CIGARS(UK3CB_FIA_B_OFF,UK3CB_FIA_B_Officer_base);                               // FIA - Officer
    OFFICER_CIGARS(UK3CB_FIA_I_OFF,UK3CB_FIA_I_Officer_base);                               // FIA - Officer
    OFFICER_CIGARS(UK3CB_FIA_O_OFF,UK3CB_FIA_O_Officer_base);                               // FIA - Officer

    OFFICER_CIGARS(UK3CB_GAF_B_OFF,UK3CB_GAF_B_Officer_base);                               // Grozovia Armed Forces - Officer
    OFFICER_CIGARS(UK3CB_GAF_I_OFF,UK3CB_GAF_I_Officer_base);                               // Grozovia Armed Forces - Officer
    OFFICER_CIGARS(UK3CB_GAF_O_OFF,UK3CB_GAF_O_Officer_base);                               // Grozovia Armed Forces - Officer

    OFFICER_CIGARS(UK3CB_ION_B_Desert_OFF,UK3CB_ION_B_Desert_Officer_base);                 // ION Services - Desert - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_B_Urban_OFF,UK3CB_ION_B_Urban_Officer_base);                   // ION Services - Urban - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_B_Winter_OFF,UK3CB_ION_B_Winter_Officer_base);                 // ION Services - Winter - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_B_Woodland_OFF,UK3CB_ION_B_Woodland_Officer_base);             // ION Services - Woodland - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_I_Desert_OFF,UK3CB_ION_I_Desert_Officer_base);                 // ION Services - Desert - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_I_Urban_OFF,UK3CB_ION_I_Urban_Officer_base);                   // ION Services - Urban - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_I_Winter_OFF,UK3CB_ION_I_Winter_Officer_base);                 // ION Services - Winter - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_I_Woodland_OFF,UK3CB_ION_I_Woodland_Officer_base);             // ION Services - Woodland - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_O_Desert_OFF,UK3CB_ION_O_Desert_Officer_base);                 // ION Services - Desert - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_O_Urban_OFF,UK3CB_ION_O_Urban_Officer_base);                   // ION Services - Urban - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_O_Winter_OFF,UK3CB_ION_O_Winter_Officer_base);                 // ION Services - Winter - Regional Coordinator
    OFFICER_CIGARS(UK3CB_ION_O_Woodland_OFF,UK3CB_ION_O_Woodland_Officer_base);             // ION Services - Woodland - Regional Coordinator

    OFFICER_CIGARS(UK3CB_KDF_B_OFF,UK3CB_KDF_B_Officer_base);                               // Kolgujev Defence Force - Officer
    OFFICER_CIGARS(UK3CB_KDF_I_OFF,UK3CB_KDF_I_Officer_base);                               // Kolgujev Defence Force - Officer
    OFFICER_CIGARS(UK3CB_KDF_O_OFF,UK3CB_KDF_O_Officer_base);                               // Kolgujev Defence Force - Officer

    OFFICER_CIGARS(UK3CB_KRG_B_OFF,UK3CB_KRG_B_Officer_base);                               // Karzeghistan Royal Guard - Officer
    OFFICER_CIGARS(UK3CB_KRG_I_OFF,UK3CB_KRG_I_Officer_base);                               // Karzeghistan Royal Guard - Officer
    OFFICER_CIGARS(UK3CB_KRG_O_OFF,UK3CB_KRG_O_Officer_base);                               // Karzeghistan Royal Guard - Officer

    OFFICER_CIGARS(UK3CB_LDF_B_OFF,UK3CB_LDF_B_Officer_base);                               // Livonia Defence Force - Officer
    OFFICER_CIGARS(UK3CB_LDF_I_OFF,UK3CB_LDF_I_Officer_base);                               // Livonia Defence Force - Officer
    OFFICER_CIGARS(UK3CB_LDF_O_OFF,UK3CB_LDF_O_Officer_base);                               // Livonia Defence Force - Officer

    OFFICER_CIGARS(UK3CB_LNM_B_OFF,UK3CB_LNM_B_Officer_base);                               // Livonian Nationalist Militia - Officer
    OFFICER_CIGARS(UK3CB_LNM_I_OFF,UK3CB_LNM_I_Officer_base);                               // Livonian Nationalist Militia - Officer
    OFFICER_CIGARS(UK3CB_LNM_O_OFF,UK3CB_LNM_O_Officer_base);                               // Livonian Nationalist Militia - Officer

    OFFICER_CIGARS(UK3CB_LSM_B_OFF,UK3CB_LSM_B_Officer_base);                               // Livonia Separatist Militia - Officer
    OFFICER_CIGARS(UK3CB_LSM_I_OFF,UK3CB_LSM_I_Officer_base);                               // Livonia Separatist Militia - Officer
    OFFICER_CIGARS(UK3CB_LSM_O_OFF,UK3CB_LSM_O_Officer_base);                               // Livonia Separatist Militia - Officer

    OFFICER_CIGARS(UK3CB_MDF_B_OFF,UK3CB_MDF_B_Officer_base);                               // Malden Defence Force - Officer
    OFFICER_CIGARS(UK3CB_MDF_I_OFF,UK3CB_MDF_I_Officer_base);                               // Malden Defence Force - Officer
    OFFICER_CIGARS(UK3CB_MDF_O_OFF,UK3CB_MDF_O_Officer_base);                               // Malden Defence Force - Officer

    OFFICER_CIGARS(UK3CB_NAP_B_OFF,UK3CB_NAP_B_Officer_base);                               // NAPA - Officer
    OFFICER_CIGARS(UK3CB_NAP_I_OFF,UK3CB_NAP_I_Officer_base);                               // NAPA - Officer
    OFFICER_CIGARS(UK3CB_NAP_O_OFF,UK3CB_NAP_O_Officer_base);                               // NAPA - Officer

    OFFICER_CIGARS(UK3CB_NFA_B_OFF,UK3CB_NFA_B_Officer_base);                               // Nogovan Freedom Alliance - Officer
    OFFICER_CIGARS(UK3CB_NFA_I_OFF,UK3CB_NFA_I_Officer_base);                               // Nogovan Freedom Alliance - Officer
    OFFICER_CIGARS(UK3CB_NFA_O_OFF,UK3CB_NFA_O_Officer_base);                               // Nogovan Freedom Alliance - Officer

    OFFICER_CIGARS(UK3CB_PLM_B_OFF,UK3CB_PLM_B_Officer_base);                               // PLM (People's Liberation Movement) - Regulars Officer
    OFFICER_CIGARS(UK3CB_PLM_B_OFF_COMM,UK3CB_PLM_B_Officer_Comm_base);                     // PLM (People's Liberation Movement) - Political Officer
    OFFICER_CIGARS(UK3CB_PLM_I_OFF,UK3CB_PLM_I_Officer_base);                               // PLM (People's Liberation Movement) - Regulars Officer
    OFFICER_CIGARS(UK3CB_PLM_I_OFF_COMM,UK3CB_PLM_I_Officer_Comm_base);                     // PLM (People's Liberation Movement) - Political Officer
    OFFICER_CIGARS(UK3CB_PLM_O_OFF,UK3CB_PLM_O_Officer_base);                               // PLM (People's Liberation Movement) - Regulars Officer
    OFFICER_CIGARS(UK3CB_PLM_O_OFF_COMM,UK3CB_PLM_O_Officer_Comm_base);                     // PLM (People's Liberation Movement) - Political Officer

    OFFICER_CIGARS(UK3CB_TKA_B_OFF,UK3CB_TKA_B_Officer_base);                               // Takistan National Army - Officer
    OFFICER_CIGARS(UK3CB_TKA_I_OFF,UK3CB_TKA_I_Officer_base);                               // Takistan National Army - Officer
    OFFICER_CIGARS(UK3CB_TKA_O_OFF,UK3CB_TKA_O_Officer_base);                               // Takistan National Army - Officer

    OFFICER_CIGARS(UK3CB_TNM_B_OFF,UK3CB_TNM_B_Officer_base);                               // Tanoa Nationalist Militia - Officer
    OFFICER_CIGARS(UK3CB_TNM_I_OFF,UK3CB_TNM_I_Officer_base);                               // Tanoa Nationalist Militia - Officer
    OFFICER_CIGARS(UK3CB_TNM_O_OFF,UK3CB_TNM_O_Officer_base);                               // Tanoa Nationalist Militia - Officer

    OFFICER_CIGARS(UK3CB_UN_B_OFF,UK3CB_UN_B_Officer_base);                                 // UN Peacekeepers - Officer
    OFFICER_CIGARS(UK3CB_UN_I_OFF,UK3CB_UN_I_Officer_base);                                 // UN Peacekeepers - Officer

    OFFICER_CIGARS(UK3CB_WEI_B_OFF,UK3CB_WEI_B_Officer_base);                               // Western European Insurgents - Officer
    OFFICER_CIGARS(UK3CB_WEI_I_OFF,UK3CB_WEI_I_Officer_base);                               // Western European Insurgents - Officer
    OFFICER_CIGARS(UK3CB_WEI_O_OFF,UK3CB_WEI_O_Officer_base);                               // Western European Insurgents - Officer
};
