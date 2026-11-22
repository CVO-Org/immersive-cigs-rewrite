<!-- title: Brand - New: Laterne cigarettes (Germany, WW2) -->
## What and why

Adds **Laterne** ("street lantern"), a fictional German filterless cigarette of the 1940s, as the second WW2 German brand next to Eckstein. It's meant for Spearhead 1944's German factions (`SPE_WEHRMACHT`, `SPE_STURM`), where it replaces the NIL filler in the faction preset. This PR doesn't map it to any faction; that comes with the Spearhead faction preset (#320).

Closes #319

## Changes
- New addon `addons/laterne`, copied from `matelot` (filterless template). Classnames `cigs_laterne_cigpack`, `cigs_laterne_cig0` … `cig4`, `cigs_laterne_cig0_nv` … `cig4_nv`.
- 20 cigarettes per pack, `TOTALPUFFS` 17, smoke slightly darker than default (`0.24, 0.23, 0.21`), like the other plain-tobacco brands.
- `cigs_flavor[]` on `cig0` / `cig0_nv` (macro `FLAVOR_LATERNE` in `defines.hpp`): *Orient tobacco*, *a lamplit street*, *a cold railway platform*, *Kommissbrot*, *a letter from home*. Plain English strings, since they are formatted into "Hmm, it tastes like %1!" unlocalised.
- Pack model's texture path renamed to `addons\laterne\` with `mlod.py`; the material stays `addons\base\`.
- New `data/texture.paa` built with `texture_compose.py` (`--paper-logo-rotate -90 --paper-logo-u 300`), and the six gear icons rendered with `gear_icons.py --logo-v 127`.
- `stringtable.xml`: name, pack name and description in all ten languages of the template. The slogan *Mild wie Laternenlicht.* ("Mild as lamplight.") stays German in every language, like Matelot's French slogan.
- Author credit: `OverlordZorn [CVO]` in `authors[]`, `OverlordZorn` in `STR_cigs_laterne_author` (copied from `matelot`). **The owner may change it.**
- License: CC BY 4.0 (`addons/laterne/license.md`, copied from `matelot`), listed in the root `license.md`.
- `docs/classnames.md` lists `cigs_laterne_cigpack`.
- No changes to `addons/base`, `addons/core`, `addons/main`, the AI or the faction presets.

### Name
*Laterne* is the everyday German word for a street lamp. It has no political baggage, it gives the pack an easy mark (a gas lantern with its light), and it carries the era's mood without any symbol of the regime: the lamp of "Lili Marleen" (1939), a song soldiers on both sides sang. A web search found no cigarette brand called Laterne; the word is generic, no trademark or logo is copied. Inspiration from the issue (Juno, R6, Overstolz, ration cigarettes) went into the style, not the name: the plain "Orient blend" wording, the price per cigarette on the pack, a simple maker line.

Alternatives, if the owner prefers another:
- **Mondschein** ("moonlight"): the same night-blue look, a crescent instead of the lamp.
- **Kompass** ("compass"): short and sturdy like R6 / Juno, a compass rose as the mark.
- **Abendstern** ("evening star"): softer, more of a 1930s luxury brand.

### Filter or filterless
**Filterless.** German cigarettes of the 1940s were almost all without filter (Juno, R6, Overstolz and the ration cigarettes alike); the pack says so in the period wording *ohne Mundstück* ("without mouthpiece"). Real ones were often oval; the shared model is round, so that isn't shown. The paper logo sits away from the mouth end (u 273-327), like Matelot, Lucky Strike and Craven.

### How it differs from Eckstein
Eckstein is a bright green pack with a crest and a big "5". Laterne is night blue with gilt rules, a glowing amber lantern and cream foot band; the name is in hand-drawn Art Deco capitals rather than a sans. The paper logo is a small blue-and-amber lantern above LATERNE, Eckstein's is gold.

### What's deliberately not on the pack
No eagle, no swastika, no runes, no Wehrmacht or state emblem, no period slogan, no "Reich" wording (§86a StGB, and it ships on Steam). The German tax band of the time carried the state eagle; here the lid's tax band is a plain guilloche strip with *TABAKSTEUER · 80 Pf. · 20 Stück* only. There is no health warning either, which matches packs of the time and avoids the regime's own anti-smoking slogans. The maker, *Cigarettenfabrik C. W. Lindner, Dresden, gegr. 1898*, is fictional (Dresden was Germany's cigarette city).

### Artwork: first pass for the owner's review

There was no artist art. The faces and the paper logo are a **first pass** drawn as SVG (night-blue card with a gilt double rule and stepped Art Deco corners, amber lantern with a sunburst of rays, cream foot band), with a light print grain and worn edges. Rendered with headless Edge, then composed.

- Front: *ORIENT-MISCHUNG*, the lantern, **LATERNE**, *Mild wie Laternenlicht.*, foot band *20 CIGARETTEN* / *OHNE MUNDSTÜCK · 4 Pf. das Stück*.
- Back: smaller lantern, LATERNE, slogan, a short blurb (*Feinste Orient-Tabake, sorgfältig gemischt und gelagert, für die stille Stunde am Abend und die lange Fahrt.*), foot band with the maker.
- Left: *C. W. LINDNER · DRESDEN*, *FEINSTE ORIENT-TABAKE*, slogan; small lantern in the foot band.
- Right: LATERNE, *20 CIGARETTEN*; small lantern in the foot band.
- Top: lantern and LATERNE, with the plain tax band running over the lid.
- Bottom: LATERNE and *Nr. 4417 · 20 CIGARETTEN · DRESDEN*.
- Paper: a small lantern above LATERNE, stacked along the cigarette, turned with `--paper-logo-rotate -90` so its top points at the mouth end, centred on u 300. It stays whole through `cig3` (see the icon preview).
- German umlauts (Ü, ä, ü) render correctly; checked in the PNGs.

Where to look (local, not in the repo): `brand-drafts/laterne-art/` in the main checkout has `faces-sheet.png` (all faces), `texture.png` (the composed texture), `icons-preview.png` (the gear icon preview), each face as SVG and PNG, `make_faces.py`, which re-renders them, and `make_sheet.py`, which lays out the sheet. Known limits: no Fraktur or Art Deco font on this machine, so the name is drawn as geometric shapes in the script and the small text is Bahnschrift (DIN-like, which fits the period) and Lora italic; the lantern is simple.

### Translations that need a native speaker
- **German (pack art and slogan):** *Mild wie Laternenlicht.*, *ohne Mundstück*, *4 Pf. das Stück*, the back blurb. Likely fine, but unchecked by a native speaker.
- **Stringtable:** the "Contains 20" and "Warning" parts are copied from `matelot`. Japanese uses ラテルネ for the name. Korean, Japanese and Chinese should get a look from a native speaker. The Chinese warning keeps the existing joke text of the other brands.

## Testing
- [x] `hemtt check` passes (no errors or warnings)
- [ ] Tested in game (`hemtt launch`) - SP / MP / dedicated: **Not tested in game, I can't run the game.** Please check: the pack on the ground and in the inventory, taking a cigarette out, lighting it, all five stages, the smoke, and that a flavour line shows up after lighting.

Also checked: `hemtt build` builds `cigs_laterne.pbo`; the derapified config has `cigs_laterne_cigpack` with `count = 20`, `cigs_item_glasses = "cigs_laterne_cig0"` and `cigs_item_hmd = "cigs_laterne_cig0_nv"`, and both classes exist; `mlod.py` reads the pack model and its paths point at `laterne`/`base`; no `matelot` left in the folder; every `picture =` has its PAA; the icon preview shows the pack the right way up and readable at 64 px.

🤖 Generated with [Claude Code](https://claude.com/claude-code)
