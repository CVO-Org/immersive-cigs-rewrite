// Unit class presets for the vanilla officers (see docs/modders.md, "Unit class presets").
// Officers get a cigar box on top of their faction's cigarettes (cigs_packsExtra[]).
// Child classes inherit it: B_officer_F covers the Pacific (B_T_), Woodland (B_W_) and parade officers,
// O_officer_F the Pacific (O_T_) and parade ones, I_G_officer_F the FIA officers of all three sides (B_G_, O_G_).
// Each class is declared with its real parent, or the inheritance breaks.

class CfgVehicles {
    class B_Soldier_base_F;
    class B_officer_F: B_Soldier_base_F {               // NATO
        PVAR(packsExtra)[] = { QEGVAR(cigars,cigarbox_5) };
    };

    class O_Soldier_base_F;
    class O_officer_F: O_Soldier_base_F {               // CSAT
        PVAR(packsExtra)[] = { QEGVAR(cigars,cigarbox_5) };
    };

    class I_Soldier_base_F;
    class I_officer_F: I_Soldier_base_F {               // AAF
        PVAR(packsExtra)[] = { QEGVAR(cigars,cigarbox_5) };
    };

    class I_E_Soldier_base_F;
    class I_E_Officer_F: I_E_Soldier_base_F {           // LDF
        PVAR(packsExtra)[] = { QEGVAR(cigars,cigarbox_5) };
    };

    class I_G_Soldier_base_F;
    class I_G_officer_F: I_G_Soldier_base_F {           // FIA
        PVAR(packsExtra)[] = { QEGVAR(cigars,cigarbox_5) };
    };
};
