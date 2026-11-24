// Faction presets for 3CB BAF: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - 3CB BAF puts its units in one faction per service and camo, UK3CB_BAF_Faction_<Army/Navy/Airforce>_<camo>.
//   UK3CB_BAF_Faction has no units, so it gets no entry.
// - All services and camos get the same packs.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

#define BAF_PACKS PVAR(packs)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) }

#define BAF_FACTIONS(CAMO) \
    class UK3CB_BAF_Faction_Army_##CAMO { BAF_PACKS; }; \
    class UK3CB_BAF_Faction_Navy_##CAMO { BAF_PACKS; }; \
    class UK3CB_BAF_Faction_Airforce_##CAMO { BAF_PACKS; }

class CfgFactionClasses {
    BAF_FACTIONS(MTP);
    BAF_FACTIONS(Desert);
    BAF_FACTIONS(Temperate);
    BAF_FACTIONS(Woodland);
    BAF_FACTIONS(Tropical);
    BAF_FACTIONS(Arctic);
};
