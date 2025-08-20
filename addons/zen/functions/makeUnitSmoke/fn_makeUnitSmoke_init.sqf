#include "../../script_component.hpp"

/*
* Author: Zorn
* Function to add makeUnitSmokeNow as a Zeus Interface
*
* Arguments:
*
* Return Value:
* None
*
* Example:
* ['something', player] call prefix_component_fnc_functionname
*
* Public: No
*/

[
    LELSTRING(core,editor_category_main)         // Category
    ,LLSTRING(module_makeUnitSmoke)              // Name
    ,FUNC(makeUnitSmoke_module)                  // Statement     // Module Pos ASL, Attached Object
    ,QPATHTOEF(core,data\UI\light_cig.paa)       // Icon
] call zen_custom_modules_fnc_register;
