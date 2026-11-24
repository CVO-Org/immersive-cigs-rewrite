// Unit class presets for the RHS: USAF officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]). Child classes inherit it:
// the OCP officer carries it for the UCP one, the woodland USMC officers for the desert ones.
// Each class is declared with its real parent (rhsusf_c_troops), or the inheritance breaks.

class CfgVehicles {
    OFFICER_CIGARS(rhsusf_army_ocp_officer,rhsusf_infantry_army_base);                  // US Army (OCP, UCP)
    OFFICER_CIGARS(rhsusf_usmc_marpat_wd_officer,rhsusf_usmc_marpat_wd_rifleman);       // USMC (woodland, desert)
    OFFICER_CIGARS(rhsusf_usmc_recon_marpat_wd_officer,rhsusf_infantry_usmc_recon_base);// USMC recon (woodland, desert)
    OFFICER_CIGARS(rhsusf_socom_swcc_officer,rhsusf_socom_swcc_crewman);                // SOCOM SWCC
};
