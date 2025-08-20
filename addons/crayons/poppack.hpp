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

        PVAR(item_glasses)[] = { CRAYONS };
        PVAR(item_hmd)[] = { CRAYONS_NV };
    };
};
