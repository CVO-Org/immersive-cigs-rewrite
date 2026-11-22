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
// A terrain lists what a local shop would sell: the regional brand first, then other brands of the region and era,
// then the international brands that fit the era. Units pick 1-3 of them at random.
// No gag brands (Crayons, Baja Blast, Black Devil) and no Voron, as these reach civilians and soldiers alike.
// The WW2-era looks (Craven "A", Eckstein, Juno, Lucky Strike, Troupes) are kept for the 1940s terrains, see docs/classnames.md.
class PVAR(terrainPacks) {

    // ------------------------------------------------------------------------ Vanilla terrains
    // Every vanilla military and guerrilla faction has a faction preset (presets_vanilla), so these reach the civilians
    // and mod factions without a preset. VR has no entry.

    // Altis, Stratis - Mediterranean, 2035
    class Altis {
        packs[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class Stratis {
        packs[] = { QEGVAR(almyra,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // Malden - French, 2035
    class Malden {
        packs[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // Tanoa - South Pacific, French past, 2035
    class Tanoa {
        packs[] = { QEGVAR(matelot,cigpack), QEGVAR(morley,cigpack), QEGVAR(shanhai,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // Livonia - Eastern Europe, 2035
    class Enoch {
        packs[] = { QEGVAR(lipa,cigpack), QEGVAR(lipa_dzwonek,cigpack), QEGVAR(popularne,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ CDLC terrains
    // Plain entries, no dependency: they only apply while the terrain is loaded.
    // The CDLC factions have their own faction presets (presets_<cdlc>), so these reach the other factions on the terrain.

    // Global Mobilization - Weferlingen, on the inner German border, 1970s-80s
    class gm_weferlingen_summer {
        packs[] = { QEGVAR(f6,cigpack), QEGVAR(ernte_23,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack) };
    };
    class gm_weferlingen_winter {
        packs[] = { QEGVAR(f6,cigpack), QEGVAR(ernte_23,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack) };
    };

    // S.O.G. Prairie Fire - Vietnam, 1960s-70s
    class Cam_Lao_Nam {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class vn_khe_sanh {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class vn_the_bra {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // CSLA Iron Curtain - Stozec, Czechoslovakia, 1980s
    class Stozec {
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(kosmos,cigpack), QEGVAR(apollo,cigpack), QEGVAR(popularne,cigpack), QEGVAR(f6,cigpack) };
    };

    // Western Sahara - Sefrou-Ramal, North Africa
    class SefrouRamal {
        packs[] = { QEGVAR(casa_sport,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };

    // Spearhead 1944 - occupied France
    class SPE_Normandy {
        packs[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack), QEGVAR(camel,cigpack) };
    };
    class SPE_Mortain {
        packs[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack), QEGVAR(camel,cigpack) };
    };

    // ------------------------------------------------------------------------ Mod terrains
    // Plain entries, no dependency: they only apply while the terrain is loaded. All of these are modern settings,
    // so the Cold War Eastern Bloc filler (Kosmos) and the WW2 looks stay out.
    // Terrains without a brand of their own region get the international filler (Morley, Marlboro, Camel, NIL).

    // CUP Terrains - Maps: Chernarus, Utes - post-Soviet Chernarus
    class chernarus {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class chernarus_summer {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Chernarus_Winter {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class utes {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // CUP Terrains - Maps: Takistan, Zargabad, Takistan Mountains, Desert, Shapur, Proving Grounds - Takistan
    class takistan {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class zargabad {
        packs[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Mountains_ACR {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Desert_E {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Shapur_BAF {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class ProvingGrounds_PMC {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // CUP Terrains - Maps: Sahrani, Southern Sahrani, United Sahrani, Porto, Rahmadi - no Sahrani brand yet
    class sara {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class saralite {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class sara_dbe1 {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class porto {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class intro {                                   // Rahmadi
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // CUP Terrains - Maps: Bystrica, Bukovina - Czech Republic
    class Woodland_ACR {                            // Bystrica
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class Bootcamp_ACR {                            // Bukovina
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // CUP Terrains - Maps 2.0: Chernarus 2020, Zargabad 2025
    class cup_chernarus_A3 {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class cup_Zargabad_a3 {
        packs[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Namalsk - island north of Chernarus
    class namalsk {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Lythium, Kunduz River, Uzbin Valley, North Takistan - Central Asia, Takistan brands
    class lythium {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class kunduz_valley {                           // Kunduz River
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class uzbin {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class NorthTakistan {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Ruha, Virolahti - Finland. Prince stands in as the Nordic brand
    class ruha {
        packs[] = { QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class vt7 {                                     // Virolahti
        packs[] = { QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Kujari - Sahel, West Africa. Casa Sports as the nearest regional brand
    class tem_kujari {
        packs[] = { QEGVAR(casa_sport,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Rosche - northern West Germany
    class WL_Rosche {
        packs[] = { QEGVAR(ernte_23,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack), QEGVAR(morley,cigpack) };
    };

    // Napf - Switzerland. NIL as the alpine neighbour
    class Napf {
        packs[] = { QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };
    class NapfWinter {
        packs[] = { QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };

    // Pulau, Prei Khmaoch Luong - Southeast Asia, no modern brand of the region yet
    class pulau {
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class rhspkl {                                  // Prei Khmaoch Luong
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Lingor, Dingor - South America, no brand of the region yet
    class lingor3 {
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class dingor {
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Mull of Kintyre - Scotland, no British brand yet
    class rof_mok {
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
};
