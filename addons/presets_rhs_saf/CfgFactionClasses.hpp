// Faction presets for the RHS: SAF factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - Entries go on the base classes. The OPFOR variants (_opfor) inherit from them and get the same packs.
// - Serbia: Drina (separate brand addon, dropped until it is loaded), then international brands.
// - The UN contingent adds Prince, like the other UN presets.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    class rhssaf_faction_army {         // Serbian Army (+ _opfor)
        PVAR(packs)[] = { QEGVAR(drina,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class rhssaf_faction_airforce {     // Serbian Air Force (+ _opfor)
        PVAR(packs)[] = { QEGVAR(drina,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class rhssaf_faction_un {           // Serbian UN contingent
        PVAR(packs)[] = { QEGVAR(drina,cigpack), QEGVAR(camel,cigpack), QEGVAR(prince,cigpack) };
    };
};
