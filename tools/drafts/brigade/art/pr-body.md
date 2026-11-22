<!-- Title: Brand - New: Brigade cigarettes (East Germany) · label: pr/new -->

## What and why

Adds **Brigade**, the East German (GDR) Cold War brand for Global Mobilization (`gm_fc_gc`, `_bgs`, `_civ`): a plain, slightly drab VEB product from the 1970s-80s, made by the fictional *VEB Tabakwerk Elbaue*. It's the everyday smoke of the factory floor and the barracks, in the spirit of f6, Club, Cabinet and Juwel without copying any of them. The name nods to the GDR's *Brigaden* (work teams on the shop floor). This PR doesn't map it to any faction: the GM faction preset comes later (#320).

The West German brand is a separate PR.

Part of #311

## Changes
- New addon `addons/brigade`, copied from `voron` (filter template). Classnames `cigs_brigade_cigpack`, `cigs_brigade_cigpackItem`, `cigs_brigade_cig0` … `cig4`, `cigs_brigade_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke colour.
- `cigs_flavor[]` on `cig0` (glasses and NVG item), plain strings like the crayons: *brown coal*, *the night shift*, *Trabant exhaust*, *overfulfilled quotas*, *a Sunday at the allotment*. They're in `defines.hpp` (`FLAVOR_BRIGADE`), so both files share one list.
- Pack model's texture path renamed to `addons\brigade\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90`, cork filter `#c99a5c`), and the six gear icons rendered with `gear_icons.py --logo-v 127 --apply`.
- `stringtable.xml`: name, pack name and description in the template's ten languages. The slogan *Für die Frühschicht.* ("For the early shift.") stays German in every language, like Matelot's slogan stays French.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_brigade_author` (as in `matelot`). **The owner may change it.**
- License: CC BY 4.0 (`addons/brigade/license.md`, copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_brigade_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, `addons/ai` or the presets.

### Name
**Brigade** (folder `brigade`). A quick web search found no cigarette brand of that name; the only hit was a cancelled US trademark *"Brigade by Carlos Toraño"* (a cigar maker's line, cancelled 2018). Not a full trademark search.

Alternatives, if the owner prefers one:
- **Elbtal** – place name in the Dresden-factory tradition; no cigarette brand found, but blander.
- **Diplom** – sounds like Cabinet/Club; close to the real (Soviet-era) *Diplomat*, so I skipped it.
- **Garant** – very GDR-sounding, but it is a current nicotine-pouch brand, so I skipped it.

### Filter or filterless
**With filter.** All four brands named in the issue (f6, Club, Cabinet, Juwel) were filter cigarettes, the filter cigarette was the GDR's everyday standard by the 1970s-80s, and the cheap filterless option (Karo) is a different niche. It also sets it apart from the other German brand in the mod, Eckstein (WW2, filterless). Cork-coloured filter.

### Design choices (first pass, no artist art)
Drawn as SVG (`make_faces.py`), rendered with headless Edge, then composed. Cream card, dark green bands, brick-red accents, Bahnschrift (DIN-like) lettering: a plain state-factory look. Colours chosen to stay away from the red-white f6, the blue Club and the yellow-brown Cabinet.
- **Mark:** a red roundel with a cream "B" and two rules under it. No state emblem, no hammer, compass, wreath or gear wheel, no "Q" quality mark.
- **Front:** maker line *VEB TABAKWERK ELBAUE*, roundel, BRIGADE on a green band between red rules, *Für die Frühschicht.*, red FILTER plate, *20 ZIGARETTEN*, price band *EVP 3,20 M* (GDR packs printed the retail price, *Einzelhandelsverkaufspreis*).
- **Back:** small roundel, BRIGADE, slogan, *Eine milde Mischung ausgesuchter Tabake mit Filter.*, maker line *Betrieb im Kombinat Tabak*, *TGL 22813 · Gütekl. I* (TGL was the GDR standards prefix; the number is made up), price band.
- **Left side** (bottom to top): BRIGADE on a green bar, *VEB Tabakwerk Elbaue · Dresden*, print code *Ag 08/84 · Nr. 1173*. **Right side** (top to bottom): *20 ZIGARETTEN / MIT FILTER*, roundel, *3,20 M*.
- **Top flap:** roundel + BRIGADE. **Bottom:** price and print codes.
- **No health warning on the pack:** GDR packs of the era didn't carry one. The stringtable description keeps the usual warning line like every other brand.
- **Paper logo:** small roundel above BRIGADE, rotated -90 so its top points at the filter (reads from the front of the cigarette), next to the filter at u 330-389. Whole up to `cig3`.

Where to look (local, not in the repo): `brand-drafts/brigade-art/` in the main checkout: `faces-sheet.png` (all faces), `texture.png` (composed texture), `icons-preview.png` (gear icons), each face as SVG and PNG, and `make_faces.py`, which re-renders them. Known limits: the roundel is simple; the print grain is light.

### Translations that need a native speaker
- **German (pack art and slogan):** *Für die Frühschicht.*, *Eine milde Mischung ausgesuchter Tabake mit Filter.*, *Betrieb im Kombinat Tabak*, *Gütekl. I*. Likely fine, but please read them with GDR wording in mind.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`/`morley`. Japanese uses ブリガーデ for the name. Korean, Japanese and Chinese should get a look from a native speaker. The Chinese warning keeps the existing joke text of the other brands.
- **Flavour lines** are English only (plain strings, as `cigs_flavor[]` is used elsewhere).

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game.** I can't run the game. Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it (and the flavour line), all five stages, the smoke.

Also checked: `hemtt build` builds `cigs_brigade.pbo`; its derapified config has `cigs_brigade_cigpack` with `cigs_item_glasses = cigs_brigade_cig0` and `cigs_item_hmd = cigs_brigade_cig0_nv`, both defined in the same PBO, `count = 20`, and `cigs_flavor[]` on both stage 0 classes. `mlod.py` reads the pack model and its paths point at `brigade`/`base`; no `voron` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
