// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGlasses

class CfgGlasses {
    class EGVAR(pops,popBase);

    class GVAR(crayon_black): EGVAR(pops,popBase) {
        // Vanilla Data
        scope = 1;  // hidden without ACE Arsenal Extended; compat_aceax shows it with AAE
        author = CSTRING(author);
        mass = 0.2;

        displayName = CSTRING(crayon);
        descriptionShort = ECSTRING(core,glasses_stage0);

        model = QPATHTOF(data\crayon\crayon.p3d);
        picture = QPATHTOF(data\ui\gear_crayon_black_ca.paa);

        // Textures
        hiddenSelections[] = {"camo"};
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_black_CO.paa)};

        // Commmon Data
        PVAR(totalSucks) = SUCKS_TOTAL;
        PVAR(flavor) = "existential anguish"; 

        KJW_Imposters_SuspicionAmount = 0.1;
    };

    class GVAR(crayon_blue): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_blue_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_blue_CO.paa)};
        PVAR(flavor) = "blue on blue";
    };

    class GVAR(crayon_brown): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_brown_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_brown_CO.paa)};
        PVAR(flavor) = "flesh";
    };

    class GVAR(crayon_gray): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_gray_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_gray_CO.paa)};
        PVAR(flavor) = "moral ambiguity gray";
    };

    class GVAR(crayon_green): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_green_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_green_CO.paa)};
        PVAR(flavor) = "gan green";
    };

    class GVAR(crayon_orange): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_orange_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_orange_CO.paa)};
        PVAR(flavor) = "agent orange";
    };

    class GVAR(crayon_pink): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_pink_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_pink_CO.paa)};
        PVAR(flavor) = "pink mist";
    };

    class GVAR(crayon_purple): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_purple_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_purple_CO.paa)};
        PVAR(flavor) = "purple heart";
    };

    class GVAR(crayon_red): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_red_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_red_CO.paa)};
        PVAR(flavor) = "danger close";
    };

    class GVAR(crayon_white): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_white_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_white_CO.paa)};
        PVAR(flavor) = "white phosphorus";
    };

    class GVAR(crayon_yellow): GVAR(crayon_black) {
        picture = QPATHTOF(data\ui\gear_crayon_yellow_ca.paa);
        hiddenSelectionsTextures[] = {QPATHTOF(data\crayon\crayon_yellow_CO.paa)};
        PVAR(flavor) = "hazard pay";
    };
};
