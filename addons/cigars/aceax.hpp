// ACE Arsenal Extended (AAE) compat: groups all cigars into one arsenal entry with a brand selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.
// Each cigar brand adds its own items to this model in its aceax.hpp (XtdGearInfos). A new brand needs its value here too.

class XtdGearModels {
    class GVAR(cigarBase) {
        label = CSTRING(cigar);
        author = ECSTRING(main,author);
        options[] = { "brand" };

        class brand {
            label = ECSTRING(base,aceax_brand);
            values[] = { "cigars", "papa_schultz" };

            class cigars       { label = CSTRING(cigar); };
            class papa_schultz { label = ECSTRING(papa_schultz,cigar); };
        };
    };

    // facewear
    class CfgGlasses {
        class GVAR(cigar): GVAR(cigarBase) {};
    };

    // nvg slot
    class CfgWeapons {
        class GVAR(cigar): GVAR(cigarBase) {};
    };
};

class XtdGearInfos {
    class CfgGlasses {
        class GVAR(cigar0) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
        };
    };

    class CfgWeapons {
        class GVAR(cigar0_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
        };
    };
};
