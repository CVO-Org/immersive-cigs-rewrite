// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGoggles

#define PROPERTIES\
scope = _DEBUG_SCOPE_;\
displayName = "DEPRECATED";\
isDepricated = 1\

class CfgWeapons {

    // Cigars
    class EGVAR(cigars,cigar0_nv);
    class immersion_cigs_cigar0_nv: EGVAR(cigars,cigar0_nv) { PROPERTIES; };

    class EGVAR(cigars,cigar1_nv);
    class immersion_cigs_cigar1_nv: EGVAR(cigars,cigar1_nv) { PROPERTIES; };

    class EGVAR(cigars,cigar2_nv);
    class immersion_cigs_cigar2_nv: EGVAR(cigars,cigar2_nv) { PROPERTIES; };

    class EGVAR(cigars,cigar3_nv);
    class immersion_cigs_cigar3_nv: EGVAR(cigars,cigar3_nv) { PROPERTIES; };

    class EGVAR(cigars,cigar4_nv);
    class immersion_cigs_cigar4_nv: EGVAR(cigars,cigar4_nv) { PROPERTIES; };

    // Cigarettes
    class EGVAR(morley,cig0_nv);
    class murshun_cigs_cig0_nv: EGVAR(morley,cig0_nv) { PROPERTIES; };

    class EGVAR(morley,cig1_nv);
    class murshun_cigs_cig1_nv: EGVAR(morley,cig1_nv) { PROPERTIES; };

    class EGVAR(morley,cig2_nv);
    class murshun_cigs_cig2_nv: EGVAR(morley,cig2_nv) { PROPERTIES; };

    class EGVAR(morley,cig3_nv);
    class murshun_cigs_cig3_nv: EGVAR(morley,cig3_nv) { PROPERTIES; };

    class EGVAR(morley,cig4_nv);
    class murshun_cigs_cig4_nv: EGVAR(morley,cig4_nv) { PROPERTIES; };

    // Pops
    class EGVAR(pops,pop0_nv);
    class immersion_pops_pop0_nv: EGVAR(pops,pop0_nv) { PROPERTIES; };
};

#undef PROPERTIES
