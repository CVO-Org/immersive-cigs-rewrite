// Faction presets for the 3CB Factions: which packs AI of a faction get (see docs/modders.md, "Faction presets").
// None of these faction classes has a parent class, so they are extended without one.
//
// - 3CB gives every faction separate classes per side (UK3CB_<X>_O / _B / _I, civilians also _C) without inheritance,
//   so each side class gets its own entry. All sides of a faction get the same packs.
// - Regional brand first, then other brands of the region, then international brands. See docs/readme_brands.md.
// - The Chernarus brands (Gudok, Zamok, Sosna) are used for every era; Belomorkanal and Kosmos stand in for Russian influence.
// - The Takistan brands (Jaffudi, Zargabad, Sharig) cover Takistan, Afghanistan and the Central Asian and Middle Eastern factions.
// - The Middle Eastern and African Desert factions add the Egyptian Cleopatra, the Arab world's best-known cigarette.
// - Belomorkanal is a planned brand (issue #358): dropped until it is in the mod.
// - Gag brands only for guerrillas and militias. Voron only for the LDF. No WW2-era looks.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    // ------------------------------------------------------------------------ Altis / Malden / Tanoa
    class UK3CB_AAF_O {                // AAF
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_AAF_B {                // AAF
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_AAF_I {                // AAF
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_APD_O {                // Altis Police Department
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_APD_B {                // Altis Police Department
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_APD_I {                // Altis Police Department
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_FIA_O {                // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_FIA_B {                // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_FIA_I {                // FIA
        PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_MDF_O {                // Malden Defence Force
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_MDF_B {                // Malden Defence Force
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_MDF_I {                // Malden Defence Force
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_TNM_O {                // Tanoa Nationalist Militia
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };
    class UK3CB_TNM_B {                // Tanoa Nationalist Militia
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };
    class UK3CB_TNM_I {                // Tanoa Nationalist Militia
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
    };
    class UK3CB_TPD_O {                // Horizon Islands Gendarmerie
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_TPD_B {                // Horizon Islands Gendarmerie
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_TPD_I {                // Horizon Islands Gendarmerie
        PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ Livonia
    class UK3CB_LDF_O {                // Livonia Defence Force
        PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LDF_B {                // Livonia Defence Force
        PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LDF_I {                // Livonia Defence Force
        PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LFR_O {                // Livonia Forest Rangers
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(lipa_dzwonek,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LFR_B {                // Livonia Forest Rangers
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(lipa_dzwonek,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LFR_I {                // Livonia Forest Rangers
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(lipa_dzwonek,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LNM_O {                // Livonian Nationalist Militia
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(popularne,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LNM_B {                // Livonian Nationalist Militia
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(popularne,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LNM_I {                // Livonian Nationalist Militia
        PVAR(packs)[] = { QEGVAR(lipa,cigpack), QEGVAR(popularne,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_LSM_O {                // Livonia Separatist Militia
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(lipa,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_LSM_B {                // Livonia Separatist Militia
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(lipa,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_LSM_I {                // Livonia Separatist Militia
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(lipa,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // ------------------------------------------------------------------------ Chernarus and neighbours
    class UK3CB_CHC_O {                // Chernarus Civilians
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHC_B {                // Chernarus Civilians
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHC_I {                // Chernarus Civilians
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHC_C {                // Chernarus Civilians
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CPD_O {                // Chernarus Police Department
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CPD_B {                // Chernarus Police Department
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CPD_I {                // Chernarus Police Department
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NAP_O {                // NAPA
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NAP_B {                // NAPA
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NAP_I {                // NAPA
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_GAF_O {                // Grozovia Armed Forces
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_GAF_B {                // Grozovia Armed Forces
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_GAF_I {                // Grozovia Armed Forces
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };

    // ------------------------------------------------------------------------ Nogova / Kolgujev
    class UK3CB_NFA_O {                // Nogovan Freedom Alliance
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NFA_B {                // Nogovan Freedom Alliance
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NFA_I {                // Nogovan Freedom Alliance
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_NPD_O {                // Nogova Police Department
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_NPD_B {                // Nogova Police Department
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_NPD_I {                // Nogova Police Department
        PVAR(packs)[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_KDF_O {                // Kolgujev Defence Force
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_KDF_B {                // Kolgujev Defence Force
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_KDF_I {                // Kolgujev Defence Force
        PVAR(packs)[] = { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };

    // ------------------------------------------------------------------------ Takistan / Afghanistan / Central Asia
    class UK3CB_TKA_O {                // Takistan National Army
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKA_B {                // Takistan National Army
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKA_I {                // Takistan National Army
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKC_O {                // Takistan Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKC_B {                // Takistan Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKC_I {                // Takistan Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKC_C {                // Takistan Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKP_O {                // Takistan National Police
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKP_B {                // Takistan National Police
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKP_I {                // Takistan National Police
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ANA_B {                // Afghan National Army
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ANP_B {                // Afghan National Police
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ARD_O {                // Ardistan Army
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(belomorkanal,cigpack) };
    };
    class UK3CB_ARD_B {                // Ardistan Army
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(belomorkanal,cigpack) };
    };
    class UK3CB_ARD_I {                // Ardistan Army
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(belomorkanal,cigpack) };
    };
    class UK3CB_KRG_O {                // Karzeghistan Royal Guard
        PVAR(packs)[] = { QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_KRG_B {                // Karzeghistan Royal Guard
        PVAR(packs)[] = { QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_KRG_I {                // Karzeghistan Royal Guard
        PVAR(packs)[] = { QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };

    class UK3CB_TKM_O {                // Takistan Insurgents
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_TKM_B {                // Takistan Pro-Government Militia
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_TKM_I {                // Takistan Tribal Fighters
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // ------------------------------------------------------------------------ Middle East
    class UK3CB_MEC_O {                // Middle East Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(alborz,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_MEC_B {                // Middle East Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(alborz,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_MEC_I {                // Middle East Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(alborz,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_MEC_C {                // Middle East Civilians
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(alborz,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_MEI_O {                // Middle East Insurgents
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(sharig,cigpack), QEGVAR(alborz,cigpack) };
    };
    class UK3CB_MEI_B {                // Middle East Insurgents
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(sharig,cigpack), QEGVAR(alborz,cigpack) };
    };
    class UK3CB_MEI_I {                // Middle East Insurgents
        PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(sharig,cigpack), QEGVAR(alborz,cigpack) };
    };
    class UK3CB_MEE_O {                // Middle East Extremists
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(alborz,cigpack), QEGVAR(zargabad,cigpack) };
    };
    class UK3CB_MEE_I {                // Middle East Extremists
        PVAR(packs)[] = { QEGVAR(sharig,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(alborz,cigpack), QEGVAR(zargabad,cigpack) };
    };

    // ------------------------------------------------------------------------ African Desert
    class UK3CB_ADA_O {                // African Desert Army
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADA_B {                // African Desert Army
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADA_I {                // African Desert Army
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADR_O {                // African Desert Army Paramilitary
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADR_B {                // African Desert Army Paramilitary
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADR_I {                // African Desert Army Paramilitary
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADP_O {                // African Desert National Police
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADP_B {                // African Desert National Police
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADP_I {                // African Desert National Police
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADC_O {                // African Desert Civilians
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADC_B {                // African Desert Civilians
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADC_I {                // African Desert Civilians
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADC_C {                // African Desert Civilians
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ADG_O {                // African Desert Civilian Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADG_B {                // African Desert Civilian Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADG_I {                // African Desert Civilian Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADM_O {                // African Desert Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADM_B {                // African Desert Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADM_I {                // African Desert Militia
        PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_ADE_O {                // African Desert Extremists
        PVAR(packs)[] = { QEGVAR(casa_sport,cigpack), QEGVAR(sportsman,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack) };
    };
    class UK3CB_ADE_I {                // African Desert Extremists
        PVAR(packs)[] = { QEGVAR(casa_sport,cigpack), QEGVAR(sportsman,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack) };
    };

    // ------------------------------------------------------------------------ Other guerrillas
    class UK3CB_PLM_O {                // PLM (People's Liberation Movement)
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_PLM_B {                // PLM (People's Liberation Movement)
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_PLM_I {                // PLM (People's Liberation Movement)
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class UK3CB_WEI_O {                // Western European Insurgents
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_WEI_B {                // Western European Insurgents
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };
    class UK3CB_WEI_I {                // Western European Insurgents
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ International
    class UK3CB_UN_B {                 // UN Peacekeepers
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(prince,cigpack) };
    };
    class UK3CB_UN_I {                 // UN Peacekeepers
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(prince,cigpack) };
    };

    // ------------------------------------------------------------------------ Chernarus: the three movements of the ChDKZ family and the Chernarus militias (one side each)
    class UK3CB_CCM_O {                // Chernarus Communist Militia
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CCM_B {                // Chernarus Local Defence Volunteers
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CCM_I {                // Chernarus Nationalist Militia
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHD_O {                // ChDKZ (Red Star)
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CHD_B {                // ChDSZ (Blue Star)
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHD_I {                // ChDZZ (Green Star)
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack) };
    };
    class UK3CB_CHD_W_O {              // ChDKZ Winter (Red Star)
        PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CHD_W_B {              // ChDSZ Winter (Blue Star)
        PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_CHD_W_I {              // ChDZZ Winter (Green Star)
        PVAR(packs)[] = { QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack) };
    };

    // ------------------------------------------------------------------------ CSAT (mirrors the vanilla CSAT presets)
    class UK3CB_CSAT_A_O {             // CSAT - Africa
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(sportsman,cigpack) };
    };
    class UK3CB_CSAT_B_O {             // CSAT - Middle East
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CSAT_F_O {             // CSAT - Navy
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CSAT_G_O {             // CSAT - Pacific
        PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack) };
    };
    class UK3CB_CSAT_M_O {             // CSAT - Mediterranean
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CSAT_N_O {             // CSAT - Navy (Pacific)
        PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack) };
    };
    class UK3CB_CSAT_S_O {             // CSAT - Winter
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CSAT_U_O {             // CSAT - Urban
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class UK3CB_CSAT_W_O {             // CSAT - Europe
        PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // ------------------------------------------------------------------------ ION Services (all four camo variants, every side)
    class UK3CB_ION_O_Urban {          // ION Services - Urban
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_B_Urban {          // ION Services - Urban
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_I_Urban {          // ION Services - Urban
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_O_Desert {         // ION Services - Desert
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_B_Desert {         // ION Services - Desert
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_I_Desert {         // ION Services - Desert
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_O_Winter {         // ION Services - Winter
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_B_Winter {         // ION Services - Winter
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_I_Winter {         // ION Services - Winter
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_O_Woodland {       // ION Services - Woodland
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_B_Woodland {       // ION Services - Woodland
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class UK3CB_ION_I_Woodland {       // ION Services - Woodland
        PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
    };

    // ------------------------------------------------------------------------ Cold War (no WW2-era looks; Apollo Soyuz only from 1975, so only for the late Soviets)
    class UK3CB_CW_SOV_O_EARLY {       // Cold War USSR - Early
        PVAR(packs)[] = { QEGVAR(kosmos,cigpack), QEGVAR(belomorkanal,cigpack) };
    };
    class UK3CB_CW_SOV_O_LATE {        // Cold War USSR - Late
        PVAR(packs)[] = { QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(belomorkanal,cigpack) };
    };
    class UK3CB_CW_US_B_EARLY {        // Cold War US - Early
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };
    class UK3CB_CW_US_B_LATE {         // Cold War US - Late
        PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };
};
