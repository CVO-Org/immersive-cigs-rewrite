# The cigarette brand texture

One 1024 x 1024 texture, `addons/<brand>/data/texture.paa`, covers the pack (`data/cigpack.p3d`) and the cigarettes (`addons/base/data/cig*.p3d`). Every brand uses the same UVs, so the layout below is fixed. All numbers are texture pixels, u to the right, v down.

To see it: `python tools/gear_icons/texture_compose.py guide --over-base --out .hemttout/llm/guide.png`, then read the image. `addons/voron/data/texture.paa` is a good finished example (convert it with `hemtt utils paa convert <paa> <png>` to look at it).

## Pack faces

| Face | u0, v0, u1, v1 | Size | Up in the texture |
| --- | --- | --- | --- |
| front | 512, 451, 873, 1015 | 361 x 564 | pack top |
| right side | 873, 451, 1024, 1015 | 151 x 564 | pack top |
| top flap | 512, 300, 873, 451 | 361 x 151 | back edge; its lower edge meets the front |
| back | 0, 300, 361, 864 | 361 x 564 | pack top |
| left side | 361, 300, 512, 864 | 151 x 564 | pack top |
| bottom | 0, 864, 361, 1015 | 361 x 151 | back edge; it hangs below the back, so upright art is turned 180° |

The faces wrap round the pack in the order back, left, front, right, and back's left edge meets right's right edge. Text on the narrow sides usually runs along them: top to bottom on the right side, bottom to top on the left. The rest of the pack area (v 290-1024) is unused.

The inventory icon shows the front, the right side and the top flap. Put the brand name big on the front; at 64 px it must still be readable.

## Cigarette strip (top of the texture)

| Part | u | v |
| --- | --- | --- |
| charred paper edge (burnt end) | 0-10 | 41-217 |
| paper | 10-389 | 41-217 |
| logo spot on the paper, next to the filter | 330-389 | centred on 127 |
| logo spot on a filterless cigarette, a bit away from the mouth end | 273-327 | centred on 127 |
| filter: white band, ring, cork | 391-431, 431-437, 437-591 | 41-217 |
| tobacco end (filterless mouth end) | 722-788 | 85-155 |
| ash, glow | 836-1010 | 60-200 |

- u runs along the cigarette: burnt end on the left, mouth on the right, 6.57 px per mm. v runs round it: 47-207 go once round (7.6 mm), and only about 78 px of that face the viewer.
- The burn stages keep the paper next to the filter and lose paper from the left. So a logo at u 330-389 stays visible until the stub; anything further left burns away.
- A logo taller than about 70 px wraps round the back. Keep it small, or accept that only part of it shows (`gear_icons.py` warns).
- **The logo reads from the front of the cigarette:** its top points towards the filter (towards the mouth end on a filterless cigarette), not up or down the strip. In the strip, text then reads top to bottom. If there is text and a mark, stack them along the cigarette, the mark nearer the filter, both pointing the same way. Most brands do this already (Morley, Lucky Strike, Craven, Kosmos, Apollo, NIL). The exception is a design printed over the whole paper (Black Devil), whose name may run along the cigarette.
- **Filterless cigarettes:** keep the logo a bit away from the mouth end, centred on u 300 (u 273-327, about 9-18 mm from the end), as Lucky Strike and Craven do. The paper there survives up to `cig3` (u 225-389); the last stub `cig4` keeps u 303-389 and cuts the logo.
- Leave the tobacco end and the ash as they are.

## From artwork to texture.paa

`tools/gear_icons/texture_compose.py compose` does the placing:

| Option | Takes |
| --- | --- |
| `--front --back --top --left --right --bottom` | a picture per face, upright as described above. It is scaled to fill the face and cropped at the edges, so match the face's aspect ratio. A landscape picture for a side is turned for you. |
| `--pack-colour #rrggbb` | the card colour behind faces you leave out |
| `--paper-logo` | a PNG with transparency, fitted into 54 x 72 px at the logo spot. Draw it upright, with text and mark stacked, and pass `--paper-logo-rotate -90`: that turns its top towards the filter. `90` would turn it towards the burnt end. Add `--paper-logo-u 300` for a filterless cigarette. |
| `--paper #rrggbb` | tints the paper and the filter's white band, keeping the paper grain |
| `--filter` | `#rrggbb` tints the cork, `white` makes a plain white filter, a picture replaces u 391-591 (rows 41-217, so 200 x 176 px) |

**Rings on the tipping** (a coloured line where the cork meets the paper, as on Jaffudi or Sharig): compose once with the cork tint, crop u 391-591 x v 41-217 from the PNG, paint the rings into that crop with Pillow (x 40-45 of the crop is the ring at u 431-437), and compose again with the crop as `--filter <picture>` and `--paa`. The PAA then still comes from the script.
| `--out`, `--paa` | the PNG to write, and the PAA (`addons/<brand>/data/texture.paa`) |

It starts from a clean copy of `addons/base/data/texture.paa` with every print removed, so the paper grain, the cork, the tobacco end and the ash are always right.

### When the user has artwork

Cut it into one picture per face with Pillow, matching the sizes above, and pass them in. If they have one picture of a whole pack, use it as the front, and make the other faces from its colours and its logo.

### When the user has none

Ask for it. If they want a placeholder, make the faces with Pillow (a solid colour, the brand name in a large font, a thin border) and say clearly that it is a placeholder. An image-generation tool, if you have one, can make the front; ask it for a flat, straight-on print of a cigarette pack front at 361 x 564, with no perspective and no shadows.

### Editing an existing texture instead

When the user hands you a finished `texture.png` (for example made in the Photoshop template in `tools/PSD UI Automations/`), don't compose: check it against the layout above, then convert it:

```powershell
hemtt utils paa convert addons/<brand>/data/texture.png addons/<brand>/data/texture.paa
```

`hemtt` won't overwrite an existing PAA; delete or rename the old one first. For small fixes on a PAA (a face upside down, a logo in the wrong spot), use `tools/gear_icons/texture_fix.py`.
