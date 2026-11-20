"""Ridder pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Ridder brand (fictional Danish filter cigarette, 1970s-80s). First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
"""
import os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("RIDDER_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "ridder_edgeprofile"))

# Danish 1970s modernism: white card, cobalt blue, brass gold, one thin red rule.
CARD = "#f7f5ef"
BLUE, BLUE_D = "#1f4aa8", "#14306e"
GOLD, GOLD_L = "#c49a3c", "#e2c57a"
RED = "#c0262d"
INK = "#1b1f2a"
# Montserrat is the closest installed face to the geometric sans of Danish 1970s design.
NAME = "RidderName, Montserrat, 'Segoe UI', Arial, sans-serif"
# Edge picks the installed Montserrat's regular weight for "bold"; load the Bold file by path.
_BOLD = pathlib.Path(os.environ["LOCALAPPDATA"]) / "Microsoft/Windows/Fonts/Montserrat-Bold.ttf"
FONTFACE = f"<style>@font-face {{ font-family: RidderName; src: url('{_BOLD.as_uri()}'); font-weight: bold; }}</style>"
SERIF = "Georgia, 'Times New Roman', serif"
SANS = "'Segoe UI', Arial, sans-serif"
MONO = "Consolas, 'Courier New', monospace"

# The mark: a knight's great helm seen from the front, in a ring, with a red plume. Not a crown.
# Centre at 0,0; ring radius 60 at scale 1.
HELM = f"""
<g id="helm">
  <circle r="60" fill="{BLUE}"/>
  <circle r="54" fill="none" stroke="{GOLD}" stroke-width="3"/>
  <path d="M-28,-30 Q-28,-44 0,-46 Q28,-44 28,-30 L28,30 Q28,36 22,38 L-22,38 Q-28,36 -28,30 Z" fill="{GOLD}"/>
  <rect x="-24" y="-8" width="48" height="6" fill="{BLUE}"/>
  <rect x="-3" y="-2" width="6" height="30" fill="{BLUE}"/>
  <g fill="{BLUE}">
    <circle cx="-14" cy="10" r="2"/><circle cx="-14" cy="18" r="2"/><circle cx="-14" cy="26" r="2"/>
    <circle cx="14" cy="10" r="2"/><circle cx="14" cy="18" r="2"/><circle cx="14" cy="26" r="2"/>
  </g>
  <path d="M0,-46 L0,-30" stroke="{BLUE}" stroke-width="2"/>
  <path d="M-6,-46 Q0,-64 14,-58 Q6,-54 6,-46 Z" fill="{RED}"/>
</g>
"""

DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="7" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="3" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.40  0 0 0 0 0.38  0 0 0 0 0.30  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="70%" stop-color="#202430" stop-opacity="0"/>
  <stop offset="100%" stop-color="#202430" stop-opacity="0.22"/>
</radialGradient>
{HELM}
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.08"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.09"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{FONTFACE}{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def frame(w, h):
    """White card, thin blue head band, blue foot block with gold and red rules; shared by the tall faces."""
    return f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
<rect x="0" y="0" width="{w}" height="12" fill="{BLUE}"/>
<rect x="0" y="12" width="{w}" height="3" fill="{GOLD}"/>
<rect x="0" y="430" width="{w}" height="3" fill="{GOLD}"/>
<rect x="0" y="433" width="{w}" height="{h-433}" fill="{BLUE}"/>
<rect x="0" y="440" width="{w}" height="2" fill="{RED}"/>
"""


def front():
    w, h = 361, 564
    return svg(w, h, f"""
{frame(w, h)}
<text x="{w/2}" y="48" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="600" letter-spacing="6" fill="{BLUE_D}">FILTER CIGARETTER</text>
<rect x="60" y="62" width="241" height="1.5" fill="{GOLD}"/>
<use href="#helm" transform="translate({w/2},168) scale(1.35)"/>
<text x="{w/2}" y="330" text-anchor="middle" font-family="{NAME}" font-size="84" font-weight="bold" fill="{BLUE}"
      textLength="320" lengthAdjust="spacingAndGlyphs">RIDDER</text>
<rect x="60" y="348" width="241" height="1.5" fill="{GOLD}"/>
<text x="{w/2}" y="384" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="22" fill="{RED}">En ægte dansk cigaret.</text>
<text x="{w/2}" y="414" text-anchor="middle" font-family="{SANS}" font-size="14" letter-spacing="3" fill="{INK}">MILD · FYLDIG · KØLIG</text>
<text x="{w/2}" y="494" text-anchor="middle" font-family="{NAME}" font-size="28" font-weight="bold" letter-spacing="3" fill="#ffffff">20 CIGARETTER</text>
<text x="{w/2}" y="530" text-anchor="middle" font-family="{SANS}" font-size="15" letter-spacing="4" fill="{GOLD_L}">KØBENHAVN</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
{frame(w, h)}
<use href="#helm" transform="translate({w/2},96) scale(0.8)"/>
<text x="{w/2}" y="204" text-anchor="middle" font-family="{NAME}" font-size="56" font-weight="bold" fill="{BLUE}"
      textLength="220" lengthAdjust="spacingAndGlyphs">RIDDER</text>
<text x="{w/2}" y="236" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="18" fill="{RED}">En ægte dansk cigaret.</text>
<rect x="22" y="262" width="317" height="148" fill="#ffffff" stroke="{INK}" stroke-width="2"/>
<g font-family="{SANS}" fill="{INK}" text-anchor="middle">
  <text x="{w/2}" y="290" font-size="15" font-weight="bold">Sundhedsstyrelsen advarer:</text>
  <text x="{w/2}" y="316" font-size="19" font-weight="bold">Rygning skader helbredet.</text>
  <text x="{w/2}" y="346" font-size="13">Røgen fra en cigaret af dette mærke</text>
  <text x="{w/2}" y="364" font-size="13">indeholder ca. 1,1 mg nikotin</text>
  <text x="{w/2}" y="382" font-size="13">og 15 mg tjære.</text>
  <text x="{w/2}" y="400" font-size="11">(gennemsnitlige værdier)</text>
</g>
<text x="{w/2}" y="494" text-anchor="middle" font-family="{SANS}" font-size="16" font-weight="bold" letter-spacing="2" fill="#ffffff">FREMSTILLET I DANMARK</text>
<text x="{w/2}" y="528" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD_L}">PARTI 0784 · 5 701234 567892</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
{frame(w, h)}
<g transform="translate({w/2},222) rotate(90)">
  <text x="0" y="-6" text-anchor="middle" font-family="{NAME}" font-size="46" font-weight="bold" fill="{BLUE}" letter-spacing="2">RIDDER</text>
  <text x="0" y="28" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="600" letter-spacing="2" fill="{RED}">20 FILTER CIGARETTER</text>
</g>
<use href="#helm" transform="translate({w/2},497) scale(0.75)"/>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
{frame(w, h)}
<g transform="translate({w/2},222) rotate(-90)">
  <text x="0" y="-22" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="bold" fill="{BLUE_D}">A/S Brødrene Holm Tobaksfabrik</text>
  <text x="0" y="4" text-anchor="middle" font-family="{SANS}" font-size="16" fill="{RED}">København · Fremstillet i Danmark</text>
  <text x="0" y="30" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="16" fill="{INK}">Siden 1921 · På ære og tro</text>
</g>
<use href="#helm" transform="translate({w/2},497) scale(0.75)"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front. A tax stamp runs over the lid, back to front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BLUE}"/>
<rect x="0" y="{h-14}" width="{w}" height="3" fill="{GOLD}"/>
<rect x="0" y="{h-11}" width="{w}" height="11" fill="{CARD}"/>
<use href="#helm" transform="translate(236,56) scale(0.6)"/>
<text x="236" y="122" text-anchor="middle" font-family="{NAME}" font-size="34" font-weight="bold" fill="#ffffff" letter-spacing="3">RIDDER</text>
<g transform="translate(40,0)">
  <rect x="0" y="0" width="60" height="{h}" fill="#f1e2e2"/>
  <rect x="4" y="0" width="52" height="{h}" fill="none" stroke="{RED}" stroke-width="1.5" stroke-dasharray="3 2"/>
  <g transform="translate(30,{h/2}) rotate(-90)" font-family="{SANS}" fill="#8a1a20" text-anchor="middle">
    <text x="0" y="-9" font-size="13" font-weight="bold" letter-spacing="1">TOBAKSAFGIFT</text>
    <text x="0" y="8" font-size="13" font-weight="bold">KR. 18,50</text>
    <text x="0" y="22" font-size="10">20 STK.</text>
  </g>
</g>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BLUE}"/>
<path d="M0 20 H{w} M0 131 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="72" text-anchor="middle" font-family="{NAME}" font-size="32" font-weight="bold" fill="#ffffff" letter-spacing="3">RIDDER</text>
<text x="{w/2}" y="104" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD_L}">PARTI 0784 · 20 FILTER CIGARETTER</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # helm above RIDDER. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the filter and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#helm" transform="translate({w/2},19) scale(0.29)"/>
<text x="{w/2}" y="50" text-anchor="middle" font-family="{NAME}" font-size="14" font-weight="bold" fill="{BLUE}"
      textLength="58" lengthAdjust="spacingAndGlyphs">RIDDER</text>
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
