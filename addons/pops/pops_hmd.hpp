// NVG's are defined within CfgWeapons
// The Facewear Version is defined in CfgGoggles

class CfgWeapons {
    class NVGoggles;

    class GVAR(popBase_nv): NVGoggles {
        scope = 0;
        author = "";

        displayName = "";
        descriptionShort = "";

        model = "";
        picture = "";

        mass = 0.02;

       // NVG Data
        visionMode[] = {"Normal"};
        thermalMode[] = {0};
        modelOptics[] = {};
        opticsPPEffects[] = {};

        PVAR(isSuckable) = 1;
        PVAR(totalSucks) = 1;
        PVAR(curStage) = 0;
        PVAR(endStage) = 0;

        PVAR(flavor)[] = {};
        PVAR(sounds)[] = {QPVAR(eat_01), QPVAR(eat_02), QPVAR(eat_03), QPVAR(eat_04), QPVAR(eat_05), QPVAR(eat_06), QPVAR(eat_07)};

        class ItemInfo {
            type = 616;
            hmdType = 0;
            uniformModel = "";
            modelOff = "";
            mass = 0.02;
        };

        KJW_Imposters_SuspicionAmount = 0.1;
        hoa_sling_slingWithHelmet = 0;
    };

    class GVAR(pop0_nv): GVAR(popBase_nv) {

        scope = 2;
        author = CSTRING(author);

        displayName = CSTRING(pop);
        descriptionShort = ECSTRING(core,hmd_stage0);

        model = QPATHTOF(data\pop\pop.p3d);
        picture = QPATHTOF(data\ui\gear_pop0_x_ca.paa);

        PVAR(totalSucks) = SUCKS_TOTAL;
        PVAR(flavor)[] = {"banana", "cherry", "strawberry", "raspberry", "bacon", "nicotine", "tomato", "chocolate", "lemon", "cola"}; 

        class ItemInfo: ItemInfo {
            uniformModel = QPATHTOF(data\pop\pop.p3d);
            modelOff = QPATHTOF(data\pop\pop.p3d);
        };
    };
};
