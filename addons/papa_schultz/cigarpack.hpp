// Weaponholder - The "empty vehicle" to be placed in the world.
class CfgVehicles
{
    class EGVAR(base,cigpackItem);

    class GVAR(cigarbox_5Item): EGVAR(base,cigpackItem) {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(cigarbox_5);
        author = CSTRING(author_cigarbox_5);

        class TransportMagazines {
            class GVAR(cigarbox_5) {
                magazine = QGVAR(cigarbox_5);
                count = 1;
            };
        };
    };
};

// Magazine - The "Item" in a units inventory
class CfgMagazines {
    class EGVAR(base,cigpack);

    class GVAR(cigarbox_5): EGVAR(base,cigpack) {
        author = CSTRING(author_cigarbox_5);
        scope = 2;

        displayName = CSTRING(cigarbox_5);
        descriptionShort = CSTRING(cigarbox_5_desc);

        model = QPATHTOF(data\cigarbox_5\cigarbox_5.p3d);
        picture = QPATHTOF(data\ui\gear_cigarbox_5_x_ca.paa);

        count = 5;

        PVAR(item_glasses) = QGVAR(cigar0);
        PVAR(item_hmd) = QGVAR(cigar0_nv);
    };
};
