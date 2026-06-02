class CfgFunctions
{
    class ADDON
    {
        // tag = "cigs"; // the function will be named TAG_fnc_myOtherFunction
        class COMPONENT {
            file = PATH_TO_FUNC;
            
            class postInit { postInit = 1; };

            class getPPEffectArray {};
        };
        class spiked {
            file = PATH_TO_FUNC_SUB(spiked);
            
            class spikedEffectAdjust {};
            
            class spikedConsumes {};
            class spikedLoop {};
        };
    };
};
