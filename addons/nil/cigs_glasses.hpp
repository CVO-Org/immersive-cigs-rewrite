// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGlasses

class CfgGlasses {
    class EGVAR(base,cigBase);

    class GVAR(cig0): EGVAR(base,cigBase) {
        scope = 2;
        author = CSTRING(author);

        displayName = CSTRING(cigarette);
        descriptionShort = ECSTRING(core,glasses_stage0);

        model = QPATH_BASE_MODEL_CIG0;  // From Base
        picture = QPATHTOF(data\ui\gear_cig0_x_ca.paa); // From Addon

        hiddenSelectionsTextures[] =  { QPATH_TEXTURE, QPATH_TEXTURE }; // From Addon

        PVAR(totalPuffs) = TOTALPUFFS;
        PVAR(curStage) = 0;
    };

    class GVAR(cig1): GVAR(cig0) {
        scope = _DEBUG_SCOPE_;
        descriptionShort = ECSTRING(core,glasses_stage1);

        model = QPATH_BASE_MODEL_CIG1;
        picture = QPATHTOF(data\ui\gear_cig1_x_ca.paa);

        PVAR(curStage) = 1;
    };

    class GVAR(cig2): GVAR(cig1) {

        descriptionShort = ECSTRING(core,glasses_stage2);

        model = QPATH_BASE_MODEL_CIG2;
        picture = QPATHTOF(data\ui\gear_cig2_x_ca.paa);

        PVAR(curStage) = 2;
    };

    class GVAR(cig3): GVAR(cig1) {
        descriptionShort = ECSTRING(core,glasses_stage3);

        model = QPATH_BASE_MODEL_CIG3;
        picture = QPATHTOF(data\ui\gear_cig3_x_ca.paa);

        PVAR(curStage) = 3;
    };

    class GVAR(cig4): GVAR(cig1) {
        descriptionShort = ECSTRING(core,glasses_stage4);

        model = QPATH_BASE_MODEL_CIG4;
        picture = QPATHTOF(data\ui\gear_cig4_x_ca.paa);

        PVAR(curStage) = 4;
    };
};
