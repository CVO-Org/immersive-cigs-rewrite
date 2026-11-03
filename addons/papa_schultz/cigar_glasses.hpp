// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGlasses

class CfgGlasses {
    class EGVAR(base,cigBase);

    class GVAR(cigar0): EGVAR(base,cigBase) {
        scope = 2;
        author = CSTRING(author);

        displayName = CSTRING(cigar);
        descriptionShort = ECSTRING(core,glasses_stage0);

        model = QPATH_BASE_MODEL_CIGAR0;  // From Base
        picture = QPATHTOF(data\ui\gear_cigar0_x_ca.paa);

        hiddenSelectionsTextures[] = { QPATH_TEXTURE_CIGAR, QPATH_TEXTURE_CIGAR }; // From Addon
        hiddenSelectionsMaterials[] = { QPATH_BASE_RVMAT_CIGAR, QPATH_BASE_RVMAT_CIGAR_LIT };

        PVAR(totalPuffs) = TOTALPUFFS;
        PVAR(curStage) = 0;

        PVAR(smokeMultiplier) = 1.5;

    };

    class GVAR(cigar1): GVAR(cigar0) {
        scope = _DEBUG_SCOPE_;
        descriptionShort = ECSTRING(core,glasses_stage1);

        model = QPATH_BASE_MODEL_CIGAR1;
        picture = QPATHTOF(data\ui\gear_cigar1_x_ca.paa);

        PVAR(curStage) = 1;

    };

    class GVAR(cigar2): GVAR(cigar1) {

        descriptionShort = ECSTRING(core,glasses_stage2);

        model = QPATH_BASE_MODEL_CIGAR2;
        picture = QPATHTOF(data\ui\gear_cigar2_x_ca.paa);

        PVAR(curStage) = 2;

    };

    class GVAR(cigar3): GVAR(cigar1) {
        descriptionShort = ECSTRING(core,glasses_stage3);

        model = QPATH_BASE_MODEL_CIGAR3;
        picture = QPATHTOF(data\ui\gear_cigar3_x_ca.paa);

        PVAR(curStage) = 3;

    };

    class GVAR(cigar4): GVAR(cigar1) {
        descriptionShort = ECSTRING(core,glasses_stage4);

        model = QPATH_BASE_MODEL_CIGAR4;
        picture = QPATHTOF(data\ui\gear_cigar4_x_ca.paa);

        PVAR(curStage) = 4;

    };
};
