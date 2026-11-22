## What and why

Adds **Cocarde**, a French brand: filterless "tabac de troupe" cigarettes in the look of the WW2 French army ration packs. Kraft card printed in navy and red, the tricolour cockade as the mark. It's meant for the Spearhead 1944 French factions (SPE_FR_ARMY, SPE_FFI, SPE_MILICE, SPE_CIV) and later the Expeditionary Forces MJTF (EF_B_MJTF_Des/_Wdl/_Navy). This PR doesn't map it to any faction: the faction presets come in a later PR (#320).

Closes #317

## Changes
- New addon `addons/cocarde`, copied from `matelot` (the newest filterless brand, same layout as `eckstein`). Classnames `cigs_cocarde_cigpack`, `cigs_cocarde_cigpackItem`, `cigs_cocarde_cig0` … `cig4`, `cigs_cocarde_cig0_nv` … `cig4_nv`.
- **Filterless.** The Troupes and Caporal cigarettes of the era were filterless black tobacco, and it sets the brand apart from the filtered ones.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke a bit darker and greyer than default (`0.26, 0.26, 0.27`, black tobacco).
- Flavour lines (`cigs_flavor[]`, "Hmm, it tastes like %1!"): *black caporal tobacco*, *chicory coffee*, *army pinard*, *a wet greatcoat*, *a Paris bistro*. Plain English strings like `pops` and `crayons`: `fn_loopStart.sqf` puts the raw config text into `format`, so stringtable keys would show as `$STR_...`.
- Pack model's texture path renamed to `addons\cocarde\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), and the six gear icons rendered with `gear_icons.py --logo-v 127 --apply`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *Le tabac du soldat.* stays French in every language, like Matelot's.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_cocarde_author`, as in `matelot`, `almyra` and `lipa`.
- License: CC BY 4.0 (copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_cocarde_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main` or the presets.

### Name

**Cocarde** (the French tricolour cockade). A quick web search found no cigarette brand of that name. Alternatives, in my order of preference:
1. **Bivouac** - field camp; no cigarette brand found either.
2. **Poilu** - the WW1 French infantryman; fits WW1 better than WW2.
3. **Képi** - the French army cap; short and readable at 64 px.

*Caporal* is left out on purpose: it's a generic tobacco cut, and "Gauloises Caporal" is a real product. It appears on the pack only as the cut ("TABAC NOIR · CAPORAL").

### Artwork: first pass for the owner's review

No artist art. The faces and the paper logo are drawn as SVG and rendered with headless Edge, then composed. No real trademarks: no winged helmet, no dancer; the mark is the national cockade (blue, white, red roundel).

- Front: navy band *TABAC DE TROUPE*, tricolour line, big cockade, **COCARDE**, *Le tabac du soldat.*, *TABAC NOIR · CAPORAL*, a red rubber-stamp *RÉSERVÉ AUX ARMÉES*, navy foot *20 CIGARETTES · SANS FILTRE*.
- Back: COCARDE, slogan, a boxed notice *Tabac de troupe - Distribué gratuitement aux militaires des armées françaises. VENTE INTERDITE.*, *Tabac noir · coupe caporal*, small cockade, *MANUFACTURE DES TABACS · PARIS*.
- Left: maker line, *Tabac de troupe · Vente interdite*, batch *LOT 44-112 · T.3*.
- Right: COCARDE, *20 CIGARETTES SANS FILTRE*, small cockade.
- Top: kraft tax band *TABAC DE TROUPE · VENTE INTERDITE*, *Nº 44 0611 · 20 PCS*. Bottom: batch code between tricolour lines.
- Paper: a small cockade with COCARDE below it, stacked along the cigarette, top towards the mouth end, centred on u 300. Whole up to `cig3`; the `cig4` stub cuts it, as on the other filterless brands.
- Fonts: Bahnschrift (condensed) and Georgia italic. A period stencil or Didot would look more 1940s; I had none on this machine.
- A modern EF edition (for the MJTF) isn't part of this PR; it could follow as a variant brand like Lipa Dzwonek.

Where to look (local, not in the repo): `brand-drafts/cocarde-art/` in the main checkout: `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (gear icon preview), each face as SVG and PNG, and `make_faces.py`, which re-renders them.

### Translations that need a native speaker
- **French (pack art and stringtable):** *Le tabac du soldat.*, *Distribué gratuitement aux militaires des armées françaises.*, *Réservé aux armées*, *Vente interdite*. Check these first. Japanese uses コカルド for the name.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke colour, and the flavour message.

Also checked: `hemtt build` and the derapified `cigs_cocarde` config show `cigs_cocarde_cigpack` with `cigs_item_glasses = "cigs_cocarde_cig0"` and `cigs_item_hmd = "cigs_cocarde_cig0_nv"`, both of which exist; `mlod.py` reads the pack model and its paths point at `cocarde`/`base`; no `matelot` left in the folder; every `picture =` has its PAA; the icon preview shows the pack upright and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
