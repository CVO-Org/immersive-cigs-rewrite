// RHS Antistasi templates (RHS_Base, RHS_SAF_Base, basepath Templates\Templates\RHS).
// Parents as in Antistasi's Templates.hpp. The templates are part of Antistasi itself, so no RHS dependency is needed.
//
// - Occupants and Invaders take the packs of the RHS faction preset of the same army (presets_rhs_*).
//   Children inherit their parent's entry, so one entry covers the climate variants.
// - Russia uses the tiers: militia wear the old afghanka and smoke the cheap Soviet-era brands, special forces
//   (6Sh122 kit) the premium Parliament first. The CDF militia get the cheap domestic Chernarus brands.
// - Belomorkanal is a planned brand (#358): dropped until it is in the mod.
// - Police have no entry: they get the terrain preset of the map (see fn_getPresets).
// - Rebels (NAPA, SDK) and civilians have no entry either: Antistasi plays them on any map, so they get the terrain preset.

class RHS_Base;
class RHS_SAF_Base;

#define RHS_RUSSIA_PACKS        { QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack) }
#define RHS_RUSSIA_PACKS_MILITIA { QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack) }
#define RHS_RUSSIA_PACKS_SF     { QEGVAR(parliament,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack) }

// ---------------------------------------------------------------------------- Russia (Invaders)
// AFRF Arid, and Temperate through inheritance: Russia - MSV
class RHS_AFRF_Arid : RHS_Base {
    PVAR(packs)[] = RHS_RUSSIA_PACKS;
    PVAR(packs_militia)[] = RHS_RUSSIA_PACKS_MILITIA;
    PVAR(packs_sf)[] = RHS_RUSSIA_PACKS_SF;
};
// VDV Temperate, and Arid through inheritance: the same, VDV inherits MSV in RHS too
class RHS_VDV_Temperate : RHS_Base {
    PVAR(packs)[] = RHS_RUSSIA_PACKS;
    PVAR(packs_militia)[] = RHS_RUSSIA_PACKS_MILITIA;
    PVAR(packs_sf)[] = RHS_RUSSIA_PACKS_SF;
};

// ---------------------------------------------------------------------------- Chernarus
// ChDKZ (Invaders): Chernarus communists with Russian backing
class RHS_CHDKZ : RHS_Base {
    PVAR(packs)[] = { QEGVAR(gudok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(kosmos,cigpack) };
};
// CDF (Occupants). Militia without the premium domestic Zamok.
class RHS_CDF : RHS_Base {
    PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(gudok,cigpack), QEGVAR(marlboro,cigpack) };
    PVAR(packs_militia)[] = { QEGVAR(gudok,cigpack), QEGVAR(sosna,cigpack) };
};

// ---------------------------------------------------------------------------- United States (Occupants)
// US Army Arid, and through inheritance US Army Temperate, USMC Arid and USMC Temperate
class RHS_USAF_Army_Arid : RHS_Base {
    PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(newport,cigpack), QEGVAR(morley,cigpack) };
};

// ---------------------------------------------------------------------------- Serbia (Invaders)
class RHS_SAF : RHS_SAF_Base {
    PVAR(packs)[] = { QEGVAR(drina,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
};

// ---------------------------------------------------------------------------- Horizon Islands / Tanoa
// HIDF (Occupants)
class RHS_HIDF : RHS_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
};
// TLA (Invaders): guerrilla army, so the gag brands like Syndikat
class RHS_TLA : RHS_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
};

#undef RHS_RUSSIA_PACKS
#undef RHS_RUSSIA_PACKS_MILITIA
#undef RHS_RUSSIA_PACKS_SF
