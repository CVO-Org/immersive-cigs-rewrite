"""Brigade pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Brigade brand (East Germany, 1970s-80s, first pass, plain VEB product look).
Run:  python make_faces.py          -> writes <face>.svg / <face>.png next to this file, and faces-sheet.png
      python make_faces.py sheet    -> only rebuilds faces-sheet.png
"""
import pathlib, subprocess, sys, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

CREAM, GREEN, RED, INK = "#ebe2c8", "#2c4a3a", "#b02a2a", "#221f1b"
SANS = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
COND = "'Bahnschrift SemiBold Condensed', 'Bahnschrift Condensed', Bahnschrift, 'Arial Narrow', sans-serif"
SERIF = "Georgia, serif"

# Rough print: grain over the whole face, a few blotches and slightly worn edges.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.035" numOctaves="3" seed="5" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 1  0 0 0 0 1  0 0 0 0 1  0 0 0 0.9 -0.42" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="70%" stop-color="#000" stop-opacity="0"/>
  <stop offset="100%" stop-color="#000" stop-opacity="0.25"/>
</radialGradient>
<g id="roundel">
  <circle r="60" fill="{RED}"/>
  <circle r="52" fill="none" stroke="{CREAM}" stroke-width="3"/>
  <path d="M-38 30 H38" stroke="{CREAM}" stroke-width="3"/>
  <path d="M-38 36 H38" stroke="{CREAM}" stroke-width="1.5"/>
  <text x="0" y="22" font-family="{SANS}" font-weight="700" font-size="74" fill="{CREAM}" text-anchor="middle">B</text>
</g>
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def name_band(w, y, h=96, size=86, length=322):
    return f"""
<rect x="0" y="{y - 6}" width="{w}" height="3" fill="{RED}"/>
<rect x="0" y="{y}" width="{w}" height="{h}" fill="{GREEN}"/>
<rect x="0" y="{y + h + 3}" width="{w}" height="3" fill="{RED}"/>
<text x="{w/2}" y="{y + h/2 + size*0.36}" font-family="{COND}" font-weight="700" font-size="{size}" fill="{CREAM}"
      text-anchor="middle" textLength="{length}" lengthAdjust="spacingAndGlyphs">BRIGADE</text>"""


def evp_band(w, y, h):
    return f"""
<rect x="0" y="{y}" width="{w}" height="{h}" fill="{GREEN}"/>
<text x="{w/2}" y="{y + h/2 + 8}" font-family="{SANS}" font-weight="600" font-size="22" fill="{CREAM}"
      text-anchor="middle" letter-spacing="2">EVP 3,20 M</text>"""


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect width="{w}" height="14" fill="{GREEN}"/>
<text x="{w/2}" y="46" font-family="{SANS}" font-weight="600" font-size="14" fill="{INK}" text-anchor="middle"
      letter-spacing="3">VEB TABAKWERK ELBAUE</text>
<use href="#roundel" x="{w/2}" y="138"/>
{name_band(w, 228)}
<text x="{w/2}" y="382" font-family="{SERIF}" font-style="italic" font-size="22" fill="{INK}" text-anchor="middle">Für die Frühschicht.</text>
<rect x="88" y="414" width="185" height="34" fill="{RED}"/>
<text x="{w/2}" y="439" font-family="{SANS}" font-weight="700" font-size="21" fill="{CREAM}" text-anchor="middle"
      letter-spacing="6">FILTER</text>
<text x="{w/2}" y="482" font-family="{SANS}" font-weight="600" font-size="16" fill="{INK}" text-anchor="middle"
      letter-spacing="3">20 ZIGARETTEN</text>
{evp_band(w, 508, 56)}
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect width="{w}" height="14" fill="{GREEN}"/>
<use href="#roundel" transform="translate({w/2} 88) scale(0.62)"/>
{name_band(w, 150, h=80, size=72, length=300)}
<g font-family="{SERIF}" font-size="17" fill="{INK}" text-anchor="middle">
  <text x="{w/2}" y="292" font-style="italic" font-size="20">Für die Frühschicht.</text>
  <text x="{w/2}" y="336">Eine milde Mischung</text>
  <text x="{w/2}" y="358">ausgesuchter Tabake</text>
  <text x="{w/2}" y="380">mit Filter.</text>
</g>
<rect x="60" y="404" width="241" height="1.5" fill="{INK}"/>
<g font-family="{SANS}" font-size="13" fill="{INK}" text-anchor="middle" letter-spacing="1">
  <text x="{w/2}" y="430">VEB TABAKWERK ELBAUE</text>
  <text x="{w/2}" y="450">BETRIEB IM KOMBINAT TABAK</text>
  <text x="{w/2}" y="476" font-size="11">TGL 22813 · Gütekl. I</text>
</g>
{evp_band(w, 508, 56)}
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect width="{w}" height="14" fill="{GREEN}"/>
<rect x="0" y="508" width="{w}" height="56" fill="{GREEN}"/>
<use href="#roundel" transform="translate({w/2} 80) scale(0.6)"/>
<g transform="translate({w/2} 300) rotate(90)" text-anchor="middle">
  <text x="0" y="-12" font-family="{SANS}" font-weight="700" font-size="22" fill="{RED}" letter-spacing="4">20 ZIGARETTEN</text>
  <text x="0" y="22" font-family="{SANS}" font-weight="600" font-size="17" fill="{INK}" letter-spacing="3">MIT FILTER</text>
</g>
<text x="{w/2}" y="545" font-family="{SANS}" font-weight="600" font-size="16" fill="{CREAM}" text-anchor="middle">3,20 M</text>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect width="{w}" height="14" fill="{GREEN}"/>
<rect x="0" y="508" width="{w}" height="56" fill="{GREEN}"/>
<rect x="30" y="40" width="64" height="440" fill="{GREEN}"/>
<g transform="translate(62 260) rotate(-90)" text-anchor="middle">
  <text x="0" y="19" font-family="{COND}" font-weight="700" font-size="56" fill="{CREAM}"
        textLength="380" lengthAdjust="spacingAndGlyphs">BRIGADE</text>
</g>
<g transform="translate(116 260) rotate(-90)" text-anchor="middle" font-family="{SANS}" fill="{INK}">
  <text x="0" y="0" font-size="12" letter-spacing="1.5">VEB TABAKWERK ELBAUE · DRESDEN</text>
  <text x="0" y="17" font-size="10" letter-spacing="1">Ag 08/84 · Nr. 1173</text>
</g>
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="10" fill="{GREEN}"/>
<rect x="0" y="141" width="{w}" height="10" fill="{GREEN}"/>
<use href="#roundel" transform="translate(72 76) scale(0.72)"/>
<text x="232" y="94" font-family="{COND}" font-weight="700" font-size="56" fill="{GREEN}" text-anchor="middle"
      textLength="200" lengthAdjust="spacingAndGlyphs">BRIGADE</text>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="10" fill="{GREEN}"/>
<rect x="0" y="141" width="{w}" height="10" fill="{GREEN}"/>
<g font-family="{SANS}" fill="{INK}" text-anchor="middle">
  <text x="{w/2}" y="66" font-size="15" letter-spacing="2">EVP 3,20 M · 20 STÜCK</text>
  <text x="{w/2}" y="96" font-size="12" letter-spacing="1">Ag 08/84 · Nr. 1173 · TGL 22813</text>
</g>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # roundel above BRIGADE. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the filter and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#roundel" transform="translate(36 17) scale(0.25)"/>
<text x="36" y="49" font-family="{COND}" font-weight="700" font-size="17" fill="{GREEN}" text-anchor="middle"
      textLength="64" lengthAdjust="spacingAndGlyphs">BRIGADE</text>
""", finish_it=False, scale=4)


FACES = {"front": front, "back": back, "right": right, "left": left, "top": top, "bottom": bottom, "logo": logo}


def render(name, markup):
    svg_path = HERE / f"{name}.svg"
    svg_path.write_text(markup, encoding="utf-8")
    w = int(markup.split('width="')[1].split('"')[0])
    h = int(markup.split('height="')[1].split('"')[0])
    html = HERE / f"_{name}.html"
    html.write_text(f'<!doctype html><html><head><meta charset="utf-8"><style>html,body{{margin:0;padding:0;background:transparent;overflow:hidden}}svg{{display:block}}</style></head><body>{markup}</body></html>', encoding="utf-8")
    png = HERE / f"{name}.png"
    png.unlink(missing_ok=True)
    # A profile of its own, or a running Edge swallows the call and nothing is written.
    subprocess.run([EDGE, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
                    f"--user-data-dir={HERE / '_edgeprofile_brigade'}",
                    "--default-background-color=00000000", f"--window-size={w},{h}", f"--screenshot={png}", html.as_uri()],
                   check=True, capture_output=True)
    # Edge hands the work to a child process and returns before the PNG is written.
    for _ in range(150):
        if png.exists() and png.stat().st_size > 0:
            break
        time.sleep(0.2)
    time.sleep(0.5)
    html.unlink()
    print("wrote", png.name, w, "x", h)


def sheet():
    from PIL import Image
    names = ["back", "left", "front", "right", "top", "bottom", "logo"]
    ims = [Image.open(HERE / f"{n}.png").convert("RGBA") for n in names]
    W = sum(i.width for i in ims) + 20 * (len(ims) + 1)
    H = max(i.height for i in ims) + 40
    out = Image.new("RGBA", (W, H), (90, 90, 90, 255))
    x = 20
    for im in ims:
        out.alpha_composite(im, (x, 20))
        x += im.width + 20
    out.save(HERE / "faces-sheet.png")
    print("wrote faces-sheet.png")


if __name__ == "__main__":
    args = sys.argv[1:]
    if args != ["sheet"]:
        for n in (args or FACES):
            render(n, FACES[n]())
    sheet()
