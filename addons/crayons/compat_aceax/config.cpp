// ACE Arsenal Extended (AAE) compat, loaded only with AAE: skipWhenMissingDependencies drops this whole config without it.
// Shows the crayons (facewear and NVG slot), which are scope 1 without AAE: every colour inherits its scope from crayon_black.
// Also adds the crayons to AAE's model (..\aceax.hpp).

#include "..\script_component.hpp"

class CfgPatches {
    class DOUBLES(ADDON,compat_aceax) {
        name = Q(PREFIX_BEAUTIFIED - COMPONENT_BEAUTIFIED - ACE Arsenal Extended);
        author = ECSTRING(main,author);
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = { QUOTE(ADDON), "aceax_gearinfo" };
        skipWhenMissingDependencies = 1;
        units[] = {};
        weapons[] = { QGVAR(crayon_black_nv) };
    };
};

class CfgGlasses {
    class EGVAR(pops,popBase);
    class GVAR(crayon_black): EGVAR(pops,popBase) {
        scope = 2;
    };
};

class CfgWeapons {
    class EGVAR(pops,popBase_nv);
    class GVAR(crayon_black_nv): EGVAR(pops,popBase_nv) {
        scope = 2;
    };
};

#include "..\aceax.hpp"
