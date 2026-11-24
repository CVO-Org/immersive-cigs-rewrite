// Faction presets for the RHS: GREF factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - Entries go on the base classes. The other sides' variants (_b, _g) inherit from them and get the same packs.
// - Chernarus (CDF, NAPA, ChDKZ): the Chernarus brands Gudok, Zamok and Sosna, used for every era.
//   ChDKZ adds the Russian papirosa Belomorkanal (separate brand addon, dropped until it is loaded) and Kosmos.
// - Horizon Islands (HIDF) and Tanoa (TLA) get Matelot; the TLA guerrillas get the gag brands, like Syndikat.
// - The UN gets international brands plus Prince for the Nordic peacekeepers.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ Chernarus
    class rhsgref_faction_cdf_ground {  // CDF Ground Forces (+ _b)
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class rhsgref_faction_cdf_air {     // CDF Air Forces (+ _b)
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class rhsgref_faction_cdf_ng {      // CDF National Guard (+ _b)
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class rhsgref_faction_nationalist { // NAPA
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class rhsgref_faction_chdkz {       // ChDKZ (+ _g)
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // ------------------------------------------------------------------------ International
    class rhsgref_faction_un {          // United Nations
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(prince,cigpack) };
    };

    // ------------------------------------------------------------------------ Horizon Islands / Tanoa
    class rhsgref_faction_hidf {        // Horizon Islands Defence Force
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class rhsgref_faction_tla {         // Tanoan Liberation Army (+ _g)
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };
};
