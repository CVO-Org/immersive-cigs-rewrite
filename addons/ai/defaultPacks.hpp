// Default packages per side.
// Used when neither the aiCigs module, the CBA settings nor the API define the packages (cigs_aiCigs_default, see fn_preInit)
// and as the default selection of a newly placed aiCigs module (see CfgVehicles).
class GVAR(defaultPacks) {
    WEST[] = { QEGVAR(morley,cigpack), QEGVAR(crayons,crayonpack) };
    EAST[] = { QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack) };
    GUER[] = { QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    CIV[]  = { QEGVAR(morley,cigpack), QEGVAR(pops,poppack), QEGVAR(nil,cigpack), QEGVAR(apollo,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack), QEGVAR(crayons,crayonpack) };
};
