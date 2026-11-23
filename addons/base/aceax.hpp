// ACE Arsenal Extended (AAE) compat: groups all cigarette brands into one arsenal entry with a brand and a stage selector.
// Plain config data only - without AAE these classes are unused, so no dependency is needed.
// Each brand adds its own items to this model in its aceax.hpp (XtdGearInfos).
// The buttons show only the brand's pack front (data\ui\aceax_logo_ca.paa, made by tools/gear_icons/aceax_logos.py), no label;
// the full name is the tooltip.
// A new brand needs its value here too. AAE hides values without items, so brands from optional addons (savage) are safe to list.

class XtdGearModels {
    class GVAR(cigaretteBase) {
        label = CSTRING(aceax_cigarette);
        author = ECSTRING(main,author);
        options[] = { "brand", "stage" };

        class brand {
            label = CSTRING(aceax_brand);
            centerImage = 1;    // pack front as a square on each button
            values[] = { "alborz", "almyra", "apollo", "baja_blast", "black_devil", "camel", "casa_sport", "cleopatra", "craven", "death", "ducados", "eckstein", "ernte_23", "f6", "gudang_garam", "gudok", "hwarang", "jaffudi", "john_silver", "juno", "klubi", "kosmos", "lipa", "lipa_dzwonek", "lucky_strike", "marlboro", "matelot", "morley", "nil", "parisienne", "pielroja", "popularne", "prince", "ruby_queen", "savage", "shanhai", "sharig", "sobranie", "sosna", "sparta", "troupes", "voron", "zamok", "zargabad" };

            class alborz       { label = ""; image = QPATHTOEF(alborz,data\ui\aceax_logo_ca.paa); description = ECSTRING(alborz,cigarette); };
            class almyra       { label = ""; image = QPATHTOEF(almyra,data\ui\aceax_logo_ca.paa); description = ECSTRING(almyra,cigarette); };
            class apollo       { label = ""; image = QPATHTOEF(apollo,data\ui\aceax_logo_ca.paa); description = ECSTRING(apollo,cigarette); };
            class baja_blast   { label = ""; image = QPATHTOEF(baja_blast,data\ui\aceax_logo_ca.paa); description = ECSTRING(baja_blast,cigarette); };
            class black_devil  { label = ""; image = QPATHTOEF(black_devil,data\ui\aceax_logo_ca.paa); description = ECSTRING(black_devil,cigarette); };
            class camel        { label = ""; image = QPATHTOEF(camel,data\ui\aceax_logo_ca.paa); description = ECSTRING(camel,cigarette); };
            class casa_sport   { label = ""; image = QPATHTOEF(casa_sport,data\ui\aceax_logo_ca.paa); description = ECSTRING(casa_sport,cigarette); };
            class cleopatra   { label = ""; image = QPATHTOEF(cleopatra,data\ui\aceax_logo_ca.paa); description = ECSTRING(cleopatra,cigarette); };
            class craven       { label = ""; image = QPATHTOEF(craven,data\ui\aceax_logo_ca.paa); description = ECSTRING(craven,cigarette); };
            class death        { label = ""; image = QPATHTOEF(death,data\ui\aceax_logo_ca.paa); description = ECSTRING(death,cigarette); };
            class ducados       { label = ""; image = QPATHTOEF(ducados,data\ui\aceax_logo_ca.paa); description = ECSTRING(ducados,cigarette); };
            class eckstein     { label = ""; image = QPATHTOEF(eckstein,data\ui\aceax_logo_ca.paa); description = ECSTRING(eckstein,cigarette); };
            class ernte_23     { label = ""; image = QPATHTOEF(ernte_23,data\ui\aceax_logo_ca.paa); description = ECSTRING(ernte_23,cigarette); };
            class f6           { label = ""; image = QPATHTOEF(f6,data\ui\aceax_logo_ca.paa); description = ECSTRING(f6,cigarette); };
            class gudang_garam { label = ""; image = QPATHTOEF(gudang_garam,data\ui\aceax_logo_ca.paa); description = ECSTRING(gudang_garam,cigarette); };
            class gudok        { label = ""; image = QPATHTOEF(gudok,data\ui\aceax_logo_ca.paa); description = ECSTRING(gudok,cigarette); };
            class hwarang      { label = ""; image = QPATHTOEF(hwarang,data\ui\aceax_logo_ca.paa); description = ECSTRING(hwarang,cigarette); };
            class jaffudi      { label = ""; image = QPATHTOEF(jaffudi,data\ui\aceax_logo_ca.paa); description = ECSTRING(jaffudi,cigarette); };
            class john_silver  { label = ""; image = QPATHTOEF(john_silver,data\ui\aceax_logo_ca.paa); description = ECSTRING(john_silver,cigarette); };
            class juno         { label = ""; image = QPATHTOEF(juno,data\ui\aceax_logo_ca.paa); description = ECSTRING(juno,cigarette); };
            class klubi        { label = ""; image = QPATHTOEF(klubi,data\ui\aceax_logo_ca.paa); description = ECSTRING(klubi,cigarette); };
            class kosmos       { label = ""; image = QPATHTOEF(kosmos,data\ui\aceax_logo_ca.paa); description = ECSTRING(kosmos,cigarette); };
            class lipa         { label = ""; image = QPATHTOEF(lipa,data\ui\aceax_logo_ca.paa); description = ECSTRING(lipa,cigarette); };
            class lipa_dzwonek { label = ""; image = QPATHTOEF(lipa_dzwonek,data\ui\aceax_logo_ca.paa); description = ECSTRING(lipa_dzwonek,cigarette); };
            class lucky_strike { label = ""; image = QPATHTOEF(lucky_strike,data\ui\aceax_logo_ca.paa); description = ECSTRING(lucky_strike,cigarette); };
            class marlboro     { label = ""; image = QPATHTOEF(marlboro,data\ui\aceax_logo_ca.paa); description = ECSTRING(marlboro,cigarette); };
            class matelot      { label = ""; image = QPATHTOEF(matelot,data\ui\aceax_logo_ca.paa); description = ECSTRING(matelot,cigarette); };
            class morley       { label = ""; image = QPATHTOEF(morley,data\ui\aceax_logo_ca.paa); description = ECSTRING(morley,cigarette); };
            class nil          { label = ""; image = QPATHTOEF(nil,data\ui\aceax_logo_ca.paa); description = ECSTRING(nil,cigarette); };
            class parisienne   { label = ""; image = QPATHTOEF(parisienne,data\ui\aceax_logo_ca.paa); description = ECSTRING(parisienne,cigarette); };
            class pielroja     { label = ""; image = QPATHTOEF(pielroja,data\ui\aceax_logo_ca.paa); description = ECSTRING(pielroja,cigarette); };
            class popularne    { label = ""; image = QPATHTOEF(popularne,data\ui\aceax_logo_ca.paa); description = ECSTRING(popularne,cigarette); };
            class prince       { label = ""; image = QPATHTOEF(prince,data\ui\aceax_logo_ca.paa); description = ECSTRING(prince,cigarette); };
            class ruby_queen   { label = ""; image = QPATHTOEF(ruby_queen,data\ui\aceax_logo_ca.paa); description = ECSTRING(ruby_queen,cigarette); };
            class savage       { label = "Savage"; description = ECSTRING(savage,cigarette); };    // no logo: its pack is S.O.G.'s, and AAE draws the button even without the CDLC
            class shanhai      { label = ""; image = QPATHTOEF(shanhai,data\ui\aceax_logo_ca.paa); description = ECSTRING(shanhai,cigarette); };
            class sharig       { label = ""; image = QPATHTOEF(sharig,data\ui\aceax_logo_ca.paa); description = ECSTRING(sharig,cigarette); };
            class sobranie     { label = ""; image = QPATHTOEF(sobranie,data\ui\aceax_logo_ca.paa); description = ECSTRING(sobranie,cigarette); };
            class sosna        { label = ""; image = QPATHTOEF(sosna,data\ui\aceax_logo_ca.paa); description = ECSTRING(sosna,cigarette); };
            class sparta       { label = ""; image = QPATHTOEF(sparta,data\ui\aceax_logo_ca.paa); description = ECSTRING(sparta,cigarette); };
            class troupes      { label = ""; image = QPATHTOEF(troupes,data\ui\aceax_logo_ca.paa); description = ECSTRING(troupes,cigarette); };
            class voron        { label = ""; image = QPATHTOEF(voron,data\ui\aceax_logo_ca.paa); description = ECSTRING(voron,cigarette); };
            class zamok        { label = ""; image = QPATHTOEF(zamok,data\ui\aceax_logo_ca.paa); description = ECSTRING(zamok,cigarette); };
            class zargabad     { label = ""; image = QPATHTOEF(zargabad,data\ui\aceax_logo_ca.paa); description = ECSTRING(zargabad,cigarette); };
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
