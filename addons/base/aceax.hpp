// ACE Arsenal Extended (AAE) compat: groups all cigarette brands into one arsenal entry with a brand selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.
// Each brand adds its own items to this model in its aceax.hpp (XtdGearInfos).
// A new brand needs its value here too. AAE hides values without items, so brands from optional addons (savage) are safe to list.

class XtdGearModels {
    class GVAR(cigaretteBase) {
        label = CSTRING(aceax_cigarette);
        author = ECSTRING(main,author);
        options[] = { "brand" };

        class brand {
            label = CSTRING(aceax_brand);
            values[] = { "apollo", "baja_blast", "black_devil", "craven", "eckstein", "kosmos", "lucky_strike", "morley", "nil", "savage", "voron" };

            class apollo       { label = ECSTRING(apollo,cigarette); };
            class baja_blast   { label = ECSTRING(baja_blast,cigarette); };
            class black_devil  { label = ECSTRING(black_devil,cigarette); };
            class craven       { label = ECSTRING(craven,cigarette); };
            class eckstein     { label = ECSTRING(eckstein,cigarette); };
            class kosmos       { label = ECSTRING(kosmos,cigarette); };
            class lucky_strike { label = ECSTRING(lucky_strike,cigarette); };
            class morley       { label = ECSTRING(morley,cigarette); };
            class nil          { label = ECSTRING(nil,cigarette); };
            class savage       { label = ECSTRING(savage,cigarette); };
            class voron        { label = ECSTRING(voron,cigarette); };
        };
    };

    // facewear
    class CfgGlasses {
        class GVAR(cigarette): GVAR(cigaretteBase) {};
    };

    // nvg slot
    class CfgWeapons {
        class GVAR(cigarette): GVAR(cigaretteBase) {};
    };
};
