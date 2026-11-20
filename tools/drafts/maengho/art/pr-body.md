<!-- title: Brand - New: Maengho cigarettes (South Korea) -->
## What and why

Adds **Maengho** (맹호, "fierce tiger"), a filterless South Korean army-issue cigarette of the Vietnam War era (1960s to early 70s) for S.O.G. Prairie Fire's ROK forces (`B_ROK`). Inspired by the ROK army's own issue cigarette of that time, without copying any real pack or name. The name nods to the tiger, Korea's emblem animal, and to the "Tiger" division the ROK sent to Vietnam. This PR doesn't map it to any faction; that comes with `presets_sog` (#320).

Closes #318

## Changes
- New addon `addons/maengho`, copied from `matelot` (filterless). Classnames `cigs_maengho_cigpack`, `cigs_maengho_cig0` … `cig4`, `cigs_maengho_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke slightly darker than default (`0.24, 0.23, 0.22`).
- `cigs_flavor[]`: canned kimchi, roasted barley, a letter from home, red clay.
- Pack model's texture path renamed to `addons\maengho\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), six gear icons with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template.
- Author credit `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_maengho_author` (same as Matelot).
- License CC BY 4.0 (copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_maengho_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
**Maengho** (맹호, 猛虎) = fierce tiger. Classname and display name are the ASCII romanisation (`maengho`), so Arma's fonts show it in every language; only the Korean stringtable uses Hangul. A quick search found no cigarette brand of that name.

Alternatives:
- **Baekma** (백마, white horse): the other big ROK division in Vietnam; less iconic than the tiger.
- **Horangi** (호랑이, tiger): the everyday word; friendlier, less military.
- **Mugunghwa** (무궁화, rose of Sharon, the national flower): civilian and patriotic; could clash with a real brand of the 1950s, not checked.

### Filterless
Filterless, like the army-issue cigarettes Korean soldiers smoked in the 1960s; filter cigarettes were the dearer civilian brands then. That's from memory, not checked against a source. It still differs from Bông Sen (also filterless): olive drab army pack with a tiger and Hangul instead of a cream civilian pack with a lotus, and nothing like Shanhai (modern Chinese, filter).

### Artwork: first pass for the owner's review
No artist art. Faces and paper logo drawn as SVG and rendered with headless Edge: olive drab army-issue card, khaki pinstripe border, cream and red panels, a stylised snarling tiger head, grain and worn edges. Hangul is set in Malgun Gothic (ships with Windows, checked in the render). No health warning: packs of the era didn't have one.
- Front: *대한민국*, big **맹호**, red **MAENGHO** band, tiger in a red medallion, *담배 20개비* and five stars.
- Back: *대한민국*, tiger and MAENGHO in a cream panel, slogan *용맹한 장병에게* and *호랑이처럼 용맹하게*, *대한민국 제조*, batch *제 0612 호 · 1967*.
- Left: *맹호 담배 · 대한민국 제조 · 제 0612 호 · 1967*. Right: 맹 / 호 stacked upright, MAENGHO running down, *20개비*.
- Top: stamp *군용* (military issue). Bottom: name and batch.
- Paper: small tiger head with 맹호 stacked below, the tiger towards the mouth end, centred on u 300. Whole up to `cig3`, cut by the `cig4` stub.

Review art (local, not in the repo): `brand-drafts/maengho-art/` in the main checkout: `faces-sheet.png`, `texture.png`, `icons-preview.png`, each face as SVG and PNG, and `make_faces.py`, which re-renders them.

### Translations that need a native speaker
- **Korean on the pack (check first):** *대한민국* (Republic of Korea), *맹호* (fierce tiger), *담배 20개비* (20 cigarettes), *용맹한 장병에게* (to the brave soldiers), *호랑이처럼 용맹하게* (brave as a tiger), *대한민국 제조* (made in Korea), *제 0612 호* (No. 0612, meant as a batch number), *군용* (military issue).
- **Stringtable:** Korean uses 맹호 담배 / 맹호 한 갑 and translates the slogan as *호랑이처럼 용맹하게.* The in-game slogan is translated per language (*Fierce as a tiger.*). Japanese uses メンホ, which may be off. The "Contains 20" and "Warning" parts are copied from `matelot`; the Chinese warning keeps the existing joke text of the other brands. Korean, Japanese and Chinese should get a look.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, the Korean name with the Korean game language, taking a cigarette out, lighting it, all five stages, the smoke and the flavour line.

Also checked: `hemtt build` rapifies `cigs_maengho_cigpack`, whose `cigs_item_glasses` / `cigs_item_hmd` (`cigs_maengho_cig0`, `cigs_maengho_cig0_nv`) exist; `mlod.py` reads the pack model and its paths point at `maengho`/`base`; no `matelot` left in the folder; every `picture =` has its PAA.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
