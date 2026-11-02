#define PROPERTIES\
scope = _DEBUG_SCOPE_;\
scopeCurator = 1;\
displayName = "DEPRECATED";\
isDepricated = 1\

class CfgVehicles {
    class EGVAR(pops,poppackItem);
    class immersion_pops_poppackItem: EGVAR(pops,poppackItem) { PROPERTIES; };

    class EGVAR(morley,cigpackItem);
    class murshun_cigs_cigpackItem: EGVAR(morley,cigpackItem) { PROPERTIES; };

    class PVAR(lighterItem);
    class murshun_cigs_lighterItem: PVAR(lighterItem) { PROPERTIES; };

    class PVAR(matchesItem);
    class murshun_cigs_matchesItem: PVAR(matchesItem) { PROPERTIES; };
};

#undef PROPERTIES
