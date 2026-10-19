// Default packages per side, as presets.
// Used when neither the API nor the aiCigs module define the packages (cigs_aiCigs_default, see fn_preInit)
// and as the default selection of a newly placed aiCigs module (see CfgVehicles).
//
// Resolved once by cigs_ai_fnc_getDefaultPacks:
// - A preset is active when all its requiredAddons[] (CfgPatches) are loaded and its condition returns true.
// - Per side, the active preset with the highest priority that defines the side is used.
//   A preset only needs to define the sides it changes, the others fall through to lower priorities.
//
// Other addons can add their own presets:
// class cigs_ai_defaultPacks {
//     class MyPreset {
//         priority = 10;                           // Higher wins. Vanilla is 0.
//         requiredAddons[] = { "my_addon" };       // Optional - all need to be loaded
//         condition = "true";                      // Optional - SQF, needs to return a BOOL
//         WEST[] = { "cigs_morley_cigpack" };      // Optional per side: WEST, EAST, GUER, CIV
//     };
// };
class GVAR(defaultPacks) {
    class Vanilla {
        priority = 0;
        WEST[] = { QEGVAR(morley,cigpack), QEGVAR(crayons,crayonpack) };
        EAST[] = { QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
        GUER[] = { QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
        CIV[]  = { QEGVAR(morley,cigpack), QEGVAR(pops,poppack), QEGVAR(nil,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(crayons,crayonpack) };
    };

    class SOGPF {
        priority = 10;
        requiredAddons[] = { "weapons_f_vietnam_c" };
        WEST[] = { QEGVAR(savage,cigpack) };
        EAST[] = { QEGVAR(savage,cigpack) };
        GUER[] = { QEGVAR(savage,cigpack) };
        CIV[]  = { QEGVAR(savage,cigpack) };
    };
};
