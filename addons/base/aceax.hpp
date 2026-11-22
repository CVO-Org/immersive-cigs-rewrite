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
            values[] = { "alborz", "almyra", "apollo", "baja_blast", "black_devil", "camel", "casa_sport", "craven", "eckstein", "ernte_23", "f6", "hwarang", "juno", "kosmos", "lipa", "lipa_dzwonek", "lucky_strike", "marlboro", "matelot", "morley", "nil", "popularne", "prince", "ruby_queen", "savage", "shanhai", "sparta", "troupes", "voron" };

            class alborz       { label = ECSTRING(alborz,cigarette); };
            class almyra       { label = ECSTRING(almyra,cigarette); };
            class apollo       { label = ECSTRING(apollo,cigarette); };
            class baja_blast   { label = ECSTRING(baja_blast,cigarette); };
            class black_devil  { label = ECSTRING(black_devil,cigarette); };
            class camel        { label = ECSTRING(camel,cigarette); };
            class casa_sport   { label = ECSTRING(casa_sport,cigarette); };
            class craven       { label = ECSTRING(craven,cigarette); };
            class eckstein     { label = ECSTRING(eckstein,cigarette); };
            class ernte_23     { label = ECSTRING(ernte_23,cigarette); };
            class f6           { label = ECSTRING(f6,cigarette); };
            class hwarang      { label = ECSTRING(hwarang,cigarette); };
            class juno         { label = ECSTRING(juno,cigarette); };
            class kosmos       { label = ECSTRING(kosmos,cigarette); };
            class lipa         { label = ECSTRING(lipa,cigarette); };
            class lipa_dzwonek { label = ECSTRING(lipa_dzwonek,cigarette); };
            class lucky_strike { label = ECSTRING(lucky_strike,cigarette); };
            class marlboro     { label = ECSTRING(marlboro,cigarette); };
            class matelot      { label = ECSTRING(matelot,cigarette); };
            class morley       { label = ECSTRING(morley,cigarette); };
            class nil          { label = ECSTRING(nil,cigarette); };
            class popularne    { label = ECSTRING(popularne,cigarette); };
            class prince       { label = ECSTRING(prince,cigarette); };
            class ruby_queen   { label = ECSTRING(ruby_queen,cigarette); };
            class savage       { label = ECSTRING(savage,cigarette); };
            class shanhai      { label = ECSTRING(shanhai,cigarette); };
            class sparta       { label = ECSTRING(sparta,cigarette); };
            class troupes      { label = ECSTRING(troupes,cigarette); };
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
