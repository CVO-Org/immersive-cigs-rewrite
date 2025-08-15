// Weaponholder - The "empty vehicle" to be placed in the world.
class CfgVehicles
{
    class EGVAR(base,cigpackItem);
    class GVAR(crayonpackItem): EGVAR(base,cigpackItem) {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(crayonpack);
        author = CSTRING(author);

        class TransportMagazines {
            class GVAR(crayonpack) {
                magazine = QGVAR(crayonpack);
                count = 1;
            };
        };
    };
};

class CfgMagazines {
    // Modded Item
    class EGVAR(base,cigpack);
    class GVAR(crayonpack): EGVAR(base,cigpack) {
        author = CSTRING(author);
        scope = 2;

        displayName = CSTRING(crayonpack);
        descriptionShort = CSTRING(crayonpack_desc);
        model = QPATHTOF(data\crayonpack\crayonpack.p3d);
        picture = QPATHTOF(data\ui\gear_crayonpack_ca.paa);

        count = 24;

        PVAR(item_glasses)[] = {QGVAR(crayon_black), QGVAR(crayon_blue), QGVAR(crayon_brown), QGVAR(crayon_gray), QGVAR(crayon_green), QGVAR(crayon_), QGVAR(crayon_orange), QGVAR(crayon_pink), QGVAR(crayon_purple), QGVAR(crayon_red), QGVAR(crayon_white), QGVAR(crayon_yellow)};
        PVAR(item_hmd)[] = {QGVAR(crayon_black_nv), QGVAR(crayon_blue_nv), QGVAR(crayon_brown_nv), QGVAR(crayon_gray_nv), QGVAR(crayon_green_nv), QGVAR(crayon__nv), QGVAR(crayon_orange_nv), QGVAR(crayon_pink_nv), QGVAR(crayon_purple_nv), QGVAR(crayon_red_nv), QGVAR(crayon_white_nv), QGVAR(crayon_yellow_nv)};
    };
};
