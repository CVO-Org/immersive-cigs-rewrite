// Faction presets for the Global Mobilization factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - Only the countries with units get an entry: West Germany, East Germany, Poland, Denmark and the Revolutionaries.
//   The other GM countries only exist for flags and markings.
// - The border guards and civilians (gm_fc_xx_bgs, gm_fc_xx_civ) inherit from their country and get its packs through config inheritance.
// - Era preset (Cold War, 1970s-80s): each country's own brand first, then older brands of the same bloc. No gag brands.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ WEST
    class gm_fc_ge {        // West Germany (+ Borderguards, Civilians)
        PVAR(packs)[] = { QEGVAR(ernte_23,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(morley,cigpack) };
    };
    class gm_fc_dk {        // Denmark
        PVAR(packs)[] = { QEGVAR(prince,cigpack), QEGVAR(morley,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack) };
    };

    // ------------------------------------------------------------------------ EAST
    class gm_fc_gc {        // East Germany (+ Borderguards, Civilians)
        PVAR(packs)[] = { QEGVAR(f6,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) };
    };
    class gm_fc_pl {        // Poland
        PVAR(packs)[] = { QEGVAR(popularne,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) };
    };

    // ------------------------------------------------------------------------ GUER
    class gm_fc_xx {        // Revolutionaries - whatever the Eastern Bloc smuggled in
        PVAR(packs)[] = { QEGVAR(popularne,cigpack), QEGVAR(f6,cigpack), QEGVAR(kosmos,cigpack) };
    };
};
