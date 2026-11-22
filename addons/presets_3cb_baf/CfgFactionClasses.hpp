// Faction presets for 3CB BAF: which packs AI of a faction get (see docs/modders.md, "Faction presets").
//
// - One faction for all British Armed Forces units and camos.
// - Lambert & Butler is a planned brand (issue #360): dropped until it is in the mod.
// - Cigars are kept for officers (unit class level), never per faction.
// - cigs_lighters[] is left out everywhere, so the normal lighter pool is used.

class CfgFactionClasses {

    class UK3CB_BAF_Faction {          // British Armed Forces (3CB BAF)
        PVAR(packs)[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };
};
