// ACE Arsenal Extended (AAE) compat: adds this addon's items to the cigar model, see cigars\aceax.hpp.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.

class XtdGearInfos {
    class CfgGlasses {
        class GVAR(cigar0) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
        };
    };

    class CfgWeapons {
        class GVAR(cigar0_nv) {
            model = QEGVAR(cigars,cigar);
            brand = QUOTE(COMPONENT);
        };
    };
};
