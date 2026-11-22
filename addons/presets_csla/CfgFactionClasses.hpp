// Faction presets for the CSLA Iron Curtain factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - Era preset (1985): Sparta for the Czechoslovaks, Soviet brands behind it, US brands for the Americans. No gag brands.
// - AFMC has no entry yet: what the faction is still has to be found out. It gets the default presets until then.
// - FIA_CIV has no units, so it has no entry.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ Czechoslovakia
    class CSLA {            // CSLA
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) };
    };
    class CSLA_DES {        // CSLA (Desert)
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) };
    };
    class CSLA_CIV {        // Civilians [ČSLA]
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) };
    };

    // ------------------------------------------------------------------------ Resistance
    class FIA {             // FIA [CSLA]
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(lucky_strike,cigpack) };
    };
    class FIA_DES {         // FIA [CSLA] (Desert)
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(lucky_strike,cigpack) };
    };

    // ------------------------------------------------------------------------ US
    class US85 {            // US '85
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(morley,cigpack), QEGVAR(craven,cigpack) };
    };
    class US85_DES {        // US '85 (Desert)
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(morley,cigpack), QEGVAR(craven,cigpack) };
    };
};
