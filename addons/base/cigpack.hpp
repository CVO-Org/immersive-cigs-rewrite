// Weaponholder - The "empty vehicle" to be placed in the world.
class CfgVehicles {
    class WeaponHolder_Single_limited_item_F;

    class GVAR(cigpackItem): WeaponHolder_Single_limited_item_F {
        scope = 1;
        scopeCurator = 1;
        displayName = CSTRING(cigpack);
        author = CSTRING(author);
        vehicleClass = "Magazines";

        editorCategory = QPVAR(category_main);
        editorSubcategory = QPVAR(subcategory_cigpacks);

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
    class CA_Magazine;

    class GVAR(cigpack): CA_Magazine {
        author = CSTRING(author);
        scope = 1;

        displayName = CSTRING(cigpack);
        descriptionShort = CSTRING(cigpack_desc);
        model = QPATH_MODEL_CIGPACK;
        picture = QPATHTOF(data\ui\gear_cigpack_x_ca.paa);

        ammo = "";
        count = 20;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 2;

        ACE_asItem = 1;

        PVAR(isPack) = 1;
        PVAR(unpackSound)[] = {QPVAR(unwrap_01),QPVAR(unwrap_02),QPVAR(unwrap_03)};
        PVAR(item_glasses) = QGVAR(cig0);
        PVAR(item_hmd) = QGVAR(cig0_nv);
    };
};
