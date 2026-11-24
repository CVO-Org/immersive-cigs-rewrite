// 3CB Antistasi templates: 3CB Factions (3CBF_Base, 3CBF_CSAT_Base) and 3CB BAF (3CBBAF_Base),
// basepath Templates\Templates\3CB. Parents as in Antistasi's Templates.hpp. The templates are part of Antistasi
// itself, so no 3CB dependency is needed.
//
// - Occupants and Invaders take the packs of the faction preset of the same army (presets_3cb, presets_3cb_baf),
//   so an army smokes the same in Antistasi as elsewhere. Children inherit their parent's entry.
// - 3CB HIDF and 3CB Marines are dressed in RHS gear and have no 3CB faction: they take the RHS presets
//   (RHS HIDF, RHS US), like the RHS templates of the same army.
// - Tiers only where the loadouts differ in a meaningful way: LDF militia wear the smocks of the Livonian Nationalist
//   Militia and get its packs; Cold War USSR militia wear the early KLMK and get the early list (no Apollo Soyuz,
//   which is 1975 on).
// - Belomorkanal is a planned brand (#358): dropped until it is in the mod.
// - Police have no entry: they get the terrain preset of the map (see fn_getConfigPresets).
// - Rebels (CCM, ION, TKM, FIA, TFIA, LSM) and civilians have no entry either: Antistasi plays them on any map,
//   so they get the terrain preset.

class 3CBF_Base;
class 3CBBAF_Base;

// ---------------------------------------------------------------------------- CSAT (Invaders)
// The base carries CSAT - Europe / Middle East, so BEAR (Belarus, 3CB_CSAT_BRU) and GRYPHON (Iran, 3CB_CSAT_PER)
// get it through inheritance.
class 3CBF_CSAT_Base : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
};
// VIPER (China): CSAT - Pacific
class 3CB_CSAT_CHI : 3CBF_CSAT_Base {
    PVAR(packs)[] = { QEGVAR(shanhai,cigpack), QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack) };
};
// SCIMITAR (North Africa): CSAT - Africa
class 3CB_CSAT_FRE : 3CBF_CSAT_Base {
    PVAR(packs)[] = { QEGVAR(alborz,cigpack), QEGVAR(apollo,cigpack), QEGVAR(sportsman,cigpack) };
};

// ---------------------------------------------------------------------------- Altis / Malden / Tanoa
// AAF (Occupants), and AAF Brown through inheritance
class 3CBF_AAF : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
};
// MDF (Occupants): Malden Defence Force
class 3CBF_MDF : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
};
// HIDF (Occupants): RHS gear, so the RHS HIDF list
class 3CBF_HIDF : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
};
// Cold War TLA (Invaders): guerrilla army, the RHS TLA list
class 3CBF_TLA : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
};
// Cold War TNM (Invaders): Tanoa Nationalist Militia
class 3CBF_TNM : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(matelot,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(baja_blast,cigpack) };
};
// Cold War PLM (Occupants): People's Liberation Movement. Antistasi's lore makes it a
// Soviet-supplied army, so Kosmos replaces the Camel of the 3CB PLM faction preset.
class 3CBF_PLM : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(kosmos,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(black_devil,cigpack) };
};

// ---------------------------------------------------------------------------- Livonia / Chernarus region
// LDF (Occupants). Militia wear the smocks of the Livonian Nationalist Militia: its list.
class 3CBF_LDF : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(lipa_dzwonek,cigpack), QEGVAR(lipa,cigpack), QEGVAR(voron,cigpack), QEGVAR(nil,cigpack) };
    PVAR(packs_militia)[] = { QEGVAR(lipa,cigpack), QEGVAR(popularne,cigpack), QEGVAR(nil,cigpack) };
};
// GAF (Occupants): Grozovia Armed Forces, not the German army
class 3CB_GAF : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(zamok,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack) };
};

// ---------------------------------------------------------------------------- Takistan / Afghanistan / Central Asia
// TKA East (Invaders), and TKA West and TKA Mix (Occupants) through inheritance: Takistan National Army
class 3CBF_TKA_East : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
};
// ANA (Occupants): Afghan National Army
class 3CBF_ANA : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
};
// KRG (Occupants): Karzeghistan Royal Guard, the royal brand Jaffudi first
class 3CBF_KRG : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack) };
};

// ---------------------------------------------------------------------------- African Desert
// ADA (Invaders): African Desert Army
class 3CBF_ADA : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
};

// ---------------------------------------------------------------------------- United States (Occupants)
// Cold War US
class 3CBF_CW_US : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
};
// Marines Temperate: US Marines in RHS gear (FROG, G3), the RHS US list
class 3CB_Marines_Temperate : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(newport,cigpack), QEGVAR(morley,cigpack) };
};

// ---------------------------------------------------------------------------- Cold War USSR (Invaders)
// Military wear the late M88: the late list. Militia wear the early KLMK: the early list.
class 3CBF_CW_SOV : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(belomorkanal,cigpack) };
    PVAR(packs_militia)[] = { QEGVAR(kosmos,cigpack), QEGVAR(belomorkanal,cigpack) };
};

// ---------------------------------------------------------------------------- ION (Invaders)
// ION Arid, and Temperate and Arctic through inheritance
class 3CBF_ION_Arid : 3CBF_Base {
    PVAR(packs)[] = { QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(newport,cigpack) };
};

// ---------------------------------------------------------------------------- 3CB BAF (Occupants)
// BAF Arid, and Arctic, Temperate and Tropical through inheritance: British Armed Forces
class 3CBBAF_Arid : 3CBBAF_Base {
    PVAR(packs)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
};
