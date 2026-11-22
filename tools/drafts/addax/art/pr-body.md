<!-- title: Brand - New: Addax cigarettes (International) -->
## What and why

Adds **Addax**, a mainstream international brand: an American Turkish-blend filter cigarette in the spirit of Camel, with a desert-animal theme of its own. It's meant for the international factions (IDAP, Western Sahara ION, UN) and as general filler instead of NIL for modern western factions. This PR doesn't map it to any faction; that comes with the CDLC faction presets (#320).

Part of #316

## Changes
- New addon `addons/addax`, copied from `voron` (filter template). Classnames `cigs_addax_cigpack`, `cigs_addax_cigpackItem`, `cigs_addax_cig0` … `cig4`, `cigs_addax_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke colour.
- Flavour lines (`cigs_flavor[]` on `cig0` in both files, via `FLAVOR_ADDAX` in `defines.hpp`): *dry figs*, *sun-warmed honey*, *cedar smoke*, *a long convoy*, *a caravan campfire*.
- Pack model's texture path renamed to `addons\addax\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (paper logo with `--paper-logo-rotate -90`, cork tinted `#c68c55`), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description (*Turkish and American blend. A taste that travels.*) in all ten languages of the template.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_addax_author`, as on Matelot. **The owner may change it.**
- License: CC BY 4.0 (`addons/addax/license.md`, copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_addax_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main` or the presets.

### Design choices
- **Name:** the addax is a white Saharan antelope with long corkscrew horns. It gives the "exotic desert animal" feel of the Camel archetype without a camel, dromedary or anything that echoes the Camel name. A web search found no cigarette brand called Addax.
- **Alternatives:** *Oryx* (straight horns, but probably used by some Gulf products), *Fennec* (desert fox; playful, less "premium blend"), *Caracal* (desert lynx).
- **Filter:** a modern mainstream international cigarette is a filter cigarette. This also keeps it apart from Chergui (North African, filterless, brick and sand).
- **Palette and layout:** ivory card, deep teal bands, copper rules, navy wordmark. No yellow-tan, no pyramids and palms: the mark is an addax head in profile in front of a copper sun over dunes, in a round medallion. "American blend" and "Fine Turkish & Domestic Tobaccos" carry the American Turkish-blend message. The teal and ivory keep it apart from Almyra and Chergui.
- **Pack text (English, modern era):** front: AMERICAN BLEND, ADDAX, *Fine Turkish & Domestic Tobaccos*, medallion, FILTER CIGARETTES, and a front warning box *SMOKING KILLS / Quit now. Ask your doctor for help.* Back: slogan *A taste that travels.*, a short blend blurb and a large warning (*Smoking causes lung cancer, heart disease and emphysema.*). Left: maker line *Addax Tobacco Company · Durham, N.C. · Made in U.S.A.*, tar/nicotine line, *FOR EXPORT* lot code. Right: ADDAX, *20 FILTER CIGARETTES*, *Turkish & American Blend*. Top flap: addax mark, ADDAX, AMERICAN BLEND. Bottom: a made-up barcode, ADDAX, 20 CIGARETTES.
- **Paper logo:** the addax head with ADDAX under it, stacked; the head's top points at the filter, so it reads from the front of the cigarette. It stays whole up to `cig3`.

### Artwork: first pass for the owner's review
There was no artist art. Everything is drawn as SVG (`make_faces.py`) and rendered with headless Edge, with a light print grain. The wordmark is Bahnschrift Condensed (on every Windows 10/11 machine); the serif lines are Georgia.

Where to look (local, not in the repo): `brand-drafts/addax-art/` in the main checkout has `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (the gear icon preview), each face as SVG and PNG, `logo.svg`/`logo.png` (paper logo) and `make_faces.py`, which re-renders them. Known limits: the addax head is a simple silhouette; the right side has a fairly empty middle.

### Translations that need a native speaker
- The description is translated in all ten languages. French, Spanish, Portuguese, German and Polish are likely fine. **Korean, Japanese and Chinese** should get a look. Japanese uses アダックス for the name. The Chinese warning keeps the existing joke text of the other brands.
- The pack art is English only.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **not tested, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the flavour line after lighting up.

Also checked: `hemtt build` produces `cigs_addax.pbo` with `cigs_addax_cigpack` and the `cig0`/`cig0_nv` classes it references; `mlod.py` reads the pack model and its paths point at `addax`/`base`; no `voron` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px, and the paper logo is whole up to `cig3`.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
