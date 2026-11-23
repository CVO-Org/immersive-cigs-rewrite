// Faction presets for the Western Sahara factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - SFIA and Tura are entered on their GUER class. The other sides' classes (OPF_SFIA_lxWS, BLU/OPF_TURA_lxWS) inherit from it
//   and get the same packs through config inheritance.
// - SFIA and Tura: Casa Sports as the North African brand, the Egyptian Cleopatra behind it, then the gag brands.
// - ION and UN are international and get the mainstream brands. Their GUER/EAST classes have no units, so only the WEST ones get an entry.
// - NATO (Desert) mirrors vanilla NATO, Crayons included.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ Argana
    class IND_SFIA_lxWS {   // SFIA (+ OPF_SFIA_lxWS)
        PVAR(packs)[] = { QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(morley,cigpack) };
    };
    class IND_TURA_lxWS {   // Tura (+ BLU_TURA_lxWS, OPF_TURA_lxWS)
        PVAR(packs)[] = { QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };

    // ------------------------------------------------------------------------ International
    class BLU_ION_lxWS {    // ION Services
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class BLU_UN_lxWS {     // UNA
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(prince,cigpack) };
    };
    class BLU_NATO_lxWS {   // NATO (Desert)
        PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(crayons,crayonpack) };
    };
};
