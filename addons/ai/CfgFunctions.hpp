class CfgFunctions
{
    class ADDON
    {
        // tag = "cigs"; // the function will be named TAG_fnc_myOtherFunction
        class common {
            file = PATH_TO_FUNC_SUB(common);
            
            class preInit  { preInit  = 1; };
            class postInit { postInit = 1; };
        };
        


        class cigs_on_ai
        {
            file = PATH_TO_FUNC_SUB(cigs_on_ai);

            class cbaSetting_addSetting {};
            class cbaSetting_perSide {};

            class hashmap {};

            class addToQueue {};
            class apply {};
            class addCigItemsToUnit {};
        };

        class dynamicSmoking {
            file = PATH_TO_FUNC_SUB(dynamicSmoking);
            
            class AI_cleanupArray {};

            class AI_loop_start {};
            class AI_loop {};
            
            class AI_canConsume {};
            class AI_startConsuming {};

            class AI_updateCanConsumeAgain {};
            class AI_addUnitToFramework {};

        };
    };
};
