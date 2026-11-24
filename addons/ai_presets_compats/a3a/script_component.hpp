#define SUBCOMPONENT a3a
#define SUBCOMPONENT_BEAUTIFIED Antistasi

#include "..\script_component.hpp"

// This subaddon has its own functions and variables: cigs_ai_presets_compats_a3a_fnc_*, cigs_ai_presets_compats_a3a_*
#undef GVAR
#define GVAR(var1) DOUBLES(SUBADDON,var1)
#undef FUNC
#define FUNC(var1) TRIPLES(SUBADDON,fnc,var1)
#undef PATH_TO_FUNC
#define PATH_TO_FUNC QUOTE(\MAINPREFIX\PREFIX\addons\COMPONENT\SUBCOMPONENT\functions)
