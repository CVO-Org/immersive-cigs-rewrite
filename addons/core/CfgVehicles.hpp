class CfgVehicles {

    #include "CfgVehiclesAceActions.hpp"

    class WeaponHolder_Single_limited_item_F;

    class PVAR(matchesItem): WeaponHolder_Single_limited_item_F {
        scope = 2;
        scopeCurator = 2;
        displayName = CSTRING(matches);
        author = CSTRING(author);
        vehicleClass = "Magazines";

        editorCategory = QPVAR(category_main);
        editorSubcategory = QPVAR(subcategory_lighters);

        class TransportMagazines {
            class PVAR(matches) {
                magazine = QPVAR(matches);
                count = 1;
            };
        };
    };

    class PVAR(lighterItem): PVAR(matchesItem) {
        displayName = CSTRING(lighter);
        author = CSTRING(author);

        class TransportMagazines {
            class PVAR(lighter) {
                magazine = QPVAR(lighter);
                count = 1;
            };
        };
    };

    class PVAR(matches_huntingItem): PVAR(matchesItem) {
        displayName = CSTRING(matches_hunting);

        class TransportMagazines {
            class PVAR(matches_hunting) {
                magazine = QPVAR(matches_hunting);
                count = 1;
            };
        };
    };

    class PVAR(lighter_cheapItem): PVAR(matchesItem) {
        displayName = CSTRING(lighter_cheap);

        class TransportMagazines {
            class PVAR(lighter_cheap) {
                magazine = QPVAR(lighter_cheap);
                count = 1;
            };
        };
    };

    class PVAR(lighter_cricketItem): PVAR(matchesItem) {
        displayName = CSTRING(lighter_cricket);

        class TransportMagazines {
            class PVAR(lighter_cricket) {
                magazine = QPVAR(lighter_cricket);
                count = 1;
            };
        };
    };
};
