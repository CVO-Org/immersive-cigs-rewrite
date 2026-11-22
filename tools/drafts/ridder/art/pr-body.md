<!-- title: Brand - New: Ridder cigarettes (Denmark) -->
Label: pr/new

## What and why

Adds **Ridder** ("knight"), a fictional Danish filter cigarette of the 1970s-80s, for Global Mobilization's Danish side (`gm_fc_dk`, plus Danish civilians if GM has a faction for them). It's meant to replace the NIL filler in that faction preset. This PR doesn't map it to any faction; that comes with the GM faction preset (#320).

Closes #313

## Changes
- New addon `addons/ridder`, copied from `voron` (filter template). Classnames `cigs_ridder_cigpack`, `cigs_ridder_cig0` … `cig4`, `cigs_ridder_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, default smoke colour.
- `cigs_flavor[]` on `cig0` / `cig0_nv` (macro `FLAVOR_RIDDER` in `defines.hpp`): *smørrebrød*, *pickled herring*, *a cold beer in Nyhavn*, *the ferry to Bornholm*, *the wind off the North Sea*. Plain English strings like the other brands, since they are formatted into "Hmm, it tastes like %1!" unlocalised. *smørrebrød* keeps its ø; the built config has it as UTF-8, but please check it shows right in game.
- Pack model's texture path renamed to `addons\ridder\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90`, filter from a picture: white with two thin gold rings at the joint), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *En ægte dansk cigaret.* ("A genuine Danish cigarette.") stays Danish in every language, like Matelot's French and Feierabend's German slogans.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_ridder_author` (copied from `matelot`). **The owner may change it.**
- License: CC BY 4.0 (`addons/ridder/license.md`, copied from `voron`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_ridder_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
*Ridder* is Danish for "knight". The big Danish brands of the era had aristocratic, English-sounding names (Prince, Cecil, King's); a knight keeps that "noble" register one step below royalty, so the pack needs no crown and can't be mistaken for Prince. It's also a plain Danish word, easy to read for non-Danes, and it gives the pack an easy mark: a knight's great helm. A web search found no cigarette brand called Ridder; the word is generic, no trademark or logo is copied. Not fully ruled out: small Dutch/Belgian tobacco products with "Ridder" in the name (Dutch uses the same word).

Alternatives, if the owner prefers another:
- **Greve** ("count"): the same noble idea, a bit more old-money.
- **Kammerjunker** (a Danish court title, and a Danish biscuit): funnier, but long for the pack front.
- **Havørn** ("sea eagle"): shows off the ø, nature instead of nobility.

### Filter or filterless
**With filter, plain white tip with gold rings.** By the 1970s-80s the Danish mainstream was the king-size filter cigarette: Prince (launched 1957) and King's, the big names of the time, were filter brands, and plain cigarettes were the old-smoker minority. I went with a white tip instead of cork, which suits the clean Scandinavian look of the pack and keeps it apart from Feierabend's cork tip; the two thin gold rings at the joint make the filter readable in the icons and tie it to the pack's gold. Easy to switch to cork (`--filter "#c4874a"`) if the owner prefers.

### Artwork: first pass for the owner's review

There was no artist art. The faces and the paper logo are a **first pass** drawn as SVG in a Danish 1970s modernist style (off-white card, cobalt blue, brass gold, one thin red rule, a geometric sans for the name), with a light print grain and worn edges. Rendered with headless Edge, then composed. It's deliberately different from Feierabend (brown/orange/mustard, setting sun) and Brigade (cream/green), and from Matelot (navy with marinière stripes): Ridder is a white pack with a blue foot block, no stripes.

- Front: *FILTER CIGARETTER*, the gold great helm with a red plume in a blue ring, **RIDDER**, the slogan in italic, *MILD · FYLDIG · KØLIG* ("mild, full-bodied, cool"), *20 CIGARETTER*, *KØBENHAVN*.
- Back: RIDDER, slogan, and a warning box in the style of the era: *Sundhedsstyrelsen advarer: Rygning skader helbredet.* plus a nicotine/tar line *(gennemsnitlige værdier)*; *FREMSTILLET I DANMARK*, batch code (*PARTI 0784*) and a made-up EAN with the Danish 57 prefix.
- Left: maker line *A/S Brødrene Holm Tobaksfabrik · København · Fremstillet i Danmark* (fictional company), *Siden 1921 · På ære og tro* ("since 1921 · on my honour").
- Right: RIDDER, *20 FILTER CIGARETTER*, small helm.
- Top: RIDDER and the helm on blue, and a red *TOBAKSAFGIFT · KR. 18,50 · 20 STK.* tax stamp over the lid.
- Bottom: RIDDER and the batch code.
- Paper: the helm above *RIDDER*, stacked along the cigarette, turned with `--paper-logo-rotate -90` so its top points at the filter. It sits at u 330-389 next to the filter and stays whole through `cig3` (see the icon preview).
- Danish letters (æ, ø, å) render correctly in Segoe UI, Georgia and Montserrat; checked in the PNGs.

Where to look (local, not in the repo): `brand-drafts/ridder-art/` in the main checkout has `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (the gear icon preview), each face as SVG and PNG, `make_faces.py`, which re-renders them, `make_sheet.py`, which lays out the sheet, and `make_filter.py`, which makes the ringed filter picture. Known limits: the name is in Montserrat Bold, the closest geometric sans installed; the helm is simple and the paper logo's text is small, the helm carries it. The `cig0` icon shows the paper side without the logo, as with the other brands.

### Translations that need a native speaker
- **Danish (pack art and slogan):** *En ægte dansk cigaret.*, the warning text (made in the style of the period, not a quote of the real wording), *MILD · FYLDIG · KØLIG*, *Siden 1921 · På ære og tro*, *TOBAKSAFGIFT*, *gennemsnitlige værdier*. These are the ones to check first.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`. Japanese uses リダー for the name. Korean, Japanese and Chinese should get a look from a native speaker. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke, and that a flavour line (including *smørrebrød*) shows up after lighting.

Also checked: `hemtt build` builds `cigs_ridder.pbo`; the derapified config has `cigs_ridder_cigpack` with `count = 20`, `cigs_item_glasses = "cigs_ridder_cig0"` and `cigs_item_hmd = "cigs_ridder_cig0_nv"`, and both classes exist; `mlod.py` reads the pack model and its paths point at `ridder`/`base`; no `voron` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
