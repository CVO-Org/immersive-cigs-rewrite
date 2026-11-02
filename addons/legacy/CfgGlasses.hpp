// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGlasses

#define PROPERTIES\
scope = _DEBUG_SCOPE_;\
displayName = "DEPRECATED";\
isDepricated = 1\


class CfgGlasses {
    // Cigars
    class EGVAR(cigars,cigar0);
    class immersion_cigs_cigar0: EGVAR(cigars,cigar0) { PROPERTIES; };

    class EGVAR(cigars,cigar1);
    class immersion_cigs_cigar1: EGVAR(cigars,cigar1) { PROPERTIES; };

    class EGVAR(cigars,cigar2);
    class immersion_cigs_cigar2: EGVAR(cigars,cigar2) { PROPERTIES; };

    class EGVAR(cigars,cigar3);
    class immersion_cigs_cigar3: EGVAR(cigars,cigar3) { PROPERTIES; };

    class EGVAR(cigars,cigar4);
    class immersion_cigs_cigar4: EGVAR(cigars,cigar4) { PROPERTIES; };

    // Cigarettes
    class EGVAR(morley,cig0);
    class murshun_cigs_cig0: EGVAR(morley,cig0) { PROPERTIES; };

    class EGVAR(morley,cig1);
    class murshun_cigs_cig1: EGVAR(morley,cig1) { PROPERTIES; };

    class EGVAR(morley,cig2);
    class murshun_cigs_cig2: EGVAR(morley,cig2) { PROPERTIES; };

    class EGVAR(morley,cig3);
    class murshun_cigs_cig3: EGVAR(morley,cig3) { PROPERTIES; };

    class EGVAR(morley,cig4);
    class murshun_cigs_cig4: EGVAR(morley,cig4) { PROPERTIES; };

    // Pops
    class EGVAR(pops,pop0);
    class immersion_pops_pop0: EGVAR(pops,pop0) { PROPERTIES; };
};

#undef PROPERTIES
