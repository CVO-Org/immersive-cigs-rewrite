## What and why

Adds **Bông Sen** ("lotus flower"), a cheap filterless Vietnamese cigarette of the Vietnam War era (1960s-1973) for S.O.G. Prairie Fire: PAVN, VC, ARVN, Vietnamese civilians, and Laos/Cambodia if wanted. The lotus works on both sides of the war, so one brand covers North, South and civilians. This PR doesn't map it to any faction; that comes with `presets_sog` (#320).

Closes #310

## Changes
- New addon `addons/bong_sen`, copied from `matelot` (filterless, itself from `eckstein`). Classnames `cigs_bong_sen_cigpack`, `cigs_bong_sen_cig0` … `cig4`, `cigs_bong_sen_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke slightly darker than default (`0.27, 0.26, 0.23`).
- `cigs_flavor[]`: dark tobacco, monsoon rain, rice paper, charcoal smoke, river mud.
- Pack model's texture path renamed to `addons\bong_sen\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), six gear icons with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template.
- Author credit `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_bong_sen_author` (same as Matelot, Almyra, Shanhai).
- License CC BY 4.0 (copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_bong_sen_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
**Bông Sen** = lotus flower, Vietnam's national flower and common on both sides. The display name keeps its diacritic: `ô` is Latin-1, so Arma's fonts show it. Classnames are ASCII (`bong_sen`). A quick search found no Vietnamese cigarette brand of that name (there is an unrelated herbal medicine called Bông Sen).

Alternatives:
- **Sen Vàng** (golden lotus): same idea, sounds more premium.
- **Mê Kông**: the river, ties it to the delta; could read as southern.
- **Lúa Vàng** (golden rice): rural, cheap; less iconic.

Possible follow-up: a North / South split (e.g. a plainer, ration-style edition for PAVN/VC next to this one), as #310 suggests.

### Artwork: first pass for the owner's review
No artist art. Faces and paper logo drawn as SVG and rendered with headless Edge: cheap offset-print look (cream card, red top band, jade green bottom band, pink lotus, gold accents), grain and worn edges. No health warning: packs of the era didn't have one.
- Front: *THUỐC LÁ*, **BÔNG SEN**, slogan *Thơm như hoa sen*, lotus in a medallion over water, *20 ĐIẾU · KHÔNG ĐẦU LỌC*.
- Back: name, lotus pond, slogan, *Thuốc lá ngon, giá phải chăng.*, *SẢN XUẤT TẠI VIỆT NAM*, batch *LÔ 0417 · 1968*.
- Left: *XƯỞNG THUỐC LÁ BÔNG SEN · Sản xuất tại Việt Nam · LÔ 0417 · 1968*. Right: *20 ĐIẾU THUỐC LÁ · KHÔNG ĐẦU LỌC*.
- Top: tax stamp *TEM THUẾ · Nº 0417 · 20 ĐIẾU* (no state named, so it fits both sides). Bottom: name and batch.
- Paper: small lotus with BÔNG SEN stacked below it, the lotus towards the mouth end, centred on u 300. Whole up to `cig3`, cut by the `cig4` stub.

Review art (local, not in the repo): `brand-drafts/bong_sen-art/` in the main checkout: `faces-sheet.png`, `texture.png`, `icons-preview.png`, each face as SVG and PNG, and `make_faces.py`, which re-renders them.

### Translations that need a native speaker
- **Vietnamese on the pack (check first):** *Thuốc lá* (cigarettes), *Thơm như hoa sen* (fragrant as the lotus), *Thuốc lá ngon, giá phải chăng* (good tobacco, fair price), *20 điếu* (20 sticks), *Không đầu lọc* (no filter), *Sản xuất tại Việt Nam* (made in Vietnam), *Xưởng thuốc lá Bông Sen* (Bông Sen tobacco works), *Tem thuế* (tax stamp), *Lô* (batch).
- **Stringtable:** the in-game slogan is translated per language (*Fragrant as the lotus.*) instead of kept in Vietnamese, because Arma's fonts may not show letters like ơ. The "Contains 20" and "Warning" parts are copied from `matelot`. Japanese uses ボンセン. Korean, Japanese and Chinese should get a look. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, the `Bông Sen` name in the inventory (does `ô` render?), taking a cigarette out, lighting it, all five stages, the smoke and the flavour line.

Also checked: `hemtt build` rapifies `cigs_bong_sen_cigpack`, whose `cigs_item_glasses` / `cigs_item_hmd` (`cigs_bong_sen_cig0`, `cigs_bong_sen_cig0_nv`) exist; `mlod.py` reads the pack model and its paths point at `bong_sen`/`base`; no `matelot` left in the folder; every `picture =` has its PAA.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
