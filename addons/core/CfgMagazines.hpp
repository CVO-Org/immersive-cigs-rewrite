class CfgMagazines {
    class CA_Magazine;

    class PVAR(matches): CA_Magazine {
        author = CSTRING(author);
        scope = 2;

        displayName = CSTRING(matches);
        descriptionShort = CSTRING(matches_desc);
        model = QPATHTOF(data\matches\matches.p3d);
        picture = QPATHTOF(data\ui\gear_matches_x_ca.paa);

        ammo = "";
        count = 10;
        initSpeed = 0;
        tracersEvery = 0;
        lastRoundsTracer = 0;
        mass = 1;

        ACE_asItem = 1;

        PVAR(isLighter) = 1;
        PVAR(LighterSound)[] = {QPVAR(matches_01),QPVAR(matches_02),QPVAR(matches_03)};     // CfgSounds Class
    };

    // Apricot_ale
    class PVAR(matches_hunting): PVAR(matches) {

        displayName = CSTRING(matches_hunting);
        descriptionShort = CSTRING(matches_hunting_desc);
        picture = QPATHTOF(data\ui\gear_matches_hunting_x_ca.paa);

        count = 6;
        mass = 0.25;

        PVAR(LighterSound)[] = {QPVAR(matches_01)};     // CfgSounds Class
    };

    class PVAR(lighter): PVAR(matches) {

        displayName = CSTRING(lighter);
        descriptionShort = CSTRING(lighter_desc);
        model = QPATHTOF(data\lighter\lighter.p3d);
        picture = QPATHTOF(data\ui\gear_lighter_x_ca.paa);

        count = 100;
        initSpeed = 0;
        mass = 2;

        ACE_asItem = 1;

        PVAR(isLighter) = 1;
        PVAR(LighterSound)[] = {QPVAR(lighter_01),QPVAR(lighter_02),QPVAR(lighter_03)};     // CfgSounds Class
    };

    // Apricot_ale
    class PVAR(lighter_cheap): PVAR(lighter) {

        displayName = CSTRING(lighter_cheap);
        descriptionShort = CSTRING(lighter_cheap_desc);
        picture = QPATHTOF(data\ui\gear_lighter_cheap_x_ca.paa);

        count = 15;
        mass = 0.5;

        PVAR(LighterSound)[] = {QPVAR(lighter_04)};     // CfgSounds Class
    };

    // Apricot_ale
    class PVAR(lighter_cricket): PVAR(lighter) {

        displayName = CSTRING(lighter_cricket);
        descriptionShort = CSTRING(lighter_cricket_desc);
        picture = QPATHTOF(data\ui\gear_lighter_cricket_x_ca.paa);

        count = 25;
        mass = 0.5;

        PVAR(LighterSound)[] = {QPVAR(lighter_02)};     // CfgSounds Class
    };
};
