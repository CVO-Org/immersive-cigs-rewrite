Planned title: Brand - New: Jiskra cigarettes (Czechoslovakia)
Label: pr/new

## What and why

Adds **Jiskra** ("spark"), a fictional Czechoslovak filter cigarette from the 1980s, for CSLA Iron Curtain: the CSLA army, the FIA resistance and civilians. It's meant to replace the Kosmos / Apollo Soyuz / NIL stand-ins for those factions. This PR doesn't map it to any faction; that comes with `presets_csla` (#320).

Closes #314

## Changes
- New addon `addons/jiskra`, copied from `voron` (filter template). Classnames `cigs_jiskra_cigpack`, `cigs_jiskra_cig0` … `cig4`, `cigs_jiskra_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke colour.
- `cigs_flavor[]` on `cig0` / `cig0_nv` (macro `FLAVOR_JISKRA` in `defines.hpp`): *brown coal smoke*, *the five-year plan*, *a factory canteen*, *a long night on the border*, *a queue for bananas*. Plain English strings, the same way crayons do it, since `fn_loopStart.sqf` formats them in unlocalised.
- Pack model's texture path renamed to `addons\jiskra\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90`, cork tint `#c98d4e`), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *Malá jiskra, plná chuť.* ("Small spark, full taste.") stays Czech in every language, like Matelot's French slogan.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_jiskra_author` (copied from `matelot`). **The owner may change it.**
- License: CC BY 4.0 (`addons/jiskra/license.md`, copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_jiskra_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
*Jiskra* is Czech for "spark": short and sporty like Start and Sparta, an ordinary word rather than a place or a company, and it gives the pack an easy mark (a spark star). A web search found no Jiskra cigarette brand, only sports clubs (TJ Jiskra …) that use the word; no Tatra / Škoda-style trademark is involved.

Alternatives, if the owner prefers another:
- **Brigáda** ("work brigade"): more openly socialist-era, a bit of a joke.
- **Úderník** ("shock worker"): the same idea, stronger flavour; harder to read for non-Czechs.
- **Směna** ("shift"): plain, but Směna was also a real Slovak newspaper.

### Filter or filterless
**With filter.** By the 1980s filter cigarettes made up most of Czechoslovak production (Sparta, Petra, the filter version of Start), so a filter pack fits CSLA in 1985 better than a 1950s-style plain cigarette. It also adds variety: the recent regional brands (Lipa, Matelot, Bông Sen) and Eckstein are all filterless. A filterless "cheap conscript" edition could come later as a separate brand variant, like Lipa Dzwonek.

### Artwork: first pass for the owner's review

There was no artist art. The faces and the paper logo are a **first pass** drawn as SVG in a 1980s Czechoslovak modernist style (off-white card, cobalt blue bands with red pinstripes, a red-and-orange spark star, DIN-like Bahnschrift lettering), with a light print grain and worn edges. Rendered with headless Edge, then composed.

- Front: *CIGARETY S FILTREM* band, the spark with three speed lines, JISKRA, the slogan, *20 CIGARET* and the printed price *Kčs 12,-* (ČSSR packs had the price printed on them).
- Back: Slovak *CIGARETY S FILTROM* band, JISKRA, slogan in Czech and Slovak, a box with *Kouření škodí zdraví. / Fajčenie škodí zdraviu.*, *VYROBENO V ČSSR*, batch code.
- Left: maker line *Tabákové závody Jiskra, n. p. · Hradiště · Vyrobeno v ČSSR* (fictional national enterprise in a fictional town), batch code.
- Right: *20 CIGARET S FILTREM / 20 cigariet s filtrom*, price.
- Top: JISKRA with the spark on blue. Bottom: production date and price.
- Paper: the spark above JISKRA, stacked along the cigarette, turned with `--paper-logo-rotate -90`, so its top points at the filter. It sits at u 330-389, next to the filter, so it stays whole through `cig3` (see the icon preview).
- Czech and Slovak diacritics (č, ř, ž, š, ť, í, á) render correctly in Bahnschrift; checked in the PNGs.

Where to look (local, not in the repo): `brand-drafts/jiskra-art/` in the main checkout has `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (the gear icon preview), each face as SVG and PNG, and `make_faces.py`, which re-renders them. Known limits: the spark reads a little like a compass rose; the speed lines on the front are simple.

### Translations that need a native speaker
- **Czech and Slovak (pack art):** slogan *Malá jiskra, plná chuť.* / *Malá iskra, plná chuť.*, warning *Kouření škodí zdraví.* / *Fajčenie škodí zdraviu.*, *20 cigariet s filtrom*, *Tabákové závody Jiskra, n. p.*, *ŠARŽE*. These are the ones to check first.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`/`lipa`. Japanese uses イスクラ for the name. Korean, Japanese and Chinese should get a look from a native speaker. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke, and that a flavour line shows up after lighting.

Also checked: `hemtt build` builds `cigs_jiskra.pbo`; the derapified config has `cigs_jiskra_cigpack` with `count = 20`, `cigs_item_glasses = "cigs_jiskra_cig0"` and `cigs_item_hmd = "cigs_jiskra_cig0_nv"`, and both classes exist; `mlod.py` reads the pack model and its paths point at `jiskra`/`base`; no `voron` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
