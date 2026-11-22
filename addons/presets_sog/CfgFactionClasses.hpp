// Faction presets for the S.O.G. Prairie Fire factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - Era preset (Vietnam War): Savage, Lucky Strike, Morley, Craven "A" and Kosmos, plus the two Asian brands of the era,
//   Ruby Queen (South Vietnam) and Hwarang (South Korea). No gag brands, no modern regional brands, no Apollo Soyuz (1975).
// - Ruby Queen is the local cigarette of the whole theatre, so it also stands in for Laos, Cambodia and the communist side.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ US
    class B_MACV {          // MACV
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class B_CIA {           // US CIA
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class B_MEDT {          // US MEDT
        PVAR(packs)[] = { QEGVAR(lucky_strike,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };

    // ------------------------------------------------------------------------ Allies
    class B_AUS {           // Australia
        PVAR(packs)[] = { QEGVAR(craven,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class B_NZ {            // New Zealand
        PVAR(packs)[] = { QEGVAR(craven,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class B_ROK {           // Republic Of Korea
        PVAR(packs)[] = { QEGVAR(hwarang,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(savage,cigpack) };
    };

    // ------------------------------------------------------------------------ South Vietnam, Laos, Cambodia
    class I_ARVN {          // ARVN
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(savage,cigpack) };
    };
    class I_LAO {           // Royal Lao Army
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class I_CAM {           // FANK
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };
    class C_VIET {          // Vietnamese
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(morley,cigpack) };
    };

    // ------------------------------------------------------------------------ Communist forces
    class O_PAVN {          // PAVN
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(savage,cigpack) };
    };
    class O_VC {            // Viet Cong
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(savage,cigpack) };
    };
    class O_PL {            // Pathet Lao
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(savage,cigpack) };
    };
    class O_CAM {           // Khmer Rouge
        PVAR(packs)[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(savage,cigpack) };
    };
};
