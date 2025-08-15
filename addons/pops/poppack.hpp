// Weaponholder - The "empty vehicle" to be placed in the world.
class CfgVehicles
{
    class EGVAR(base,cigpackItem);

    class GVAR(poppackItem): EGVAR(base,cigpackItem) {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(poppack);
        author = CSTRING(author);

        class TransportMagazines {
            class GVAR(poppack) {
                magazine = QGVAR(poppack);
                count = 1;
            };
        };
    };
};

class CfgMagazines {
    // Modded Item
    class EGVAR(base,cigpack);
    class GVAR(poppack): EGVAR(base,cigpack) {
        author = CSTRING(author);
        scope = 2;

        displayName = CSTRING(poppack);
        descriptionShort = CSTRING(poppack_desc);
        model = QPATHTOF(data\poppack\poppack.p3d);
        picture = QPATHTOF(data\ui\gear_poppack_x_ca.paa);

        count = 1;

        PVAR(item_glasses) = QGVAR(pop0);
        PVAR(item_hmd) = QGVAR(pop0_nv);
    };
};
