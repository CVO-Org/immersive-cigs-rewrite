<!-- title: Brand - New: Chergui cigarettes (North Africa) -->
## What and why

Adds **Chergui**, a North African brand for Western Sahara (Argana): cheap, filterless dark tobacco (*tabac brun*) from the fictional *Régie des Tabacs de Sefrou-Ramal*, printed in French and Arabic, the way a former French colony's state tobacco would be. It's meant for SFIA and Tura (`IND_SFIA_lxWS`, `IND_TURA_lxWS` and their children), but this PR doesn't map it to any faction: that comes with `presets_ws` (#320).

The name is the *chergui*, the hot, dry east wind off the desert in Morocco and western Algeria. Inspired by Casa Sport, Marquise and Rym, without copying any of them. A quick search found no cigarette brand of that name (only a Serge Lutens perfume).

Closes #315

## Changes
- New addon `addons/chergui`, copied from `matelot` (filterless template). Classnames `cigs_chergui_cigpack`, `cigs_chergui_cig0` … `cig4`, `cigs_chergui_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke a bit darker and warmer than default (`0.27, 0.25, 0.22`) for the dark tobacco.
- `cigs_flavor[]`: "dark tobacco", "dust and diesel", "mint tea", "hot sand", "the east wind" (macro `FLAVORS_CHERGUI` in `defines.hpp`).
- Pack model's texture path renamed to `addons\chergui\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *Le vent de l'est.* stays French in every language, like Matelot's.
- Author credit: `OverlordZorn` (`authors[]` and `STR_cigs_chergui_author`), as for Matelot. **The owner may change it.**
- License: CC BY 4.0 (`addons/chergui/license.md`, copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_chergui_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Design choices
- **Filterless**, because the cheap local North African cigarette is the filterless dark-tobacco one (Casa Sport is the classic). It also sets it apart from Almyra and Alborz, which both have filters.
- **Soft pack, painted on.** The pack model is the shared hard pack, so the soft-pack feel comes from the art: a green paper tax stamp (*timbre fiscal*) runs over the top from back to front with torn ends, no lid lines.
- **Distinct from Almyra and Alborz.** Almyra is clean blue/white/yellow, Alborz navy/teal/gold with ornament. Chergui is brick red over sand with a black base band, a black-and-sand zigzag border and a coarse, slightly worn print: cheap, loud and local.
- **Mark:** a low red sun over two dunes with the east wind blowing across it, in a black ring. On the paper it sits above CHERGUI, both pointing at the mouth end, 9-18 mm from it (u 300), whole up to `cig3`.
- Faces: front CHERGUI / الشركي, the mark, *Le vent de l'est.*, *TABAC BRUN · SANS FILTRE · 20 CIGARETTES*. Back: slogan in French and Arabic, health warning in French and Arabic, maker line, barcode. Left: maker and lot, *Tabac brun du pays.*, *PRIX PUBLIC 9,00* (no currency, since Sefrou-Ramal's isn't known). Right: *20 CIGARETTES* / ٢٠ سيجارة, small mark, *SANS FILTRE* / بدون فلتر. Top: the tax stamp. Bottom: lot code, *FABRIQUÉ À SEFROU-RAMAL*. Colours line up all round (red band, zigzag, sand, black base).
- Arabic rendered with headless Edge (Segoe UI), which shapes it properly (right to left, joined letters). Checked by eye in the PNGs.

### Name alternatives
- **Simoun** (the desert wind of the Sahara; French spelling)
- **Hamada** (the stony desert plateau of the Western Sahara)
- **Caravane**

### Translations that need a native speaker
- **Arabic (pack art only, Arma has no Arabic):** check these first.
  - الشركي (*ech-chergui*, the brand name). Moroccan usage writes the wind with ك for the hard g; Standard Arabic would be الشرقي.
  - ريح الشرق (*the east wind*, slogan)
  - التدخين مضر بالصحة (*smoking is harmful to health*, warning)
  - ٢٠ سيجارة (*20 cigarettes*) and بدون فلتر (*without filter*)
- **French (pack art and stringtable):** *Le vent de l'est.*, *Fumer nuit gravement à votre santé.*, *Tabac brun du pays.*, *Régie des Tabacs de Sefrou-Ramal*, *Fabriqué à Sefrou-Ramal*, *Timbre fiscal*. Likely fine, unchecked.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`. Japanese uses シェルギ for the name. Korean, Japanese and Chinese should get a look. The Chinese warning keeps the existing joke text of the other brands.

### Review art
Local, not in the repo: `brand-drafts/chergui-art/` in the main checkout has `faces-sheet.png` (all faces; the bottom shown turned 180° as in the texture, the logo on paper colour), `texture.png`, `icons-preview.png`, `paper-logo-closeup.png` (u 200-400, mouth end to the right), each face as SVG and PNG, and `make_faces.py`, which re-renders them.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **not tested, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke colour and the flavour line.

Also checked: `hemtt build` makes `cigs_chergui.pbo`, and its config has `cigs_chergui_cigpack` pointing at `cigs_chergui_cig0` / `cigs_chergui_cig0_nv`, which exist; `mlod.py` reads the pack model and its paths point at `chergui`/`base`; no `matelot` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
