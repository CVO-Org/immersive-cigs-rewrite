// Faction presets for the Spearhead 1944 factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - Era preset (1944): Eckstein and Juno for the Germans, Troupes for the French, Lucky Strike and Camel for the US Army
//   and the French Liberation Army it supplied.
//   No gag brands, no modern brands.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ Germany
    class SPE_WEHRMACHT {   // Wehrmacht
        PVAR(packs)[] = { QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack) };
    };
    class SPE_STURM {       // Sturmtroopers
        PVAR(packs)[] = { QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack) };
    };

    // ------------------------------------------------------------------------ France
    class SPE_MILICE {      // La Milice
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack) };
    };
    class SPE_FFI {         // French Interior Forces
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(lucky_strike,cigpack) };
    };
    class SPE_FR_ARMY {     // French Liberation Army
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(camel,cigpack), QEGVAR(craven,cigpack) };
    };
    class SPE_CIV {         // 40s Civilians
        PVAR(packs)[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(eckstein,cigpack) };
    };

    // ------------------------------------------------------------------------ US
    class SPE_US_ARMY {     // US Army
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(craven,cigpack) };
    };
};
