#define PROPERTIES\
scope = _DEBUG_SCOPE_;\
displayName = "DEPRECATED";\
isDepricated = 1\

class CfgMagazines {
    class PVAR(lighter);
    class murshun_cigs_lighter: PVAR(lighter) { PROPERTIES; };

    class PVAR(matches);
    class murshun_cigs_matches: PVAR(matches) { PROPERTIES; };

    class EGVAR(morley,cigpack);
    class murshun_cigs_cigpack: EGVAR(morley,cigpack) { PROPERTIES; };
};
