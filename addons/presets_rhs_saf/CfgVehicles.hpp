// Unit class presets for the RHS: SAF officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]). Child classes inherit it:
// the army officers carry it for their OPFOR (_o_) variants.
// Each class is declared with its real parent (rhssaf_c_troops), or the inheritance breaks.

class CfgVehicles {
    OFFICER_CIGARS(rhssaf_army_m10_digital_officer,rhssaf_soldier_army_digital_base);                // Army, M10 digital
    OFFICER_CIGARS(rhssaf_army_m10_para_officer,rhssaf_soldier_army_para_digital_base);              // Army, M10 para
    OFFICER_CIGARS(rhssaf_army_m93_oakleaf_summer_officer,rhssaf_soldier_army_oakleaf_summer_base);  // Army, M93 oakleaf
    OFFICER_CIGARS(rhssaf_un_m10_digital_officer,rhssaf_soldier_un_digital_base);                    // UN, M10 digital
    OFFICER_CIGARS(rhssaf_un_m10_digital_desert_officer,rhssaf_soldier_un_desert_base);              // UN, M10 desert
};
