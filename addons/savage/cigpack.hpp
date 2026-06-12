// Weaponholder - The "empty vehicle" to be placed in the world.
class CfgVehicles
{
    class EGVAR(base,cigpackItem);

    class GVAR(cigpackItem): EGVAR(base,cigpackItem) {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(cigpack);
        author = CSTRING(author);

        class TransportMagazines {
            class GVAR(cigpack) {
                magazine = QGVAR(cigpack);
                count = 1;
            };
        };
    };
};

class CfgMagazines {
    // Modded Item
    class EGVAR(base,cigpack);
    class GVAR(cigpack): EGVAR(base,cigpack) {
        author = CSTRING(author);
        scope = 2;

        displayName = CSTRING(cigpack);
        descriptionShort = CSTRING(cigpack_desc);
        model = "vn\characters_f_vietnam\BLUFOR\headgear\items\vn_b_item_cigs_01.p3d";
        picture = "\vn\weapons_f_vietnam\ui\icon_vn_b_item_cigs_01_ca.paa";

        count = 16;

        PVAR(item_glasses) = QGVAR(cig0);
        PVAR(item_hmd) = QGVAR(cig0_nv);
    };

    // Convert SOG CigPack
    class vn_prop_base;
    class vn_b_item_cigs_01: vn_prop_base {

        displayName = CSTRING(cigpack);
        descriptionShort = CSTRING(cigpack_desc);

        count = 16;

        PVAR(isPack) = 1;
        PVAR(unpackSound) = QPVAR(unwrap_01);
        PVAR(item_glasses) = QGVAR(cig0);
        PVAR(item_hmd) = QGVAR(cig0_nv);

        ACE_asItem = 1;
    };

    // Convert SOG Lighter
    class vn_b_item_lighter_01: vn_prop_base {
        count = 100;

        PVAR(isLighter) = 1;
        PVAR(LighterSound)[] = {QPVAR(lighter_01),QPVAR(lighter_02)};     // CfgSounds Class

        ACE_asItem = 1;
    };
};
