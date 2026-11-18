# Cigar textures

A cigar brand has two textures: the cigar (`data/cigars/cigar_co.paa`) and the box (`data/cigarbox_5/cigarbox_5_co.paa`). Both are 1024 x 1024. To see them with the UVs drawn on:

```powershell
python tools/gear_icons/cigar_icons.py layout <brand> --out .hemttout/llm/<brand>
```

It writes `cigar_layout.png` and `box_layout.png`. Read both images before you paint anything.

## The cigar (`data/cigars/cigar_co.paa`)

The shared models `addons/base/data/cigar0..4.p3d` map it like this (texture pixels, u to the right, v down):

| Part | u | v | Notes |
| --- | --- | --- | --- |
| wrapper (the cigar's side) | 3-1019 | 602-1023 | u runs along the cigar: foot (burning end) at u 3, mouth at u 1019, about 10 px per mm. v goes once round it (about 13 mm across). |
| head (mouth end cap) | 143-269 | 463-589 | wrapper leaf, seen end-on |
| foot, unlit (`cigar0`) | 4-215 | 209-420 | the cut tobacco |
| foot, ash (`cigar1`-`cigar4`) | 0-138 | 447-584 | grey ash |
| ember (lit tip, `CamoB`) | 312-768 | 77-532 | glows; uses `cigar_lit.rvmat` |

How much of the wrapper each stage shows: `cigar0`/`cigar1` u 3-1019 (103 mm), `cigar2` u 189-1019 (86 mm), `cigar3` u 394-1019 (66 mm), `cigar4` u 599-1019 (48 mm). The cigar burns from the foot, so **put the band and its print at u 645 or higher**, or the last stage loses them. Papa Schultz' band is at u 740-790 with its medallion at v 820.

About 210 px of v face the viewer. A band print up to 130 px fits; the icon script turns the cigar so the print faces you.

### Building it

`tools/gear_icons/texture_compose.py cigar` starts from `addons/papa_schultz/data/cigars/cigar_co.png` with the band and medallion removed (wrapper copied over u 695-835):

| Option | Takes |
| --- | --- |
| `--wrapper` | `#rrggbb` to tint the wrapper and the head, keeping the leaf's grain; or a picture for the whole wrapper (1024 x 434) |
| `--band` | `#rrggbb` for a plain band with light edges, or a picture (50 x 434) |
| `--band-print` | a PNG with transparency, fitted into 130 x 130 on the band |
| `--band-u`, `--print-v` | where the band's centre (default u 765) and the print's centre (default v 820) go |
| `--base`, `--clean-band` | start from another cigar texture; `--clean-band` removes a band at u 695-835 from it too |
| `--out`, `--paa` | the PNG, and the PAA (`addons/<brand>/data/cigars/cigar_co.paa`) |

Several bands (a second, thinner one near the foot, say) are made by running it again with `--base` set to the first result and another `--band-u`; give the first result's PNG as `--base`.

Typical wrapper colours: claro `#a87444`, colorado `#8a5a32`, maduro `#4a2c1a`, oscuro `#2e1c12`.

## The box (`data/cigarbox_5/cigarbox_5_co.paa`)

The box model is per addon and detailed: an open lid, the cigars inside (they use the brand's `cigar_co.paa`), edges with their own small faces. `box_layout.png` colours its faces by the way they face. In Papa Schultz' texture:

| Face | Biggest area (u0, v0, u1, v1) |
| --- | --- |
| front | 10, 440, 368, 1014 |
| back | 388, 300, 753, 920 (the panel with the description text) |
| right side | 903, 300, 1014, 920 |
| left side | 773, 300, 883, 920 |
| lid, inside and outside | top left, u 10-368, v 60-418, and u 388-753, v 85-181 |

The front is the face in the inventory icon; put the brand name big on it. Above the back panel, u 388-753, v 190-300 is the lid's outside: it is upside down in the texture and on the open box, so it reads the right way when the lid is closed. The strip below the back and the sides (v 920-1014: barcode, tax stamp) wraps round the box's lower edge.

There is no builder for the box. Edit `data/cigarbox_5/Cigarbox_5_co.png` with Pillow: paste each picture into its face's area (scaled to fill, cropped at the edges), keep the edges and the parts you have nothing for, and look at the result next to `box_layout.png`. Then convert it with `hemtt utils paa convert` (delete the old PAA first; hemtt won't overwrite).

## Checking on the model

```powershell
python tools/gear_icons/cigar_icons.py all <brand> --out .hemttout/icons/<brand>
```

The icons are rendered from the models with your textures, so they are the quickest check: a band in the wrong place, a box face upside down or a print mirrored shows up there. Mirrored text means the picture went in the wrong way round; flip it in the texture, not in the icon.
