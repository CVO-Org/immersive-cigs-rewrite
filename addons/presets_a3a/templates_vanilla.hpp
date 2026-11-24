// Vanilla Antistasi templates (Vanilla_Base, basepath Templates\Templates\Vanilla).
// Parents as in Antistasi's Templates.hpp.
//
// - Occupants and Invaders take the packs of the vanilla faction preset of the same army (presets_vanilla), so an
//   army smokes the same in Antistasi as elsewhere. Children inherit their parent's entry unless they have their own.
// - Special forces (tier sf) take the faction preset of the units they are dressed as: CTRG for NATO, Viper for
//   CSAT Apex, Spetsnaz for CSAT Enoch.
// - Police have no entry: they get the terrain preset of the map (see fn_getConfigPresets).
// - Rebels (FIA, SDK, LFF) and civilians have no entry either. Antistasi plays them on any map, so they get the
//   terrain preset, like local people would.

class Vanilla_Base;

// ---------------------------------------------------------------------------- NATO (Occupants)
// Arid, and Temperate through inheritance: NATO. Special forces wear CTRG.
class Vanilla_NATO_Arid : Vanilla_Base {
    PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(newport,cigpack), QEGVAR(camel,cigpack), QEGVAR(crayons,crayonpack) };
    PVAR(packs_sf)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
};
// Tropical, Apex: NATO (Pacific)
class Vanilla_NATO_Tropical : Vanilla_NATO_Arid {
    PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(matelot,cigpack), QEGVAR(crayons,crayonpack) };
};
class Vanilla_NATO_Apex : Vanilla_NATO_Arid {
    PVAR(packs)[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(matelot,cigpack), QEGVAR(crayons,crayonpack) };
};
// NATO/UK Tropical, and Temperate and Arid through inheritance: British, the CTRG list
class Vanilla_NATO_UK_Tropical : Vanilla_NATO_Apex {
    PVAR(packs)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
};

// ---------------------------------------------------------------------------- CSAT (Invaders)
// Arid, and Temperate through inheritance: CSAT
class Vanilla_CSAT_Arid : Vanilla_Base {
    PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
};
// Apex: CSAT (Pacific). Special forces wear Viper.
class Vanilla_CSAT_Apex : Vanilla_CSAT_Arid {
    PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack) };
    PVAR(packs_sf)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(nil,cigpack) };
};
// Enoch: CSAT on Livonia. Special forces wear the Spetsnaz gorka.
class Vanilla_CSAT_Enoch : Vanilla_CSAT_Arid {
    PVAR(packs_sf)[] = { QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(parliament,cigpack), QEGVAR(voron,cigpack) };
};

// ---------------------------------------------------------------------------- Regional armies (Occupants)
// AAF - Altis
class Vanilla_AAF : Vanilla_Base {
    PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
};
// LDF - Livonia
class Vanilla_LDF : Vanilla_Base {
    PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
};

// ---------------------------------------------------------------------------- ION (Invaders)
// Private military company, international: the 3CB ION Services list
class Vanilla_ION : Vanilla_Base {
    PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack) };
};
