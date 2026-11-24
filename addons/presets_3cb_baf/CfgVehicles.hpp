// Unit class presets for the 3CB BAF officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]). Child classes inherit it:
// 3CB derives each Army officer from the Royal Marines officer of the same camo, and the MTP day patrol officer from the
// overnight one, so the Royal Marines officers carry it for all of them.
// Each class is declared with its real parent (UK3CB_BAF_Units_<camo>), or the inheritance breaks.

class CfgVehicles {
    OFFICER_CIGARS(UK3CB_BAF_Officer_MTP_RM_H,UK3CB_BAF_Soldier_MTP_RM_base_H);         // MTP
    OFFICER_CIGARS(UK3CB_BAF_Officer_DDPM_RM,UK3CB_BAF_Soldier_DDPM_RM_base);           // Desert DPM
    OFFICER_CIGARS(UK3CB_BAF_Officer_DPMT_RM,UK3CB_BAF_Soldier_DPMT_RM_base);           // Temperate DPM
    OFFICER_CIGARS(UK3CB_BAF_Officer_DPMW_RM,UK3CB_BAF_Soldier_DPMW_RM_base);           // Woodland DPM
    OFFICER_CIGARS(UK3CB_BAF_Officer_Tropical_RM,UK3CB_BAF_Soldier_Tropical_RM_base);   // Tropical
    OFFICER_CIGARS(UK3CB_BAF_Officer_Arctic_RM,UK3CB_BAF_Soldier_Arctic_RM_base);       // Arctic
};
