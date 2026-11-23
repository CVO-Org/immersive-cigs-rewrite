// ACE Arsenal Extended (AAE) compat, loaded only with AAE: skipWhenMissingDependencies drops this whole config without it.
// Shows the stage 0 cigarette (facewear and NVG slot), which is scope 1 without AAE, and adds this addon's items to AAE's model (..\aceax.hpp).

#include "..\script_component.hpp"

class CfgPatches {
    class DOUBLES(ADDON,compat_aceax) {
        name = Q(PREFIX_BEAUTIFIED - COMPONENT_BEAUTIFIED - ACE Arsenal Extended);
        author = ECSTRING(main,author);
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QUOTE(ADDON), "aceax_gearinfo" };
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = { QGVAR(cig0_nv) };
    };
};

class CfgGlasses {
    class EGVAR(base,cigBase);
    class GVAR(cig0): EGVAR(base,cigBase) {
        scope = 2;
    };
};

class CfgWeapons {
    class EGVAR(base,cigBase_nv);
    class GVAR(cig0_nv): EGVAR(base,cigBase_nv) {
        scope = 2;
    };
};

#include "..\aceax.hpp"
