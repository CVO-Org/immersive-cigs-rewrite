// ACE Arsenal Extended (AAE) compat: adds this addon's items (every burn stage) to the cigar model, see cigars\aceax.hpp.
// Included by compat_aceax\config.cpp, which only loads with AAE.
// AAE only offers items that are in the arsenal: the burn stages show in dev builds, in release builds they're scope 1.

class XtdGearInfos {
    class CfgGlasses {
        class GVAR(cigar0) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s0";
        };
        class GVAR(cigar1) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cigar2) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cigar3) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cigar4) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };

    class CfgWeapons {
        class GVAR(cigar0_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s0";
        };
        class GVAR(cigar1_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cigar2_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cigar3_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cigar4_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };
};
