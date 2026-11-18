// Faction presets for the vanilla factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - Each faction gets a few packs; AI pick 1-3 at random from the list.
// - The new regional brand is the faction's main pack, older brands of the same region fill up the rest.
// - Gag brands (Crayons, Baja Blast, Black Devil) only for NATO's crayon joke, guerrillas and criminals.
// - Voron only for Spetsnaz, LDF and Looters. Cigars are kept for officers (unit class level), never per faction.
// - CIV_F has no entry: it covers Altis, Tanoa and Livonia at once and keeps the default presets' civilian mix.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ NATO
    class BLU_F {           // NATO
        PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack), QEGVAR(crayons,crayonpack) };
    };
    class BLU_T_F {         // NATO (Pacific)
        PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(matelot,cigpack), QEGVAR(crayons,crayonpack) };
    };
    class BLU_W_F {         // NATO (Woodland)
        PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(lipa,cigpack), QEGVAR(crayons,crayonpack) };
    };
    class BLU_CTRG_F {      // CTRG
        PVAR(packs)[] = { QEGVAR(craven,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ Tanoa
    class BLU_GEN_F {       // Gendarmerie
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class OPF_GEN_F {       // Gendarmerie (Old Man)
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class IND_C_F {         // Syndikat
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };

    // ------------------------------------------------------------------------ Altis / Stratis
    class IND_F {           // AAF
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class BLU_G_F {         // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class OPF_G_F {         // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class IND_G_F {         // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ CSAT
    class OPF_F {           // CSAT
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class OPF_T_F {         // CSAT (Pacific)
        PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack) };
    };
    class OPF_V_F {         // Viper
        PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ Livonia
    class OPF_R_F {         // Spetsnaz
        PVAR(packs)[] = { QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(voron,cigpack) };
    };
    class IND_E_F {         // LDF - the "Bluebells" get the Dzwonek edition
        PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
    };
    class IND_L_F {         // Looters
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ Civilians
    class CIV_IDAP_F {      // IDAP
        PVAR(packs)[] = { QEGVAR(pops,poppack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
};
