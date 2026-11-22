<!-- title: Brand - New: Hejnał cigarettes (Poland) -->
<!-- label: pr/new -->
## What and why

Adds **Hejnał**, a Cold War Polish cigarette for Global Mobilization's Polish faction (`gm_fc_pl`): a cheap, strong, filterless smoke from the PRL state tobacco industry, 1970s-80s, inspired by Popularne, Sport, Klubowe and Caro without copying any of them. The name is the bugle call played every hour from St Mary's tower in Kraków; the slogan *Na każdą godzinę.* ("For every hour.") plays on that. It's meant to replace Lipa, which stands in for it today: Lipa is a modern Livonian brand (cream and green, big health-warning boxes, barcode), Hejnał is a state-monopoly product (red and black on cheap paper, a price printed on the pack, a factory batch code, a small warning). This PR doesn't map it to any faction; that's the GM faction preset PR (#320).

Closes #312
Part of #320

## Changes
- New addon `addons/hejnal`, copied from `matelot` (filterless). Classnames `cigs_hejnal_cigpack`, `cigs_hejnal_cig0` … `cig4`, `cigs_hejnal_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke a bit darker than default (`0.27, 0.26, 0.24`).
- `cigs_flavor[]`: *a long queue*, *the night shift*, *coal smoke*, *the last tram home*, *a factory canteen* ("Hmm, it tastes like a long queue!").
- Pack model's texture path renamed to `addons\hejnal\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), and the six gear icons with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan stays Polish in every language, like Matelot's stays French.
- Author credit: `OverlordZorn` (`authors[]` and `STR_cigs_hejnal_author`), as in Matelot.
- License: CC BY 4.0 (`addons/hejnal/license.md`, copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_hejnal_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, `addons/ai` or the presets.

### Design choices
- **Without filter.** The cheap everyday PRL smokes (Popularne, Sport, Giewont, Wawel) were filterless; filter cigarettes (Caro, Klubowe later) were the dearer ones. Era fit beats variety here, even though Lipa, Matelot and the other Cold War brands built tonight lean filterless too.
- **Look.** A full red pack with a cream top band and a black price band, a double cream frame, and a brass/cream herald trumpet with a hanging swallowtail banner and three sound arcs. The name is set in a bold condensed sans (Bahnschrift), like the flat two-colour print of the period. Kept away from the cream-and-colour-band look of Lipa, Jiskra and Brigade.
- **Pack texts (Polish):** front *PAPIEROSY / HEJNAŁ / BEZ FILTRA / 20 SZTUK / Cena 24 zł*; back slogan, *Mieszanka tytoni krajowych o pełnym, mocnym smaku.* ("a blend of domestic tobaccos, full and strong"), *Palenie tytoniu szkodzi zdrowiu.*, and a made-up branch standard *BN-78/9131-02*; left side maker *Państwowe Zakłady Tytoniowe · Kraków · Wyprodukowano w PRL* and a batch code; right side *20 PAPIEROSÓW BEZ FILTRA*; top flap name and trumpet; bottom batch code. The maker name is generic and made up (the real enterprise was "Zakłady Przemysłu Tytoniowego w Krakowie"); the price is a plausible mid-80s figure, not researched.
- **Paper logo:** a small red trumpet above HEJNAŁ, stacked, its top towards the mouth end, centred on u 300. Whole up to `cig3`; the `cig4` stub cuts it.
- **Font check:** Bahnschrift, Georgia and Consolas on this machine render ł, ą, ę, ż, ó, ń, ś correctly (see the faces sheet).

### Name alternatives
- **Ognik** ("little flame", also a will-o'-the-wisp) - short and easy for non-Polish players.
- **Zryw** ("surge, uprising") - very PRL-poster, but also the name of a Polish motor scooter.
- **Przystań** ("harbour, haven") - softer, more of a 60s feel.

A quick web search found no Polish cigarette brand called Hejnał or Ognik. Not a trademark search.

### Translations that need a native speaker
- **Polish (pack art, slogan and the `Polish` stringtable entries):** everything listed above under pack texts, plus *Papieros Hejnał*, *Paczka Hejnał*, *Zawiera 20 papierosów*. Please check these first.
- **Japanese:** ヘイナウ for the name. Korean, Japanese and Chinese should get a look; the "Contains 20" and "Warning" parts are copied from `matelot`, and the Chinese warning keeps the joke text of the other brands.
- The display name keeps the Ł everywhere. Arma's UI fonts have Polish glyphs (Arma ships a Polish localisation), but it's worth a look in the inventory.

### Review art (local, not in the repo)
`brand-drafts/hejnal-art/` in the main checkout: `faces-sheet.png` (all faces, laid out like the texture), `texture.png`, `icons-preview.png`, each face as SVG and PNG, and `make_faces.py`, which re-renders them (`python make_faces.py`).

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **not tested in game, I can't run it.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the paper logo near the mouth end, the smoke, and a flavour line after lighting up.

Also checked: `hemtt build` shows `cigs_hejnal_cigpack` with `cigs_item_glasses = "cigs_hejnal_cig0"` and `cigs_item_hmd = "cigs_hejnal_cig0_nv"`, both of which exist; `mlod.py` shows the pack model's paths point at `hejnal`/`base`; no `matelot` left in the folder; every `picture =` has its PAA.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
