Planned title: Brand - New: Feierabend cigarettes (West Germany)
Label: pr/new

## What and why

Adds **Feierabend** ("knocking-off time", the evening after work), a fictional West German filter cigarette of the 1970s-80s, for Global Mobilization's West German side: the Bundeswehr (`gm_fc_ge`), the BGS and West German civilians. It's meant to replace the NIL filler in those faction presets. This PR doesn't map it to any faction; that comes with the GM faction preset (#320). The East German brand is a separate PR.

Part of #311

## Changes
- New addon `addons/feierabend`, copied from `voron` (filter template). Classnames `cigs_feierabend_cigpack`, `cigs_feierabend_cig0` … `cig4`, `cigs_feierabend_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke colour.
- `cigs_flavor[]` on `cig0` / `cig0_nv` (macro `FLAVOR_FEIERABEND` in `defines.hpp`): *the end of a long shift*, *Kaffee und Kuchen*, *the Wirtschaftswunder*, *a Bundesliga Saturday*, *the last round at the Kneipe*. Plain English strings like the other brands, since they are formatted into "Hmm, it tastes like %1!" unlocalised.
- Pack model's texture path renamed to `addons\feierabend\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90`, cork tint `#c4874a`), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *Für die Stunde nach der Arbeit.* ("For the hour after work.") stays German in every language, like Matelot's French and Jiskra's Czech slogans.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_feierabend_author` (copied from `matelot`). **The owner may change it.**
- License: CC BY 4.0 (`addons/feierabend/license.md`, copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_feierabend_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
*Feierabend* is the German word for the end of the working day and the free evening after it. It's an everyday word every West German smoker of the time would know, it fits the advertising mood of the era (HB's "Wer wird denn gleich in die Luft gehen?" sold relaxation after a stressful day), and it gives the pack an easy mark: a setting sun. Two web searches found no cigarette brand called Feierabend, real or historical; the word is generic, no trademark or logo is copied.

Alternatives, if the owner prefers another:
- **Kurfürst** ("prince-elector"): the old-money, crest-and-gold style of Reval / Peter Stuyvesant era packs.
- **Rheinperle** ("Rhine pearl"): regional and a bit kitschy, very 1970s. (I avoided *Rheingold*: there was a Rheingold cigar brand.)
- **Stammtisch** ("regulars' table at the pub"): the same idea as Feierabend, more of a joke.

### Filter or filterless
**With filter, cork-look tip.** By the 1970s-80s the West German mainstream had gone over to filter cigarettes: HB and Ernte 23 were filter brands; plain cigarettes like Reval ohne Filter were the minority, old-smoker choice. The cork-coloured tip (`--filter "#c4874a"`) is the look of the HB / Ernte 23 era. It also sets it apart from the recent filterless regional brands (Lipa, Matelot, Bông Sen), while the East German brand can carry the filterless "cheap" look if that agent picks it.

### Artwork: first pass for the owner's review

There was no artist art. The faces and the paper logo are a **first pass** drawn as SVG in a 1970s West German style (cream card, chocolate-brown bands with orange and mustard pinstripes, a setting-sun mark with stripes under the horizon, round heavy lettering), with a light print grain and worn edges. Rendered with headless Edge, then composed.

- Front: *FILTER-CIGARETTEN* band, the sun, **Feierabend**, the slogan in italic, *20 CIGARETTEN*, *MILD · AROMATISCH*. Old-style "Cigaretten" spelling, as packs of the time used it.
- Back: Feierabend, slogan, and a warning box in the style of the 1981-era West German text: *Der Bundesminister für Jugend, Familie und Gesundheit: Rauchen gefährdet Ihre Gesundheit.* plus the nicotine/condensate line *(Durchschnittswerte nach DIN)*; *MADE IN W.-GERMANY*, batch code and a made-up EAN.
- Left: maker line *Cigarettenfabrik Aldermann & Sohn · Bremen · Hergestellt in der BRD* (fictional company), *Seit 1952 für den Feierabend.*
- Right: Feierabend, *20 FILTER-CIGARETTEN*, small sun.
- Top: Feierabend with the sun on brown, and a green *TABAKSTEUER · DM 3,00 · 20 Stück* tax stamp running over the lid (West German packs carried a Steuerbanderole there).
- Bottom: Feierabend and the batch code.
- Paper: the sun above *Feierabend*, stacked along the cigarette, turned with `--paper-logo-rotate -90` so its top points at the filter. It sits at u 330-389 next to the filter and stays whole through `cig3` (see the icon preview).
- German umlauts (ü, ä) render correctly; checked in the PNGs.

Where to look (local, not in the repo): `brand-drafts/feierabend-art/` in the main checkout has `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (the gear icon preview), each face as SVG and PNG, `make_faces.py`, which re-renders them, and `make_sheet.py`, which lays out the sheet. Known limits: the name is in Rubik Bold, the closest 1970s-like round face installed (no Cooper / ITC-style fonts on this machine); the paper logo's text is small, the sun carries it.

### Translations that need a native speaker
- **German (pack art and slogan):** *Für die Stunde nach der Arbeit.*, the warning text, *Seit 1952 für den Feierabend.*, *Hergestellt in der BRD*, *MILD · AROMATISCH*. Likely fine, but unchecked by a native speaker.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`. Japanese uses ファイアーアーベント for the name. Korean, Japanese and Chinese should get a look from a native speaker. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke, and that a flavour line shows up after lighting.

Also checked: `hemtt build` builds `cigs_feierabend.pbo`; the derapified config has `cigs_feierabend_cigpack` with `count = 20`, `cigs_item_glasses = "cigs_feierabend_cig0"` and `cigs_item_hmd = "cigs_feierabend_cig0_nv"`, and both classes exist; `mlod.py` reads the pack model and its paths point at `feierabend`/`base`; no `voron` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
