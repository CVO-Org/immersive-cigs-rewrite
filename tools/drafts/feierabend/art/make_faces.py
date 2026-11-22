"""Feierabend pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Feierabend brand (fictional West German filter cigarette, 1970s-80s). First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
"""
import math, os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("FEIERABEND_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "feierabend_edgeprofile"))

# 1970s West German palette: cream card, chocolate brown, sunset orange, mustard.
CARD = "#f2e6c8"
BROWN, BROWN_L = "#4b2c17", "#7a4a24"
ORANGE = "#e2701d"
MUSTARD = "#e6ad2e"
RED = "#b8341b"
INK = "#2a1a10"
# Rubik Bold has the round, heavy 1970s look; Georgia italic for the ad-copy slogan.
NAME = "Rubik, 'Segoe UI', Arial, sans-serif"
SERIF = "Georgia, 'Times New Roman', serif"
SANS = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
MONO = "Consolas, 'Courier New', monospace"


def rays(n, r_in, r_out, width_deg):
    """Sun rays over the upper half (horizon at y=0)."""
    out = []
    for i in range(n):
        a = math.radians(180 + (i + 0.5) * 180 / n)
        da = math.radians(width_deg / 2)
        p = [(r_in * math.cos(a - da), r_in * math.sin(a - da)), (r_out * math.cos(a - da * 0.6), r_out * math.sin(a - da * 0.6)),
             (r_out * math.cos(a + da * 0.6), r_out * math.sin(a + da * 0.6)), (r_in * math.cos(a + da), r_in * math.sin(a + da))]
        out.append("M" + " L".join(f"{x:.2f},{y:.2f}" for x, y in p) + "z")
    return " ".join(out)


# The mark: a setting sun on the horizon, rays above, three reflection stripes below.
# Centre = the sun's centre on the horizon line; about 240 wide, 170 tall at scale 1.
SUN = f"""
<clipPath id="above"><rect x="-200" y="-200" width="400" height="200"/></clipPath>
<g id="sun">
  <path d="{rays(9, 70, 118, 11)}" fill="{MUSTARD}"/>
  <circle r="62" fill="{ORANGE}" clip-path="url(#above)"/>
  <circle r="44" fill="{MUSTARD}" clip-path="url(#above)" opacity="0.35"/>
  <rect x="-120" y="0" width="240" height="9" fill="{BROWN}"/>
  <rect x="-92" y="17" width="184" height="9" fill="{ORANGE}"/>
  <rect x="-64" y="34" width="128" height="9" fill="{MUSTARD}"/>
  <rect x="-36" y="51" width="72" height="9" fill="{ORANGE}"/>
</g>
"""

DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="5" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.45  0 0 0 0 0.38  0 0 0 0 0.25  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="70%" stop-color="#30281a" stop-opacity="0"/>
  <stop offset="100%" stop-color="#30281a" stop-opacity="0.25"/>
</radialGradient>
{SUN}
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def bands(w, h):
    """Brown head and foot bands with the orange/mustard stripes, shared by the tall faces."""
    return f"""
<rect x="0" y="0" width="{w}" height="54" fill="{BROWN}"/>
<rect x="0" y="54" width="{w}" height="6" fill="{ORANGE}"/>
<rect x="0" y="63" width="{w}" height="4" fill="{MUSTARD}"/>
<rect x="0" y="466" width="{w}" height="4" fill="{MUSTARD}"/>
<rect x="0" y="473" width="{w}" height="6" fill="{ORANGE}"/>
<rect x="0" y="479" width="{w}" height="{h-479}" fill="{BROWN}"/>
"""


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<text x="{w/2}" y="36" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="600" letter-spacing="4" fill="{MUSTARD}">FILTER-CIGARETTEN</text>
<use href="#sun" transform="translate({w/2},228) scale(1.15)"/>
<text x="{w/2}" y="382" text-anchor="middle" font-family="{NAME}" font-size="78" font-weight="bold" fill="{BROWN}"
      textLength="334" lengthAdjust="spacingAndGlyphs">Feierabend</text>
<text x="{w/2}" y="428" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="21" fill="{RED}">Für die Stunde nach der Arbeit.</text>
<text x="{w/2}" y="522" text-anchor="middle" font-family="{SANS}" font-size="25" font-weight="bold" letter-spacing="3" fill="#ffffff">20 CIGARETTEN</text>
<text x="{w/2}" y="550" text-anchor="middle" font-family="{SANS}" font-size="16" letter-spacing="3" fill="{MUSTARD}">MILD · AROMATISCH</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<text x="{w/2}" y="36" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="600" letter-spacing="4" fill="{MUSTARD}">FILTER-CIGARETTEN</text>
<use href="#sun" transform="translate({w/2},148) scale(0.6)"/>
<text x="{w/2}" y="246" text-anchor="middle" font-family="{NAME}" font-size="56" font-weight="bold" fill="{BROWN}"
      textLength="250" lengthAdjust="spacingAndGlyphs">Feierabend</text>
<text x="{w/2}" y="278" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="18" fill="{RED}">Für die Stunde nach der Arbeit.</text>
<rect x="22" y="300" width="317" height="150" fill="#fbf6e9" stroke="{INK}" stroke-width="2"/>
<g font-family="{SANS}" fill="{INK}" text-anchor="middle">
  <text x="{w/2}" y="326" font-size="14.5" font-weight="600">Der Bundesminister für Jugend,</text>
  <text x="{w/2}" y="345" font-size="14.5" font-weight="600">Familie und Gesundheit:</text>
  <text x="{w/2}" y="371" font-size="17.5" font-weight="bold">Rauchen gefährdet Ihre Gesundheit.</text>
  <text x="{w/2}" y="397" font-size="13">Der Rauch einer Cigarette dieser Marke enthält</text>
  <text x="{w/2}" y="415" font-size="13">0,9 mg Nikotin und 14 mg Kondensat (Teer).</text>
  <text x="{w/2}" y="433" font-size="13">(Durchschnittswerte nach DIN)</text>
</g>
<text x="{w/2}" y="522" text-anchor="middle" font-family="{SANS}" font-size="18" font-weight="bold" letter-spacing="2" fill="#ffffff">MADE IN W.-GERMANY</text>
<text x="{w/2}" y="549" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{MUSTARD}">LOS 1183 · 4 001234 567890</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<g transform="translate({w/2},262) rotate(90)">
  <text x="0" y="-12" text-anchor="middle" font-family="{NAME}" font-size="40" font-weight="bold" fill="{BROWN}">Feierabend</text>
  <text x="0" y="22" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="bold" letter-spacing="2" fill="{ORANGE}">20 FILTER-CIGARETTEN</text>
</g>
<use href="#sun" transform="translate({w/2},525) scale(0.3)"/>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<g transform="translate({w/2},262) rotate(-90)">
  <text x="0" y="-20" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="bold" fill="{BROWN}">Cigarettenfabrik Aldermann &amp; Sohn</text>
  <text x="0" y="6" text-anchor="middle" font-family="{SANS}" font-size="16" fill="{RED}">Bremen · Hergestellt in der BRD</text>
  <text x="0" y="32" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="16" fill="{INK}">Seit 1952 für den Feierabend.</text>
</g>
<use href="#sun" transform="translate({w/2},525) scale(0.3)"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front. The tax stamp runs over the lid, back to front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BROWN}"/>
<rect x="0" y="{h-10}" width="{w}" height="6" fill="{ORANGE}"/>
<rect x="0" y="{h-4}" width="{w}" height="4" fill="{MUSTARD}"/>
<use href="#sun" transform="translate(236,62) scale(0.42)"/>
<text x="236" y="122" text-anchor="middle" font-family="{NAME}" font-size="38" font-weight="bold" fill="{MUSTARD}"
      textLength="190" lengthAdjust="spacingAndGlyphs">Feierabend</text>
<g transform="translate(34,0)">
  <rect x="0" y="0" width="58" height="{h}" fill="#cfe0c4"/>
  <rect x="4" y="0" width="50" height="{h}" fill="none" stroke="#4f7a52" stroke-width="1.5" stroke-dasharray="3 2"/>
  <g transform="translate(29,{h/2}) rotate(-90)" font-family="{SANS}" fill="#2e5233" text-anchor="middle">
    <text x="0" y="-8" font-size="13" font-weight="bold" letter-spacing="1">TABAKSTEUER</text>
    <text x="0" y="9" font-size="13" font-weight="bold">DM 3,00</text>
    <text x="0" y="23" font-size="10">20 Stück</text>
  </g>
</g>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BROWN}"/>
<path d="M0 20 H{w} M0 131 H{w}" stroke="{ORANGE}" stroke-width="4"/>
<text x="{w/2}" y="70" text-anchor="middle" font-family="{NAME}" font-size="32" font-weight="bold" fill="{MUSTARD}">Feierabend</text>
<text x="{w/2}" y="102" text-anchor="middle" font-family="{MONO}" font-size="14" fill="#f2e6c8">LOS 1183 · 20 FILTER-CIGARETTEN</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # sun above Feierabend. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the filter and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#sun" transform="translate({w/2},24) scale(0.17)"/>
<text x="{w/2}" y="49" text-anchor="middle" font-family="{NAME}" font-size="15" font-weight="bold" fill="{BROWN}"
      textLength="68" lengthAdjust="spacingAndGlyphs">Feierabend</text>
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
                    f"--user-data-dir={PROFILE}",
                    "--default-background-color=00000000", f"--window-size={w},{h}", f"--screenshot={png}", html.as_uri()],
                   check=True, capture_output=True)
    # Edge hands the work to a child process and returns before the PNG is written.
    for _ in range(150):
        if png.exists() and png.stat().st_size > 0:
            break
        time.sleep(0.2)
    time.sleep(0.5)
    html.unlink()
    print("wrote", png.name, w, "x", h, "ok" if png.exists() else "MISSING")


if __name__ == "__main__":
    for n in (sys.argv[1:] or FACES):
        render(n, FACES[n]())
