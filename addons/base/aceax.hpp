// ACE Arsenal Extended (AAE) compat: groups all cigarette brands into one arsenal entry with a brand selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.
// Each brand adds its own items to this model in its aceax.hpp (XtdGearInfos).
// Labels are the plain brand name (not translated, and short so the selector buttons stay readable).
// A new brand needs its value here too. AAE hides values without items, so brands from optional addons (savage) are safe to list.

class XtdGearModels {
    class GVAR(cigaretteBase) {
        label = CSTRING(aceax_cigarette);
        author = ECSTRING(main,author);
        options[] = { "brand" };

        class brand {
            label = CSTRING(aceax_brand);
            values[] = { "alborz", "almyra", "apollo", "baja_blast", "black_devil", "camel", "casa_sport", "craven", "eckstein", "ernte_23", "f6", "gudok", "hwarang", "juno", "kosmos", "lipa", "lipa_dzwonek", "lucky_strike", "marlboro", "matelot", "morley", "nil", "popularne", "prince", "ruby_queen", "savage", "shanhai", "sosna", "sparta", "troupes", "voron", "zamok" };

            class alborz       { label = "Alborz"; };
            class almyra       { label = "Almyra"; };
            class apollo       { label = "Apollo Soyuz"; };
            class baja_blast   { label = "Baja Blast"; };
            class black_devil  { label = "Black Devil"; };
            class camel        { label = "Camel"; };
            class casa_sport   { label = "Casa Sports"; };
            class craven       { label = "Craven A"; };
            class eckstein     { label = "Eckstein"; };
            class ernte_23     { label = "Ernte 23"; };
            class f6           { label = "f6"; };
            class gudok        { label = "Gudok"; };
            class hwarang      { label = "Hwarang"; };
            class juno         { label = "Juno"; };
            class kosmos       { label = "Kosmos"; };
            class lipa         { label = "Lipa"; };
            class lipa_dzwonek { label = "Lipa Dzwonek"; };
            class lucky_strike { label = "Lucky Strike"; };
            class marlboro     { label = "Marlboro"; };
            class matelot      { label = "Matelot"; };
            class morley       { label = "Morley"; };
            class nil          { label = "NIL"; };
            class popularne    { label = "Popularne"; };
            class prince       { label = "Prince"; };
            class ruby_queen   { label = "Ruby Queen"; };
            class savage       { label = "Savage"; };
            class shanhai      { label = "Shanhai"; };
            class sosna        { label = "Sosna"; };
            class sparta       { label = "Sparta"; };
            class troupes      { label = "Troupes"; };
            class voron        { label = "Voron"; };
            class zamok        { label = "Zamok"; };
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
