// Unit class presets for the RHS: GREF officers and militia commanders (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]). Child classes inherit it:
// the CDF officers carry it for their BLUFOR and UN variants, the ChDKZ ones for the Green Star (_g_) variants.
// Each class is declared with its real parent (rhsgref_c_troops), or the inheritance breaks.

class CfgVehicles {
    OFFICER_CIGARS(rhsgref_cdf_reg_officer,rhsgref_cdf_reg_rifleman);           // CDF ground forces (and BLUFOR, UN)
    OFFICER_CIGARS(rhsgref_cdf_para_officer,rhsgref_cdf_para_rifleman);         // CDF paratroopers (and BLUFOR)
    OFFICER_CIGARS(rhsgref_cdf_ngd_officer,rhsgref_cdf_ngd_rifleman);           // CDF national guard (and BLUFOR)
    OFFICER_CIGARS(rhsgref_ins_commander,rhsgref_ins_reed);                     // ChDKZ commander (and Green Star)
    OFFICER_CIGARS(rhsgref_ins_squadleader,rhsgref_ins_uniform_specter);        // ChDKZ officer (and Green Star)
    OFFICER_CIGARS(rhsgref_nat_commander,rhsgref_nat_base);                     // Nationalist field commander
    OFFICER_CIGARS(rhsgref_nat_pmil_commander,rhsgref_nat_pmil_rifleman);       // Nationalist paramilitary field commander
};
