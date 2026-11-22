<!-- title: Brand - New: Stockton cigarettes (International) -->
## What and why

Adds **Stockton**, a mainstream American full-flavour filter cigarette of today, the "world's best-seller" type. It is meant for the international factions (IDAP, ION, UN) and as general filler instead of NIL for modern western factions. This PR doesn't map it to any faction; that comes with the CDLC faction presets (#320).

Part of #316

## Changes
- New addon `addons/stockton`, copied from `voron` (filter template). Classnames `cigs_stockton_cigpack`, `cigs_stockton_cig0` … `cig4`, `cigs_stockton_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke.
- `cigs_flavor[]` (in `defines.hpp` as `FLAVOR_STOCKTON`): toasted Virginia leaf, a truck stop at dawn, the duty-free shop, a long-haul flight, burnt coffee.
- Pack model's texture path renamed to `addons\stockton\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90`, cork filter `#c78a4c`), six gear icons with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template.
- Author credit `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_stockton_author` (same as Matelot).
- License CC BY 4.0 (copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_stockton_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
**Stockton**: an American place name, like many big US brands, short and confident. A quick search found no cigarette brand of that name. Kept clear of "West" (a real German brand), which ruled out *Westmark*.

Alternatives:
- **Ridgemont**: same feel, a bit more upmarket.
- **Halstead**: sounds older, more tobacco-heritage.
- **Bannerman**: very American, but long for the pack front.

### Design: first pass for the owner's review
No artist art. Faces and paper logo drawn as SVG and rendered with headless Edge: a clean modern print, off-white card with a navy top band, red keylines and a navy "20 CLASS A CIGARETTES / KING SIZE" band.
- **Mark:** a red diamond with a white rim and a white five-point star, on a navy keyline. Bold and geometric, reads American, and stays clear of Marlboro's red chevron roof, crest and cowboy, and of the other red/white packs in the mod (Lucky Strike's bullseye, Morley's crest, Craven's red card). Navy is the main colour, so it doesn't look like a red pack at a glance; Voron is black.
- **Front:** *FILTER CIGARETTES*, the mark, **STOCKTON** in a heavy sans, slogan *AMERICA'S FULL FLAVOR*, *20 CLASS A CIGARETTES · KING SIZE*, and an English health warning box (*Smoking causes lung cancer, heart disease and emphysema.*).
- **Back:** smaller mark and name, a large warning box (*Cigarettes are addictive…*).
- **Sides:** right is navy with the name running top to bottom; left has *20 CLASS A CIGARETTES*, the fictional *Stockton Tobacco Company, Richmond, Virginia · Made in U.S.A.* and tar/nicotine numbers.
- **Top flap:** navy with mark and name. **Bottom:** barcode, name, lot code.
- **Paper:** small mark with STOCKTON stacked below, the mark towards the filter, next to a cork filter.

Review art (local, not in the repo): `brand-drafts/stockton-art/` in the main checkout: `faces-sheet.png`, `texture.png`, `icons-preview.png`, each face as SVG and PNG, and `make_faces.py`, which re-renders them.

### Translations that need a native speaker
The description (*America's full flavor. Sold all over the world.*) is translated per language by me. The "Contains 20" and "Warning" parts are copied from the template. Japanese uses ストックトン. Korean, Japanese and Chinese should get a look; the Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke and the flavour line.

Also checked: `hemtt build` rapifies `cigs_stockton_cigpack`, whose `cigs_item_glasses` / `cigs_item_hmd` (`cigs_stockton_cig0`, `cigs_stockton_cig0_nv`) exist; `mlod.py` reads the pack model and its paths point at `stockton`/`base`; no `voron` left in the folder; every `picture =` has its PAA.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
