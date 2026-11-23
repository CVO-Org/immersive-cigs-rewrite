// ACE Arsenal Extended (AAE) compat: adds this addon's items (every burn stage) to the cigarette model, see base\aceax.hpp.
// Included by compat_aceax\config.cpp, which only loads with AAE.
// AAE only offers items that are in the arsenal: the burn stages show in dev builds, in release builds they're scope 1.

class XtdGearInfos {
    class CfgGlasses {
        class GVAR(cig0) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s0";
        };
        class GVAR(cig1) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cig2) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cig3) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cig4) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };

    class CfgWeapons {
        class GVAR(cig0_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s0";
        };
        class GVAR(cig1_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s1";
        };
        class GVAR(cig2_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s2";
        };
        class GVAR(cig3_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s3";
        };
        class GVAR(cig4_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
            stage = "s4";
        };
    };
};
