class CfgVehicles
{
    class EGVAR(pops,poppackItem);
    class immersion_pops_poppackItem: EGVAR(pops,poppackItem)
    {
        scope = _DEBUG_SCOPE_;
        scopeCurator = 1;
        displayName = "DEPRECATED";
    };

    class EGVAR(morley,cigpackItem);
    class murshun_cigs_cigpackItem : EGVAR(morley,cigpackItem) 
    {
        scope = _DEBUG_SCOPE_;
        scopeCurator = 1;
        displayName = "DEPRECATED";
    };

    class PVAR(lighterItem);
    class murshun_cigs_lighterItem : PVAR(lighterItem)
    {
        scope = _DEBUG_SCOPE_;
        scopeCurator = 1;
        displayName = "DEPRECATED";
    };

    class PVAR(matchesItem);
    class murshun_cigs_matchesItem : PVAR(matchesItem)
    {
        scope = _DEBUG_SCOPE_;
        scopeCurator = 1;
        displayName = "DEPRECATED";
    };
};
