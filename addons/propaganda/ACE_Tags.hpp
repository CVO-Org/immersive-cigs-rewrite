class ACE_Tags {
    class cvo_stencil_black {
        displayName = "Voron";
        requiredItem = "ACE_SpraypaintBlack";
        textures[] = {QPATHTOF(data\cvo_stencil_black_ca.paa)};
        icon = QPATHTOF(data\cvo_stencil_black_ca.paa);
        condition = "! isNil ""CVO-Tagging""";
    };
    class cvo_stencil_white: cvo_stencil_black {
        requiredItem = "ACE_SpraypaintWhite";
        textures[] = {QPATHTOF(data\cvo_stencil_white_ca.paa)};
        icon = QPATHTOF(data\cvo_stencil_white_ca.paa);
    };
    class cvo_stencil_red: cvo_stencil_black {
        requiredItem = "ACE_SpraypaintRed";
        textures[] = {QPATHTOF(data\cvo_stencil_red_ca.paa)};
        icon = QPATHTOF(data\cvo_stencil_red_ca.paa);
    };
};
