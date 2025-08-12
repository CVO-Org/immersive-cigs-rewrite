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

// Magazine - The "Item" in a units inventory
class CfgMagazines {
    class EGVAR(base,cigpack);

    class GVAR(cigpack): EGVAR(base,cigpack) {
        author = CSTRING(author);
        scope = 2;

        displayName = CSTRING(cigpack);
        descriptionShort = CSTRING(cigpack_desc);
        model = QPATH_MODEL_CIGPACK;
        picture = QPATHTOF(data\ui\gear_cigpack_x_ca.paa);

        count = CIGPACK_SIZE;

        PVAR(item_glasses) = QGVAR(cig0);
        PVAR(item_hmd) = QGVAR(cig0_nv);
    };
};
