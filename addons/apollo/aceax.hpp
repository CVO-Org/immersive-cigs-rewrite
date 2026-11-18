// ACE Arsenal Extended (AAE) compat: adds this addon's items to the cigarette model, see base\aceax.hpp.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.

class XtdGearInfos {
    class CfgGlasses {
        class GVAR(cig0) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
        };
    };

    class CfgWeapons {
        class GVAR(cig0_nv) {
            model = QEGVAR(base,cigarette);
            brand = QUOTE(COMPONENT);
        };
    };
};
