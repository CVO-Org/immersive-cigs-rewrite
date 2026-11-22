// ACE Arsenal Extended (AAE) compat: groups all cigarette brands into one arsenal entry with a brand and a stage selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.
// Each brand adds its own items to this model in its aceax.hpp (XtdGearInfos).
// Labels are the plain brand name (not translated, and short so the selector buttons stay readable), with the pack icon behind it
// and the full name as tooltip.
// A new brand needs its value here too. AAE hides values without items, so brands from optional addons (savage) are safe to list.

class XtdGearModels {
    class GVAR(cigaretteBase) {
        label = CSTRING(aceax_cigarette);
        author = ECSTRING(main,author);
        options[] = { "brand", "stage" };

        class brand {
            label = CSTRING(aceax_brand);
            centerImage = 1;    // pack icon as a square behind each button
            values[] = { "alborz", "almyra", "apollo", "baja_blast", "black_devil", "camel", "casa_sport", "craven", "eckstein", "ernte_23", "f6", "gudok", "hwarang", "juno", "kosmos", "lipa", "lipa_dzwonek", "lucky_strike", "marlboro", "matelot", "morley", "nil", "popularne", "prince", "ruby_queen", "savage", "shanhai", "sosna", "sparta", "troupes", "voron", "zamok" };

            class alborz       { label = "Alborz"; image = QPATHTOEF(alborz,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(alborz,cigarette); };
            class almyra       { label = "Almyra"; image = QPATHTOEF(almyra,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(almyra,cigarette); };
            class apollo       { label = "Apollo Soyuz"; image = QPATHTOEF(apollo,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(apollo,cigarette); };
            class baja_blast   { label = "Baja Blast"; image = QPATHTOEF(baja_blast,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(baja_blast,cigarette); };
            class black_devil  { label = "Black Devil"; image = QPATHTOEF(black_devil,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(black_devil,cigarette); };
            class camel        { label = "Camel"; image = QPATHTOEF(camel,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(camel,cigarette); };
            class casa_sport   { label = "Casa Sports"; image = QPATHTOEF(casa_sport,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(casa_sport,cigarette); };
            class craven       { label = "Craven A"; image = QPATHTOEF(craven,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(craven,cigarette); };
            class eckstein     { label = "Eckstein"; image = QPATHTOEF(eckstein,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(eckstein,cigarette); };
            class ernte_23     { label = "Ernte 23"; image = QPATHTOEF(ernte_23,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(ernte_23,cigarette); };
            class f6           { label = "f6"; image = QPATHTOEF(f6,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(f6,cigarette); };
            class gudok        { label = "Gudok"; image = QPATHTOEF(gudok,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(gudok,cigarette); };
            class hwarang      { label = "Hwarang"; image = QPATHTOEF(hwarang,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(hwarang,cigarette); };
            class juno         { label = "Juno"; image = QPATHTOEF(juno,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(juno,cigarette); };
            class kosmos       { label = "Kosmos"; image = QPATHTOEF(kosmos,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(kosmos,cigarette); };
            class lipa         { label = "Lipa"; image = QPATHTOEF(lipa,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(lipa,cigarette); };
            class lipa_dzwonek { label = "Lipa Dzwonek"; image = QPATHTOEF(lipa_dzwonek,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(lipa_dzwonek,cigarette); };
            class lucky_strike { label = "Lucky Strike"; image = QPATHTOEF(lucky_strike,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(lucky_strike,cigarette); };
            class marlboro     { label = "Marlboro"; image = QPATHTOEF(marlboro,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(marlboro,cigarette); };
            class matelot      { label = "Matelot"; image = QPATHTOEF(matelot,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(matelot,cigarette); };
            class morley       { label = "Morley"; image = QPATHTOEF(morley,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(morley,cigarette); };
            class nil          { label = "NIL"; image = QPATHTOEF(nil,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(nil,cigarette); };
            class popularne    { label = "Popularne"; image = QPATHTOEF(popularne,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(popularne,cigarette); };
            class prince       { label = "Prince"; image = QPATHTOEF(prince,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(prince,cigarette); };
            class ruby_queen   { label = "Ruby Queen"; image = QPATHTOEF(ruby_queen,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(ruby_queen,cigarette); };
            class savage       { label = "Savage"; image = "\vn\weapons_f_vietnam\ui\icon_vn_b_item_cigs_01_ca.paa"; description = ECSTRING(savage,cigarette); };
            class shanhai      { label = "Shanhai"; image = QPATHTOEF(shanhai,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(shanhai,cigarette); };
            class sosna        { label = "Sosna"; image = QPATHTOEF(sosna,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(sosna,cigarette); };
            class sparta       { label = "Sparta"; image = QPATHTOEF(sparta,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(sparta,cigarette); };
            class troupes      { label = "Troupes"; image = QPATHTOEF(troupes,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(troupes,cigarette); };
            class voron        { label = "Voron"; image = QPATHTOEF(voron,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(voron,cigarette); };
            class zamok        { label = "Zamok"; image = QPATHTOEF(zamok,data\ui\gear_cigpack_x_ca.paa); description = ECSTRING(zamok,cigarette); };
        };

        class stage {
            label = CSTRING(aceax_stage);
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
        class GVAR(cigarette): GVAR(cigaretteBase) {};
    };

    // nvg slot
    class CfgWeapons {
        class GVAR(cigarette): GVAR(cigaretteBase) {};
    };
};
