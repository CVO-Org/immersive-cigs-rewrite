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

        class makeUnitSmoke {
            file = PATH_TO_FUNC_SUB(makeUnitSmoke);
            
            class makeUnitSmoke_init { preInit = 1; };
            class makeUnitSmoke_module {};
            class makeUnitSmoke_statement {};
        };
        class stopUnitSmoke {
            file = PATH_TO_FUNC_SUB(stopUnitSmoke);
            
            class stopUnitSmoke_init { preInit = 1; };
            class stopUnitSmoke_statement {};
        };
    };
};
