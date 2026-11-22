// Terrain presets: the packs that are locally available on a terrain (cigs_aiCigs_terrain, see fn_preInit / fn_getTerrainPacks / fn_getCigItems).
// Used for every unit whose faction has no faction preset (cigs_packs[] in CfgFactionClasses), whatever its side -
// mainly civilians, as the vanilla civilians (CIV_F) are one faction for every map.
//
// - The class name is the terrain's worldName.
// - packs[] is the same for all sides. A terrain without an entry leaves those units to the default presets (defaultPacks.hpp).
// - Classnames that aren't loaded are dropped, so a terrain can list packs of optional brands.
//
// Other addons (terrain mods, compat addons) can add their own terrains, no dependency needed:
// class cigs_terrainPacks {
//     class MyTerrain {                            // worldName
//         packs[] = { "cigs_morley_cigpack" };
//     };
// };
//
// Vanilla terrains: the regional brand of the terrain first, then brands that fit it.
// Every vanilla military and guerrilla faction has a faction preset (presets_vanilla), so these reach the civilians
// and mod factions without a preset. VR has no entry.
class PVAR(terrainPacks) {
    class Altis {
        packs[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class Stratis {
        packs[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class Malden {
        packs[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack) };
    };
    class Tanoa {
        packs[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class Enoch {           // Livonia
        packs[] = { QEGVAR(lipa,cigpack), QEGVAR(lipa_dzwonek,cigpack), QEGVAR(nil,cigpack) };
    };
};
