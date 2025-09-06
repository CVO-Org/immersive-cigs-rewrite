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

            class handleSettingChange {};

            class addToQueue {};
            class processQueue {};

            class addCigItemsToUnit {};
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
        };
    };
};
