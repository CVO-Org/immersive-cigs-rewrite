"""Cocarde pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Cocarde brand (first pass): a French WW2 "tabac de troupe" ration pack,
kraft card printed in two inks (navy and red) with the tricolour cockade.
Run:  python make_faces.py   -> writes <face>.svg / <face>.png and faces-sheet.png next to this file.
"""
import pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

KRAFT, NAVY, NAVY_D, RED, WHITE, BLUE = "#e2d3a8", "#1f2d57", "#141d3b", "#b3262c", "#f1ead6", "#27408b"
COND = "'Bahnschrift Condensed', 'Arial Narrow', Bahnschrift, Arial, sans-serif"
SANS = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
SERIF = "Georgia, serif"
MONO = "Consolas, monospace"

# Rough print: grain over the whole face, blotchy ink, slightly worn edges.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="5" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.35  0 0 0 0 0.25  0 0 0 0 0.1  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="68%" stop-color="#3a2a10" stop-opacity="0"/>
  <stop offset="100%" stop-color="#3a2a10" stop-opacity="0.30"/>
</radialGradient>
<g id="cockade">
  <circle r="50" fill="{BLUE}"/>
  <circle r="33" fill="{WHITE}"/>
  <circle r="17" fill="{RED}"/>
  <circle r="50" fill="none" stroke="{NAVY_D}" stroke-width="1.5"/>
</g>
"""


def tricolour(x, y, w, h):
    t = w / 3
    return (f'<rect x="{x}" y="{y}" width="{t}" height="{h}" fill="{BLUE}"/>'
            f'<rect x="{x+t}" y="{y}" width="{t}" height="{h}" fill="{WHITE}"/>'
            f'<rect x="{x+2*t}" y="{y}" width="{t}" height="{h}" fill="{RED}"/>')


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.14"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{KRAFT}"/>
<rect x="0" y="0" width="{w}" height="58" fill="{NAVY}"/>
<text x="{w/2}" y="40" text-anchor="middle" font-family="{COND}" font-size="27" font-weight="bold" letter-spacing="5" fill="{KRAFT}">TABAC DE TROUPE</text>
{tricolour(0, 58, w, 10)}
<use href="#cockade" transform="translate({w/2},176) scale(1.62)"/>
<text x="{w/2}" y="348" text-anchor="middle" font-family="{COND}" font-size="86" font-weight="bold" fill="{NAVY}"
      textLength="326" lengthAdjust="spacingAndGlyphs">COCARDE</text>
<path d="M30 368 H{w-30}" stroke="{RED}" stroke-width="3"/>
<text x="{w/2}" y="398" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="21" fill="{NAVY}">Le tabac du soldat.</text>
<text x="{w/2}" y="436" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="3" fill="{NAVY}">TABAC NOIR · CAPORAL</text>
<g transform="translate({w/2},478) rotate(-4)">
  <rect x="-118" y="-19" width="236" height="34" fill="none" stroke="{RED}" stroke-width="3"/>
  <text x="0" y="7" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="3" fill="{RED}">RÉSERVÉ AUX ARMÉES</text>
</g>
<rect x="0" y="510" width="{w}" height="{h-510}" fill="{NAVY}"/>
<text x="{w/2}" y="544" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="2" fill="{KRAFT}">20 CIGARETTES · SANS FILTRE</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{KRAFT}"/>
<rect x="0" y="0" width="{w}" height="58" fill="{NAVY}"/>
<text x="{w/2}" y="42" text-anchor="middle" font-family="{COND}" font-size="34" font-weight="bold" letter-spacing="6" fill="{KRAFT}">COCARDE</text>
{tricolour(0, 58, w, 10)}
<text x="{w/2}" y="124" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="30" fill="{NAVY}">Le tabac du soldat.</text>
<rect x="28" y="160" width="305" height="250" fill="none" stroke="{NAVY}" stroke-width="2.5"/>
<text x="{w/2}" y="200" text-anchor="middle" font-family="{COND}" font-size="22" font-weight="bold" letter-spacing="2" fill="{NAVY}">TABAC DE TROUPE</text>
<path d="M90 214 H271" stroke="{RED}" stroke-width="2"/>
<text x="{w/2}" y="250" text-anchor="middle" font-family="{SANS}" font-size="17" fill="{NAVY}">Distribué gratuitement</text>
<text x="{w/2}" y="274" text-anchor="middle" font-family="{SANS}" font-size="17" fill="{NAVY}">aux militaires</text>
<text x="{w/2}" y="298" text-anchor="middle" font-family="{SANS}" font-size="17" fill="{NAVY}">des armées françaises.</text>
<text x="{w/2}" y="348" text-anchor="middle" font-family="{COND}" font-size="26" font-weight="bold" letter-spacing="3" fill="{RED}">VENTE INTERDITE</text>
<text x="{w/2}" y="386" text-anchor="middle" font-family="{SANS}" font-size="14" fill="{NAVY}">Tabac noir · coupe caporal</text>
<use href="#cockade" transform="translate({w/2},460) scale(0.5)"/>
<rect x="0" y="510" width="{w}" height="{h-510}" fill="{NAVY}"/>
<text x="{w/2}" y="542" text-anchor="middle" font-family="{SANS}" font-size="13" letter-spacing="2" fill="{KRAFT}">MANUFACTURE DES TABACS · PARIS</text>
""")


def right():
    # Text runs top to bottom (turned 90° clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{KRAFT}"/>
<rect x="0" y="0" width="{w}" height="58" fill="{NAVY}"/>
{tricolour(0, 58, w, 10)}
<g transform="translate({w/2},270) rotate(90)">
  <text x="0" y="-6" text-anchor="middle" font-family="{COND}" font-size="34" font-weight="bold" letter-spacing="4" fill="{NAVY}">COCARDE</text>
  <text x="0" y="26" text-anchor="middle" font-family="{COND}" font-size="17" font-weight="bold" letter-spacing="2" fill="{RED}">20 CIGARETTES SANS FILTRE</text>
</g>
<use href="#cockade" transform="translate({w/2},462) scale(0.6)"/>
<rect x="0" y="510" width="{w}" height="{h-510}" fill="{NAVY}"/>
""")


def left():
    # Text runs bottom to top (turned 90° anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{KRAFT}"/>
<rect x="0" y="0" width="{w}" height="58" fill="{NAVY}"/>
{tricolour(0, 58, w, 10)}
<g transform="translate({w/2},290) rotate(-90)">
  <text x="0" y="-26" text-anchor="middle" font-family="{SANS}" font-size="15" fill="{NAVY}">Manufacture des Tabacs · Paris</text>
  <text x="0" y="-2" text-anchor="middle" font-family="{SANS}" font-size="15" fill="{NAVY}">Tabac de troupe · Vente interdite</text>
  <text x="0" y="26" text-anchor="middle" font-family="{MONO}" font-size="15" fill="{RED}">LOT 44-112 · T.3</text>
</g>
<rect x="0" y="510" width="{w}" height="{h-510}" fill="{NAVY}"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{NAVY}"/>
<rect x="0" y="44" width="{w}" height="62" fill="{KRAFT}"/>
<path d="M0 46 H{w} M0 104 H{w}" stroke="{RED}" stroke-width="2" stroke-dasharray="6 4"/>
<use href="#cockade" transform="translate(40,75) scale(0.42)"/>
<text x="212" y="71" text-anchor="middle" font-family="{COND}" font-size="16" font-weight="bold" fill="{NAVY}" textLength="270" lengthAdjust="spacingAndGlyphs">TABAC DE TROUPE · VENTE INTERDITE</text>
<text x="212" y="95" text-anchor="middle" font-family="{MONO}" font-size="15" fill="{RED}">Nº 44 0611 · 20 PCS</text>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180°.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{NAVY}"/>
{tricolour(0, 18, w, 8)}
<text x="{w/2}" y="74" text-anchor="middle" font-family="{MONO}" font-size="16" fill="{KRAFT}">LOT 44-112 · T.3</text>
<text x="{w/2}" y="100" text-anchor="middle" font-family="{SANS}" font-size="13" letter-spacing="2" fill="{KRAFT}" opacity="0.85">MANUFACTURE DES TABACS · PARIS</text>
{tricolour(0, 125, w, 8)}
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # cockade above COCARDE. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the mouth end and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#cockade" transform="translate({w/2},16) scale(0.3)"/>
<text x="{w/2}" y="49" text-anchor="middle" font-family="{COND}" font-size="17" font-weight="bold" fill="{NAVY}"
      textLength="66" lengthAdjust="spacingAndGlyphs">COCARDE</text>
""", finish_it=False, scale=4)


FACES = {"front": front, "back": back, "right": right, "left": left, "top": top, "bottom": bottom, "logo": logo}
PROFILE = pathlib.Path(tempfile.gettempdir()) / "cocarde_edgeprofile"


def render(name, markup):
    (HERE / f"{name}.svg").write_text(markup, encoding="utf-8")
    w = int(markup.split('width="')[1].split('"')[0])
    h = int(markup.split('height="')[1].split('"')[0])
    html = HERE / f"_{name}.html"
    html.write_text(f'<!doctype html><html><head><meta charset="utf-8"><style>html,body{{margin:0;padding:0;background:transparent;overflow:hidden}}svg{{display:block}}</style></head><body>{markup}</body></html>', encoding="utf-8")
    png = HERE / f"{name}.png"
    png.unlink(missing_ok=True)
    # A profile of its own, or a running Edge swallows the call and nothing is written.
    subprocess.run([EDGE, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
                    f"--user-data-dir={PROFILE}",
                    "--default-background-color=00000000", f"--window-size={w},{h}", f"--screenshot={png}", html.as_uri()],
                   check=True, capture_output=True)
    for _ in range(100):
        if png.exists() and png.stat().st_size > 0:
            break
        time.sleep(0.2)
    time.sleep(0.5)
    html.unlink()
    print("wrote", png.name, w, "x", h)


def sheet():
    from PIL import Image
    f = {n: Image.open(HERE / f"{n}.png").convert("RGBA") for n in FACES}
    out = Image.new("RGBA", (361 * 2 + 151 * 2 + 60 + 288, 564 + 151 * 2 + 30), "#808080")
    x = 10
    for n in ("back", "left", "front", "right"):
        out.paste(f[n], (x, 161))
        if n == "front":
            out.paste(f["top"], (x, 5))
            out.paste(f["bottom"], (x, 161 + 564 + 5))
        x += f[n].width + 10
    out.paste(f["logo"], (x, 161), f["logo"])
    out.save(HERE / "faces-sheet.png")
    print("wrote faces-sheet.png")


if __name__ == "__main__":
    for n in (sys.argv[1:] or FACES):
        render(n, FACES[n]())
    if not sys.argv[1:]:
        sheet()
