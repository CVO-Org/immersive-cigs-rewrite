// Faction presets for the 3CB BAF Woodland Cold War optional: the same packs as the other 3CB BAF factions (presets_3cb_baf).
// cigs_lighters[] is left out, so the normal lighter pool is used.

#define BAF_PACKS PVAR(packs)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) }

class CfgFactionClasses {
    class UK3CB_BAF_Faction_Army_Woodland_CW { BAF_PACKS; };
    class UK3CB_BAF_Faction_Navy_Woodland_CW { BAF_PACKS; };
    class UK3CB_BAF_Faction_Airforce_Woodland_CW { BAF_PACKS; };
};
