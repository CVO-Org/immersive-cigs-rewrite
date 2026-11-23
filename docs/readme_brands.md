# Brands

[Back to the documentation overview](README.md)

Every brand in the mod, with where it comes from, the era its pack look belongs to, and where it may be used. Check this page before you put a brand into a [faction or terrain preset](modders.md#faction-presets).

The pictures are the inventory icons (`data/UI/gear_*_ca.paa` of each brand), converted to PNG and scaled down.

## Rules for presets

- **Era first.** A preset only uses brands whose pack look fits its era. The WW2 looks (Craven "A", Eckstein, Juno, Lucky Strike, Troupes) stay in the 1940s presets (Spearhead 1944). Post-war Western filler is Marlboro and Camel; Morley, NIL and Matelot are timeless. Two exceptions by choice: the Chernarus brands (Gudok, Zamok, Sosna) are used for Chernarus factions of every era, and Kosmos and Apollo Soyuz also go to modern Russian factions.
- **Regional brand first.** A faction or terrain lists its own region's brand first, then brands of the same region and era, then international brands that fit the era.
- **Gag brands** (Crayons, Mtn Dew Baja Blast, Black Devil Pink) only go to guerrillas, criminals and the NATO crayon joke (vanilla NATO, NATO (Desert), Expeditionary Forces). Never into terrain presets, as those reach everyone.
- **Voron** is the brand of the author's unit. It only goes to Spetsnaz, the LDF and the Looters.
- **Cigars** are for officers, at unit class level. Never per faction or terrain.
- **Only real brands for real eras.** Historical settings use the real brand with its period pack look, not an invented stand-in.

## Cigarettes

| Pack | Name | Classname | Origin | Era | Notes and restrictions | Used in |
| :--: | ---- | --------- | ------ | --- | ---------------------- | ------- |
| ![](img/brands/alborz.png) | Alborz | `cigs_alborz_cigpack` | CSAT (Iran), named after the Alborz mountains | 2035 | Main CSAT brand | CSAT, CSAT (Pacific), Viper, 3CB Middle East factions, CSAT |
| ![](img/brands/almyra.png) | Almyra | `cigs_almyra_cigpack` | Altis | 2035 | Regional brand of Altis and Stratis | AAF, FIA, terrains Altis and Stratis, 3CB AAF, APD, FIA |
| ![](img/brands/apollo.png) | Apollo Soyuz | `cigs_apollo_cigpack` | Soviet Union, made for the 1975 Apollo–Soyuz mission | 1975 onwards | Not before 1975, so not in S.O.G. Prairie Fire. Also used for modern Russian factions | CSAT, Spetsnaz, East Germany, Poland, CSLA, default EAST and CIV, RHS Russia, 3CB CSAT, CW USSR Late |
| ![](img/brands/baja_blast.png) | Mtn Dew Baja Blast | `cigs_baja_blast_cigpack` | Gag brand | any | Tinted smoke. Gag brand: guerrillas and criminals only | Syndikat, Tura, default GUER and CIV, RHS TLA, 3CB TNM |
| ![](img/brands/black_devil.png) | Black Devil Pink | `cigs_black_devil_cigpack` | Netherlands, novelty pink cigarettes | modern | Gag brand: guerrillas and criminals only | Syndikat, FIA, Looters, SFIA, Tura, default GUER and CIV, RHS TLA, 3CB FIA, TNM, ADG, ADM, PLM, WEI |
| ![](img/brands/camel.png) | Camel | `cigs_camel_cigpack` | USA | 1920s onwards | International Western filler, fits every era | Many post-war Western factions and most terrains, RHS US, UN, Serbia, 3CB African factions, PLM, WEI, UN, ION, CW US |
| ![](img/brands/casa_sport.png) | Casa Sports | `cigs_casa_sport_cigpack` | Morocco | modern | Filterless. Regional brand of North Africa | SFIA, Tura, terrain Sefrou-Ramal, 3CB African factions |
| ![](img/brands/craven.png) | Craven "A" | `cigs_craven_cigpack` | United Kingdom | WW2 | WW2 look: 1940s presets only | French Liberation Army, US Army (SPE), terrains Normandy and Mortain |
| ![](img/brands/drina.png) | Drina | `cigs_drina_cigpack` | Yugoslavia, Fabrika Duvana Sarajevo; later Bosnia and Serbia | 1970s–90s look | Regional brand of Serbia and the Yugoslav successor states. The Višegrad bridge over the Drina on the back | RHS Serbia (Army, Air Force, UN) |
| ![](img/brands/eckstein.png) | Eckstein No. 5 | `cigs_eckstein_cigpack` | Germany | WW2 | WW2 look: 1940s presets only | Wehrmacht, Sturmtroopers, La Milice, 40s Civilians, terrains Normandy and Mortain |
| ![](img/brands/ernte_23.png) | Ernte 23 | `cigs_ernte_23_cigpack` | West Germany | 1970s–80s | Regional brand of West Germany | West Germany (GM), terrain Weferlingen |
| ![](img/brands/f6.png) | f6 | `cigs_f6_cigpack` | East Germany (GDR), VEB Kombinat Tabak Dresden | Cold War | Regional brand of East Germany | East Germany, Revolutionaries (GM), terrains Weferlingen and Stožec |
| ![](img/brands/gudok.png) | Gudok | `cigs_gudok_cigpack` | Chernarus | 1980s look, used for every era | Filterless, cheap domestic. The Chernarus brands are used for Chernarus factions of any era | AFMC, RHS Eastern Militia, CDF, NAPA, ChDKZ, 3CB Chernarus factions |
| ![](img/brands/hwarang.png) | Hwarang | `cigs_hwarang_cigpack` | South Korea, army issue | Vietnam War | Filterless | Republic of Korea (S.O.G.) |
| ![](img/brands/jaffudi.png) | Jaffudi | `cigs_jaffudi_cigpack` | Takistan, royal brand | Kingdom era, 1960s–80s | Also stands in for Afghanistan and the Central Asian and Middle Eastern factions | 3CB TKA, TKC, TKP, KRG, MEC |
| ![](img/brands/juno.png) | Juno | `cigs_juno_cigpack` | Germany | WW2 | Round, filterless. WW2 look: 1940s presets only | Wehrmacht, Sturmtroopers, La Milice, terrains Normandy and Mortain |
| ![](img/brands/kosmos.png) | Kosmos | `cigs_kosmos_cigpack` | Soviet Union | Cold War | The Eastern Bloc filler of the 1960s–80s. Also used for modern Russian factions | CSAT, Spetsnaz, GM East, CSLA, PAVN and other communist S.O.G. factions, terrains Weferlingen, Vietnam, Stožec, default EAST and CIV, RHS Russia, Eastern Militia, ChDKZ, 3CB LSM, Chernarus communists, KDF, Takistan, CSAT, CW USSR |
| ![](img/brands/lipa.png) | Lipa | `cigs_lipa_cigpack` | Livonia | 2035 | Filterless. Regional brand of Livonia | NATO (Woodland), LDF, Looters, terrain Livonia, 3CB LDF, LFR, LNM, LSM |
| ![](img/brands/lipa_dzwonek.png) | Lipa Dzwonek | `cigs_lipa_dzwonek_cigpack` | Livonia | 2035 | Filterless, blue "Bluebells" edition of Lipa | LDF, terrain Livonia, 3CB LDF, LFR |
| ![](img/brands/lucky_strike.png) | Lucky Strike | `cigs_lucky_strike_cigpack` | USA | WW2 | WW2 look: 1940s presets only | French Interior Forces, French Liberation Army, US Army (SPE), terrains Normandy and Mortain |
| ![](img/brands/marlboro.png) | Marlboro | `cigs_marlboro_cigpack` | USA | 1960s onwards | International Western filler for post-war presets | Most post-war Western factions and most terrains, RHS Russia, US, CDF, NAPA, HIDF, Serbia, most 3CB factions, 3CB BAF |
| ![](img/brands/matelot.png) | Matelot | `cigs_matelot_cigpack` | France / Tanoa, sailors' brand | timeless | Filterless. Regional brand of Tanoa and of French settings in any era, 1944 included | NATO (Pacific), Gendarmerie, Syndikat, MJTF, French Interior Forces, 40s Civilians, terrains Tanoa, Malden, Normandy and Mortain, RHS HIDF, TLA, 3CB MDF, TNM, TPD |
| ![](img/brands/morley.png) | Morley | `cigs_morley_cigpack` | Fictional, the mod's original pack | timeless | Filler for any era. Was `murshun_cigs_cigpack` in the original mod | Most Western factions, default WEST and CIV, RHS US, UN, HIDF, 3CB AAF, APD, FIA, MDF, TPD, NPD, UN, ION, CW US, BAF |
| ![](img/brands/nil.png) | NIL | `cigs_nil_cigpack` | Austria | timeless | Filler for any modern preset | Many vanilla factions, vanilla terrains, default CIV, 3CB AAF, APD, FIA, TPD, LDF, LFR, LNM, WEI |
| ![](img/brands/popularne.png) | Popularne | `cigs_popularne_cigpack` | Poland | Cold War | Filterless | Poland, Revolutionaries (GM), terrains Livonia and Stožec, 3CB LNM |
| ![](img/brands/prince.png) | Prince | `cigs_prince_cigpack` | Denmark | 1957 onwards | Danish, so also for Nordic peacekeepers | Denmark (GM), UNA (WS), RHS UN, Serbian UN, 3CB UN |
| ![](img/brands/ruby_queen.png) | Ruby Queen | `cigs_ruby_queen_cigpack` | South Vietnam, Cholon (Saigon) | Vietnam War | Filterless. Stands in for the whole theatre, communist side included | ARVN, Laos, Cambodia, Vietnamese civilians, PAVN, VC, Pathet Lao, Khmer Rouge, terrains Vietnam |
| – | Savage Wild Tiger | `cigs_savage_cigpack` | S.O.G. Prairie Fire's own cigarettes | Vietnam War | Only exists with S.O.G. Prairie Fire loaded. Its pack picture comes from the CDLC | All S.O.G. factions, terrains Vietnam |
| ![](img/brands/shanhai.png) | Shanhai | `cigs_shanhai_cigpack` | CSAT (China) | 2035 | Regional brand of the Pacific CSAT | CSAT (Pacific), Viper, terrain Tanoa, 3CB CSAT Pacific |
| ![](img/brands/sharig.png) | Sharig | `cigs_sharig_cigpack` | Takistan, Sharig Plateau | 1970s oil boom | Also stands in for Afghanistan and the Central Asian and Middle Eastern factions | 3CB Takistan, Afghan, Ardistan, Karzeghistan and Middle East factions |
| ![](img/brands/sosna.png) | Sosna | `cigs_sosna_cigpack` | Chernarus (Green Mountain) | 1980s look, used for every era | Menthol. The Chernarus brands are used for Chernarus factions of any era | AFMC, RHS CDF, NAPA, 3CB Chernarus factions |
| ![](img/brands/sparta.png) | Sparta | `cigs_sparta_cigpack` | Czechoslovakia, Kutná Hora | 1964 onwards | Regional brand of Czechoslovakia | CSLA, FIA (CSLA), terrain Stožec, 3CB NFA, NPD |
| ![](img/brands/troupes.png) | Troupes | `cigs_troupes_cigpack` | France, army issue | WW2 | Filterless. WW2 look: 1940s presets only | La Milice, French Interior Forces, French Liberation Army, 40s Civilians, terrains Normandy and Mortain |
| ![](img/brands/voron.png) | Voron | `cigs_voron_cigpack` | The author's unit | 2035 | 24 per pack. Only Spetsnaz, LDF and Looters | Spetsnaz, LDF, Looters, 3CB LDF |
| ![](img/brands/zamok.png) | Zamok | `cigs_zamok_cigpack` | Chernarus | 1980s look, used for every era | Premium domestic filter. The Chernarus brands are used for Chernarus factions of any era | AFMC, RHS Eastern Militia, CDF, 3CB Chernarus factions, GAF |
| ![](img/brands/zargabad.png) | Zargabad | `cigs_zargabad_cigpack` | Takistan, everyday bazaar brand | Kingdom era, 1960s–80s | Also stands in for Afghanistan and the Central Asian and Middle Eastern factions | 3CB Takistan, Afghan, Ardistan and Middle East factions |

## Planned brands

Brands with an open issue that faction presets already list. Their classnames are fixed on the issue; until a brand is in the mod, presets drop its pack.

| Name | Classname | Origin | Era | Planned for | Issue |
| ---- | --------- | ------ | --- | ----------- | ----- |
| Belomorkanal | `cigs_belomorkanal_cigpack` | Soviet Union / Russia, papirosa | 1932 onwards | RHS Russia, Eastern Militia, ChDKZ; 3CB Chernarus, Livonian separatists, Grozovia, Nogova, Kolgujev, Ardistan, CW USSR | #358 |
| Parliament | `cigs_parliament_cigpack` | modern Russia, premium | modern | RHS Russia | #359 |
| Newport | `cigs_newport_cigpack` | USA, menthol | modern | RHS US | #357 |
| Lambert & Butler | `cigs_lambert_butler_cigpack` | United Kingdom | modern | 3CB BAF | #360 |
| Sportsman | `cigs_sportsman_cigpack` | Kenya, East Africa | modern | 3CB African factions, CSAT Africa | #362 |

## Cigars

| Pack | Name | Classname | Origin | Era | Notes and restrictions | Used in |
| :--: | ---- | --------- | ------ | --- | ---------------------- | ------- |
| ![](img/brands/cigars.png) | Vulcano | `cigs_cigars_cigarbox_5` | Altis | timeless | 5 per box. Officers only, at unit class level | – |
| ![](img/brands/papa_schultz.png) | Papa Schultz | `cigs_papa_schultz_cigarbox_5` | Halo, the Sergeant's second favourite | sci-fi | 5 per box. Officers only, at unit class level | – |

## Other smokables

| Pack | Name | Classname | Origin | Era | Notes and restrictions | Used in |
| :--: | ---- | --------- | ------ | --- | ---------------------- | ------- |
| ![](img/brands/crayons.png) | Crayons | `cigs_crayons_crayonpack` | Gag brand | any | Suckable, no smoke. Only for the NATO crayon joke | NATO, NATO (Pacific), NATO (Woodland), NATO (Desert), MJTF (Desert and Woodland), default WEST and CIV |
| ![](img/brands/pops.png) | Lollipop | `cigs_pops_poppack` | – | any | Suckable, no smoke. For aid workers and civilians | IDAP, default CIV |
