#define CVO_SOUNDS sounds[] = { Q(cvo_raven_caw), "ace_tagging_spray","ace_tagging_spray01","ace_tagging_spray02" }



class CfgWeapons {

    class CBA_MiscItem_ItemInfo;

    class ACE_SpraypaintBlack;
    class ACE_SpraypaintWhite;
    class ACE_SpraypaintRed;

    class CVO_SpraypaintBlack: ACE_SpraypaintBlack {
        author = "Zorn";
        displayName = "CVO Spraycan";
        descriptionShort = "A can of spray paint for tagging walls with glorious propaganda.";
        scope = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
        CVO_SOUNDS;
    };
    class CVO_SpraypaintWhite: ACE_SpraypaintWhite {
        author = "Zorn";
        displayName = "CVO Spraycan";
        descriptionShort = "A can of spray paint for tagging walls with glorious propaganda.";
        scope = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
        CVO_SOUNDS;
    };
    class CVO_SpraypaintRed: ACE_SpraypaintRed {
        author = "Zorn";
        displayName = "CVO Spraycan";
        descriptionShort = "A can of spray paint for tagging walls with glorious propaganda.";
        scope = 1;
        class ItemInfo: CBA_MiscItem_ItemInfo {
            mass = 1;
        };
        CVO_SOUNDS;
    };
};
