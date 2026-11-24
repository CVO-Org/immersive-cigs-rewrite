// Registers the Antistasi template presets with AI Cigs, see cigs_ai_fnc_getCompats.
// Active in Antistasi missions only (cigs_compat_a3a_active, set by fn_init).
class EGVAR(ai,compats) {
    class ADDON {
        priority = 0;
        condition = QUOTE(!isNil QQGVAR(active));
        function = QFUNC(getPresets);
    };
};
