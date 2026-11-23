// Faction presets for the RHS: AFRF factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - All Russian factions (VDV, VDV 1945, VMF, VV, TV, VPVO, VVS, RVA) inherit from rhs_faction_msv,
//   so one entry covers them all through config inheritance.
// - Modern Russia: Belomorkanal and Parliament (separate brand addons, dropped until they are loaded),
//   plus Kosmos and Apollo Soyuz: Cold War brands, kept for the modern Russian factions on purpose.
// - Eastern Militia: Chernarus brands (used for every era) plus the Russian papirosa.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    class rhs_faction_msv {         // Russia - MSV (+ VDV, VMF, VV, TV, VPVO, VVS, RVA through inheritance)
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class rhs_faction_insurgents {  // Eastern Militia
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(zamok,cigpack), QEGVAR(kosmos,cigpack) };
    };
};
