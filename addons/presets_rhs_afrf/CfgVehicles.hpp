// Unit class presets for the RHS: AFRF officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]). Child classes inherit it,
// so the armored officers carry it for the unarmoured ones and all their camo variants, and the VDV officers for the VMF ones.
// Each class is declared with its real parent (rhs_c_troops), or the inheritance breaks.

class CfgVehicles {
    OFFICER_CIGARS(rhs_msv_officer_armored,rhs_msv_rifleman);                   // MSV (and EMR)
    OFFICER_CIGARS(rhs_vdv_officer_armored,rhs_vdv_rifleman);                   // VDV (all camos), VMF
    OFFICER_CIGARS(rhs_vdv_recon_officer_armored,rhs_vdv_recon_rifleman);       // VDV recon, VMF recon
    OFFICER_CIGARS(rhs_rva_crew_officer,rhs_rva_crew);                          // RVA
};
