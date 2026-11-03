class CfgWeapons {

    class EGVAR(base,cigBase_nv);

    class GVAR(cigar0_nv): EGVAR(base,cigBase_nv) {

        scope = 2;
        author = CSTRING(author);
        mass = 0.1;

        displayName = CSTRING(cigar);
        descriptionShort = ECSTRING(core,hmd_stage0);

        model = QPATH_BASE_MODEL_CIGAR0;
        picture = QPATHTOF(data\ui\gear_cigar0_x_ca.paa);

        // Texture paths for the hiddenSelections are defined in an array in the same order as listed in hiddenSelections:
        hiddenSelectionsTextures[] = { QPATH_TEXTURE_CIGAR, QPATH_TEXTURE_CIGAR };
        hiddenSelectionsMaterials[] = { QPATH_BASE_RVMAT_CIGAR, QPATH_BASE_RVMAT_CIGAR_LIT };

        PVAR(totalPuffs) = TOTALPUFFS;
        PVAR(curStage) = 0;

        PVAR(smokeMultiplier) = 1.5;


        class ItemInfo {
            type = 616;
            hmdType = 0;
            uniformModel = QPATH_BASE_MODEL_CIGAR0;
            modelOff = QPATH_BASE_MODEL_CIGAR0;
            mass = 0.1;

            hiddenSelections[]={"Camo","CamoB"};
            hiddenSelectionsTextures[] = { QPATH_TEXTURE_CIGAR, QPATH_TEXTURE_CIGAR };
            hiddenSelectionsMaterials[] = { QPATH_BASE_RVMAT_CIGAR, QPATH_BASE_RVMAT_CIGAR_LIT };
        };
    };

    class GVAR(cigar1_nv): GVAR(cigar0_nv) {
        scope = _DEBUG_SCOPE_;

        descriptionShort = ECSTRING(core,hmd_stage1);

        model = QPATH_BASE_MODEL_CIGAR1;
        picture = QPATHTOF(data\ui\gear_cigar1_x_ca.paa);

        PVAR(curStage) = 1;



        class ItemInfo: ItemInfo {
            uniformModel = QPATH_BASE_MODEL_CIGAR1;
            modelOff = QPATH_BASE_MODEL_CIGAR1;
        };
    };

    class GVAR(cigar2_nv): GVAR(cigar1_nv) {

        descriptionShort = ECSTRING(core,hmd_stage2);

        model = QPATH_BASE_MODEL_CIGAR2;
        picture = QPATHTOF(data\ui\gear_cigar2_x_ca.paa);

        PVAR(curStage) = 2;



        class ItemInfo: ItemInfo {
            uniformModel = QPATH_BASE_MODEL_CIGAR2;
            modelOff = QPATH_BASE_MODEL_CIGAR2;
        };
    };

    class GVAR(cigar3_nv): GVAR(cigar1_nv) {

        descriptionShort = ECSTRING(core,hmd_stage3);

        model = QPATH_BASE_MODEL_CIGAR3;
        picture = QPATHTOF(data\ui\gear_cigar3_x_ca.paa);

        PVAR(curStage) = 3;


        class ItemInfo: ItemInfo {
            uniformModel = QPATH_BASE_MODEL_CIGAR3;
            modelOff = QPATH_BASE_MODEL_CIGAR3;
        };
    };

    class GVAR(cigar4_nv): GVAR(cigar1_nv) {

        descriptionShort = ECSTRING(core,hmd_stage4);

        model = QPATH_BASE_MODEL_CIGAR4;
        picture = QPATHTOF(data\ui\gear_cigar4_x_ca.paa);

        PVAR(curStage) = 4;


        class ItemInfo: ItemInfo {
            uniformModel = QPATH_BASE_MODEL_CIGAR4;
            modelOff = QPATH_BASE_MODEL_CIGAR4;
        };
    };
};
