// Terrain presets: the packs that are locally available on a terrain (cigs_aiCigs_terrain, see fn_preInit / fn_getTerrainPacks / fn_getCigItems).
// Used for every unit whose unit class and faction have no preset (cigs_packs[] in CfgVehicles / CfgFactionClasses), whatever its side -
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
// Exception: the science fiction terrains may use Baja Blast and Black Devil.
// The WW2-era looks (Craven "A", Eckstein, Juno, Lucky Strike, Troupes) are kept for the 1940s terrains, see docs/classnames.md.
class PVAR(terrainPacks) {

    // ------------------------------------------------------------------------ Vanilla terrains
    // Every vanilla military and guerrilla faction has a faction preset (ai_presets_factions/vanilla), so these reach the civilians
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
    // The CDLC factions have their own faction presets (ai_presets_factions/<cdlc>), so these reach the other factions on the terrain.

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

    // Western Sahara - Sefrou-Ramal, North Africa. Casa Sports, then the Egyptian Cleopatra
    class SefrouRamal {
        packs[] = { QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(camel,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(morley,cigpack) };
    };

    // Spearhead 1944 - occupied France
    class SPE_Normandy {
        packs[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack), QEGVAR(camel,cigpack) };
    };
    class SPE_Mortain {
        packs[] = { QEGVAR(troupes,cigpack), QEGVAR(matelot,cigpack), QEGVAR(eckstein,cigpack), QEGVAR(juno,cigpack), QEGVAR(lucky_strike,cigpack), QEGVAR(craven,cigpack), QEGVAR(camel,cigpack) };
    };

    // ------------------------------------------------------------------------ Mod terrains
    // Plain entries, no dependency: they only apply while the terrain is loaded. Modern settings first, so the
    // Cold War Eastern Bloc filler (Kosmos) and the WW2 looks stay out; the Vietnam War terrains follow at the end.
    // Terrains without a brand of their own region get the international filler (Morley, Marlboro, Camel, NIL).
    // Empty test maps (VEU Expanses) get no entry, like VR.

    // Post-Soviet terrains: the Chernarus brands, then the Russian papirosa Belomorkanal (planned, issue #358: dropped until
    // it is in the mod) and Apollo Soyuz. The modern maps (2020 onwards) add Parliament, the CIS status cigarette.

    // CUP Terrains - Maps: Chernarus, Utes - post-Soviet Chernarus
    class chernarus {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class chernarus_summer {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Chernarus_Winter {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class utes {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
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

    // CUP Terrains - Maps: Sahrani, Southern Sahrani, United Sahrani, Porto, Rahmadi - Spanish, Ducados
    class sara {
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class saralite {
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class sara_dbe1 {
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class porto {
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class intro {                                   // Rahmadi
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // CUP Terrains - Maps: Bystrica, Bukovina - Czech Republic
    class Woodland_ACR {                            // Bystrica
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class Bootcamp_ACR {                            // Bukovina
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // CUP Terrains - Maps 2.0: Chernarus 2020 (modern, so Parliament), Zargabad 2025
    class cup_chernarus_A3 {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class cup_Zargabad_a3 {
        packs[] = { QEGVAR(zargabad,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Namalsk - island north of Chernarus
    class namalsk {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Lythium, Kunduz River, Kunduz, Anizay, Uzbin Valley, North Takistan - Central Asia and Afghanistan, Takistan brands
    class lythium {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class kunduz_valley {                           // Kunduz River
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Kunduz {                                  // Kunduz, a different terrain than Kunduz River
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class tem_anizay {                              // Anizay
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class uzbin {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class NorthTakistan {
        packs[] = { QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Ruha, Virolahti - Finland. Klubi, then the Swedish John Silver
    class ruha {
        packs[] = { QEGVAR(klubi,cigpack), QEGVAR(john_silver,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class vt7 {                                     // Virolahti
        packs[] = { QEGVAR(klubi,cigpack), QEGVAR(john_silver,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Kujari - Sahel, West Africa. Sportsman as the sub-Saharan brand, Casa Sports from North Africa
    class tem_kujari {
        packs[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Isla Duala - fictional island off Central Africa, desert and tropical. Sportsman as the sub-Saharan brand, then the Egyptian Cleopatra
    class isladuala3 {
        packs[] = { QEGVAR(sportsman,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Rosche - northern West Germany
    class WL_Rosche {
        packs[] = { QEGVAR(ernte_23,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack), QEGVAR(morley,cigpack) };
    };

    // Napf - Switzerland. Parisienne, then NIL as the alpine neighbour
    class Napf {
        packs[] = { QEGVAR(parisienne,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };
    class NapfWinter {
        packs[] = { QEGVAR(parisienne,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };

    // Pulau, Tembelan, Prei Khmaoch Luong - Southeast Asia, Gudang Garam
    class Tembelan {                                // Tembelan Island, Indonesia
        packs[] = { QEGVAR(gudang_garam,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class pulau {
        packs[] = { QEGVAR(gudang_garam,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class rhspkl {                                  // Prei Khmaoch Luong
        packs[] = { QEGVAR(gudang_garam,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Lingor, Dingor, Colombia, Regero - South America, Pielroja. Regero is arid with Spanish names, so Ducados after Pielroja
    class regero {
        packs[] = { QEGVAR(pielroja,cigpack), QEGVAR(ducados,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack) };
    };
    class UMB_Colombia {
        packs[] = { QEGVAR(pielroja,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class lingor3 {
        packs[] = { QEGVAR(pielroja,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class dingor {
        packs[] = { QEGVAR(pielroja,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Mull of Kintyre - Scotland, Lambert & Butler
    class rof_mok {
        packs[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Ivanivkova, Korsac, Lesser Swamp, Project Raid, Vereskovo - Ukraine and the Black Sea coast, post-Soviet like Chernarus, modern
    class Ivanivokova {                             // Ivanivkova
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class VTF_Korsac {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class VTF_Korsac_Winter {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class ST_Swamp {                                // Lesser Swamp
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class RaidMap {                                 // Project Raid
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };
    class Vereskovo {
        packs[] = { QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(apollo,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Yulakia, Lybor, Leskovets - fictional Eastern Europe, ex-Soviet and Chernarus brands. Yulakia and Lybor are modern; Leskovets (Bulgaria) gets no Parliament
    class yulakia {
        packs[] = { QEGVAR(apollo,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class VTF_Lybor {
        packs[] = { QEGVAR(apollo,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class VTF_Lybor_Winter {
        packs[] = { QEGVAR(apollo,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(parliament,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };
    class pja314 {                                  // G.O.S Leskovets, Bulgaria
        packs[] = { QEGVAR(apollo,cigpack), QEGVAR(gudok,cigpack), QEGVAR(zamok,cigpack), QEGVAR(sosna,cigpack), QEGVAR(belomorkanal,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // Sumava - Czech Republic
    class brf_sumava {
        packs[] = { QEGVAR(sparta,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Drakovac - Croatia, the Yugoslav Drina
    class drakovac {
        packs[] = { QEGVAR(drina,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Maksniemi, Stubbhult, Archie, Mehland, Tria - Finland, Sweden, Norway. Klubi for Finland, John Silver then the Danish Prince for the rest
    class Maksniemi {
        packs[] = { QEGVAR(klubi,cigpack), QEGVAR(john_silver,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class stubbhult {
        packs[] = { QEGVAR(john_silver,cigpack), QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class archie_w {                                // Archie, Winter
        packs[] = { QEGVAR(john_silver,cigpack), QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class mehland {
        packs[] = { QEGVAR(john_silver,cigpack), QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class jns_tria {                                // Tria
        packs[] = { QEGVAR(john_silver,cigpack), QEGVAR(prince,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // Green Valley (Libya), Niakala (Chad) - North Africa and the Sahel. Libya gets Casa Sports and the Egyptian Cleopatra, Chad Sportsman first, then
    // Casa Sports and Cleopatra from the Arab north
    class green_valley {
        packs[] = { QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class juju_kalahari {                           // Niakala
        packs[] = { QEGVAR(sportsman,cigpack), QEGVAR(casa_sport,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // G.O.S Al Rayak - Middle East, 2035. Alborz as the neighbouring Iranian brand, the Egyptian Cleopatra, then the Takistan brands
    class pja310 {
        packs[] = { QEGVAR(alborz,cigpack), QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Sa'hatra - Iraq and Kuwait, 2003. Cleopatra as the Arab brand, then the Takistan brands
    class juju_sahatra {
        packs[] = { QEGVAR(cleopatra,cigpack), QEGVAR(jaffudi,cigpack), QEGVAR(zargabad,cigpack), QEGVAR(sharig,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack) };
    };

    // Sehreno - a take on Sahrani, Ducados
    class Sehreno {
        packs[] = { QEGVAR(ducados,cigpack), QEGVAR(morley,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(nil,cigpack) };
    };

    // Djalka (South Georgia), Kaska - remote islands. Djalka is British, so Lambert & Butler; Kaska has no brand of the region
    class K9S_Djalka {
        packs[] = { QEGVAR(lambert_butler,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };
    class kaska {
        packs[] = { QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(morley,cigpack), QEGVAR(nil,cigpack) };
    };

    // ------------------------------------------------------------------------ Mod terrains, Vietnam War
    // Same packs as the S.O.G. terrains. Savage drops out without S.O.G. Prairie Fire.

    // Hue 1968, Tien Giang, Fox Hutan, Pamai, Vanam - Vietnam and Cambodia
    class Hue {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class rtbf_tien_giang {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class fox_hutan {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class fox_pamai {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class fox_vanam {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // November-Seven - Laos
    class rtbf_november_seven {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // S.O.G. Nickel Steel - Dong Giang, Rung Sat
    class dong_giang {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class vnx_rssz {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // UNSUNG - Lowlands, Da Krong, Rung Sat, Song Bin Tanh, Ba Long, Dak Pek
    class csj_lowlands {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class DaKrong {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class RungSat {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class song_bin_tanh {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class urx_jnd_balong {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };
    class urx_jnd_dakpek {
        packs[] = { QEGVAR(ruby_queen,cigpack), QEGVAR(savage,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(kosmos,cigpack) };
    };

    // ------------------------------------------------------------------------ Mod terrains, science fiction
    // 26th century and later: the global filler plus the gag brands, which are allowed here as no real era applies.
    // Officers get Papa Schultz at unit class level, not here.

    // Operation TREBUCHET, OPTRE First Contact - Halo worlds
    class OPTRE_Arcadia {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Archipelago {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class Glassed {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Installation04 {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Snowlands {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Wetlands {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class Blood_OPTRE {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_EridanusSecundus {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Gridlock {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Harvest {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_iberius {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Kholo {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Madrigal {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Phobos {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Roost {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class OPTRE_Sandstorm {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };

    // The Kuiper Engagements - Europa, Ganymede
    class TKE_Ext_Europa {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
    class TKE_Ext_Ganymede {
        packs[] = { QEGVAR(morley,cigpack), QEGVAR(nil,cigpack), QEGVAR(marlboro,cigpack), QEGVAR(camel,cigpack), QEGVAR(baja_blast,cigpack), QEGVAR(black_devil,cigpack) };
    };
};
