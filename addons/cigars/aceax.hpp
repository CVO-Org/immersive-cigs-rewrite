// ACE Arsenal Extended (AAE) compat: groups all cigars into one arsenal entry with a brand and a stage selector.
// Included by compat_aceax\config.cpp, which only loads with AAE.
// Each cigar brand adds its own items to this model in its aceax.hpp (XtdGearInfos). A new brand needs its value here too.

class XtdGearModels {
    class GVAR(cigarBase) {
        label = CSTRING(cigar);
        author = ECSTRING(main,author);
        options[] = { "brand", "stage" };

        class brand {
            label = ECSTRING(base,aceax_brand);
            centerImage = 1;    // box front as a square on each button
            values[] = { "cigars", "papa_schultz" };

            // only the box front (data\ui\aceax_logo_ca.paa, made by tools/gear_icons/aceax_logos.py), no label; the full name is the tooltip
            class cigars       { label = ""; image = QPATHTOF(data\ui\aceax_logo_ca.paa); description = CSTRING(cigar); };
            class papa_schultz { label = ""; image = QPATHTOEF(papa_schultz,data\ui\aceax_logo_ca.paa); description = ECSTRING(papa_schultz,cigar); };
        };

        class stage {
            label = ECSTRING(base,aceax_stage);
            values[] = { "s0", "s1", "s2", "s3", "s4" };

            class s0 { label = "0"; };
            class s1 { label = "1"; };
            class s2 { label = "2"; };
            class s3 { label = "3"; };
            class s4 { label = "4"; };
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
            stage = "s0";
        };
        class GVAR(cigar1) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cigar2) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cigar3) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cigar4) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };

    class CfgWeapons {
        class GVAR(cigar0_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s0";
        };
        class GVAR(cigar1_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cigar2_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cigar3_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cigar4_nv) {
            model = QGVAR(cigar);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };
};
