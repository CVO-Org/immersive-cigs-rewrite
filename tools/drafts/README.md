# Brand drafts

Unused brand drafts, kept for later use. These are the invented brands from the night run of 2026-11-19. They were replaced by the real historical brands (PRs #322-#333), but each one is complete and could ship as an extra brand.

Each folder has:
- `addon/`: the finished addon (config, stringtable, `data/texture.paa`, gear icons, model). It passed `hemtt check` and `hemtt build` on `origin/main` at d311149. Not tested in game.
- `art/`: the review art. It has the face SVGs and PNGs, `faces-sheet.png`, `texture.png`, `icons-preview.png`, the `make_faces.py` script that re-renders them, and the prepared `commitmsg.txt` and `pr-body.md`.

To use one, copy `addon/` to `addons/<name>/`. Then add a line to `docs/classnames.md` and the root `license.md` (the drafts list themselves under CC BY 4.0), and run `hemtt check`.

| Draft | Look | Filter | Issue it was built for |
|---|---|---|---|
| `cocarde` | Cocarde: French army tobacco, tricolour cockade | filterless | #317 France |
| `bong_sen` | Bông Sen: Vietnamese lotus, cream | filterless | #310 Vietnam |
| `jiskra` | Jiskra: Czechoslovak "spark" | filter | #314 ČSSR |
| `brigade` | Brigade: East German state factory, cream and green | filter (cork) | #311 GDR |
| `feierabend` | Feierabend: West German 70s, brown and orange, sunset | filter (cork) | #311 FRG |
| `hejnal` | Hejnał: Polish PRL, red and black, bugle | filterless | #312 Poland |
| `chergui` | Chergui: North African east wind, brick and sand, French and Arabic | filterless | #315 Western Sahara |
| `ridder` | Ridder: Danish knight's helmet, white, cobalt and gold | filter (white) | #313 Denmark |
| `maengho` | Maengho: South Korean army "fierce tiger", olive | filterless | #318 ROK |
| `laterne` | Laterne: German 1940s Art Deco, night blue, gas lantern | filterless | #319 WW2 Germany |
| `addax` | Addax: American blend, Saharan antelope, ivory, teal and copper | filter | #316 International |
| `stockton` | Stockton: American full flavour, navy, red diamond and star | filter | #316 International |

The flavour lines are plain English strings, because the core shows `$STR_` keys raw.
