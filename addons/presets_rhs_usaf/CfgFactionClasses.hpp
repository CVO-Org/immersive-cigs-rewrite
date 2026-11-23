// Faction presets for the RHS: USAF factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - All US factions (USMC, Army and USMC woodland/desert, USAF, USN, SOCOM) inherit from rhs_faction_usarmy,
//   so one entry covers them all through config inheritance.
// - Modern US: Marlboro, Camel, Newport (separate brand addon, dropped until it is loaded) and Morley. No gag brands.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    class rhs_faction_usarmy {      // US Army (+ USMC, USAF, USN, SOCOM and the woodland/desert variants through inheritance)
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(newport,cigpack), QEGVAR(morley,cigpack) };
    };
};
