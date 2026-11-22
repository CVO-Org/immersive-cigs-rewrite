// Faction presets for the Expeditionary Forces factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - The French-led MJTF gets Troupes and Matelot, plus Crayons: Expeditionary Forces is the CDLC with the crayon joke.
// - The Navy has no Crayons.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {
    class EF_B_MJTF_Des {   // MJTF (Desert)
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(crayons,crayonpack) };
    };
    class EF_B_MJTF_Wdl {   // MJTF (Woodland)
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(crayons,crayonpack) };
    };
    class EF_B_MJTF_Navy {  // MJTF (Navy)
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(troupes,cigpack), QEGVAR(morley,cigpack) };
    };
};
