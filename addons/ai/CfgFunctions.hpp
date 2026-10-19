class CfgFunctions {
    class ADDON {
        // tag = "cigs"; // the function will be named TAG_fnc_myOtherFunction
        class common {
            file = PATH_TO_FUNC_SUB(common);
            
            class preInit  { preInit  = 1; };
            class postInit { postInit = 1; };
        };

        class aiCigs {
            file = PATH_TO_FUNC_SUB(aiCigs);

            class cbaSetting_addSetting {};
            class cbaSetting_perSide {};

            class onEntityCreated {};
            class handleSettingChange {};

            class addToQueue {};
            class processQueue {};

            class addCigItemsToUnit {};
            class getCigItems {};
        };

        class dynamicSmoking {
            file = PATH_TO_FUNC_SUB(dynamicSmoking);
            
            class cleanupArray {};
            class cleanupArray_condition {};

            class loop_start {};
            class loop {};
            
            class canConsume {};
            class startConsuming {};

            class updateCanConsumeAgain {};
            class addUnitToFramework {};

            class returnItemToSlot {};
        };

        class modules {
            file = PATH_TO_FUNC_SUB(modules);
            
            class aiCigs_module {};

            class packList_load {};
            class packList_save {};
            class packList_setAll {};
            class packList_parse {};
        };
    };
};
