#if _DEV_VERSION_ == 1
    #define _DEBUG_SCOPE_ 1
    #define WEAPONS_ARRAY_CIGS QGVAR(cig0_nv)
    #define WEAPONS_ARRAY_CIGARS QGVAR(cigar0_nv)
#else
    #define _DEBUG_SCOPE_ 2
    #define WEAPONS_ARRAY_CIGS QGVAR(cig0_nv), QGVAR(cig1_nv), QGVAR(cig2_nv), QGVAR(cig3_nv), QGVAR(cig4_nv)
    #define WEAPONS_ARRAY_CIGARS QGVAR(cigar0_nv), QGVAR(cigar1_nv), QGVAR(cigar2_nv), QGVAR(cigar3_nv), QGVAR(cigar4_nv)
#endif
