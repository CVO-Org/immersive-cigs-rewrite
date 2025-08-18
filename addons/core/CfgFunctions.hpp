class CfgFunctions
{
    class ADDON
    {
        // tag = "cigs"; // the function will be named TAG_fnc_myOtherFunction
        class COMPONENT
        {
            file = PATH_TO_FUNC;

            class postInit { postInit = 1; };
            class cba_contextMenu { preInit = 1; };
            class arsenalTab {};

            class incompatibility { postInit = 1; };
        };

        class common {
            file = PATH_TO_FUNC_SUB(common);
            
            class add_slotItemChanged_EH {};
            class putWeaponAway {};

            class removeItemFromMag {};
        };

        class smoking
        {
            file = PATH_TO_FUNC_SUB(smoking);

            class canStartSmoking {};
            class canStopSmoking {};

            class start_cig_their {};
            class start_cig {};
            class stop_cig {};
            class drop_cig {};
            
            class smoking_start {};
            class smoking {};
            class smoking_stop {};
        };

        class sucking
        {
            file = PATH_TO_FUNC_SUB(sucking);

            class canStartSucking {};
            class canStopSucking {};

            class start_suck {};

            class sucking_start {};
            class sucking {};
            class sucking_stop {};

        };

        class effects
        {
            file = PATH_TO_FUNC_SUB(effects);
            class anim {};
            class smoke_effect {};

            class light_lighter {};
            class light_cig_glow {};
        };

        class pack
        {
            file = PATH_TO_FUNC_SUB(pack);

            class canTakeFromPack {};
            class takeFromPack {};


            class action_pack_children {};
        };

        class lighter
        {
            file = PATH_TO_FUNC_SUB(lighter);

            class hasLighter {};
            class getLighter {};
            class useLighter {};
        };

        class singleplayer
        {
            file = PATH_TO_FUNC_SUB(singleplayer);
            class addItemsInSP { postInit = 1; };
        };
        class config
        {
            file = PATH_TO_FUNC_SUB(config);
            class getAllItems {};
            class getCached {};
        };
        class eat_cig
        {
            file = PATH_TO_FUNC_SUB(eat_cig);
            class addEatAction { preInit = 1; };
            class canEat {};
        };
        class combustion {
            file = PATH_TO_FUNC_SUB(combustion);

            class combustion_init { postInit = 1; };
            class combustion_check {};
            class combustion_do {};
        };
        class adv_fatigue {
            file = PATH_TO_FUNC_SUB(adv_fatigue);

            class adv_fatigue_addPuffs {};
            class adv_fatigue_enable {};
            class adv_fatigue_dutyFactor {};

            class cough {};
            class cough_server {};
            class cough_aleart {};
        };
        class respect {
            file = PATH_TO_FUNC_SUB(respect);
            
            class payRespect {};
            class canPayRespect {};
        };
        
    };
};
