"""Jiskra pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Jiskra brand (fictional Czechoslovak cigarette, 1980s, with filter). First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
"""
import math, os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("JISKRA_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "jiskra_edgeprofile"))

CARD = "#f3efe4"        # off-white card
BLUE, BLUE_D = "#1f4e9c", "#163a74"
RED, RED_D = "#d8381e", "#a02512"
ORANGE = "#f29a1f"
INK = "#1d1d1f"
# Bahnschrift (DIN-like, fits 1980s Czechoslovak modernism) has Czech and Slovak diacritics.
DIN = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
MONO = "Consolas, 'Courier New', monospace"


def star(n, r_out, r_in, rot=0.0):
    pts = []
    for i in range(2 * n):
        r = r_out if i % 2 == 0 else r_in
        a = math.radians(rot + i * 180 / n - 90)
        pts.append(f"{r*math.cos(a):.2f},{r*math.sin(a):.2f}")
    return "M" + " L".join(pts) + "z"


# The spark: a long four-point star over a short rotated one, orange core.
SPARK = f"""
<g id="spark">
  <path d="{star(4, 100, 16, 45)}" fill="{ORANGE}"/>
  <path d="{star(4, 120, 18)}" fill="{RED}"/>
  <circle r="20" fill="{ORANGE}"/>
  <circle r="9" fill="#fff6dc"/>
</g>
"""

DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="7" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="3" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.45  0 0 0 0 0.38  0 0 0 0 0.25  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="70%" stop-color="#30281a" stop-opacity="0"/>
  <stop offset="100%" stop-color="#30281a" stop-opacity="0.25"/>
</radialGradient>
{SPARK}
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def bands(w, h):
    """Blue head band and blue foot band with red pinstripes, shared by the tall faces."""
    return f"""
<rect x="0" y="0" width="{w}" height="52" fill="{BLUE}"/>
<rect x="0" y="52" width="{w}" height="5" fill="{RED}"/>
<rect x="0" y="474" width="{w}" height="5" fill="{RED}"/>
<rect x="0" y="479" width="{w}" height="{h-479}" fill="{BLUE}"/>
"""


def speed_lines(x, y, w, colour):
    # Three short lines trailing the spark, 1980s "dynamic" packaging style.
    return "".join(f'<rect x="{x + i*14}" y="{y + i*16}" width="{w - i*18}" height="7" fill="{colour}"/>' for i in range(3))


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<text x="{w/2}" y="35" text-anchor="middle" font-family="{DIN}" font-size="19" font-weight="600" letter-spacing="4" fill="#ffffff">CIGARETY S FILTREM</text>
{speed_lines(14, 192, 74, BLUE)}
<use href="#spark" transform="translate({w/2+40},215) scale(1.05)"/>
<text x="{w/2}" y="392" text-anchor="middle" font-family="{DIN}" font-size="104" font-weight="bold" fill="{BLUE_D}"
      textLength="320" lengthAdjust="spacingAndGlyphs">JISKRA</text>
<path d="M30 414 H{w-30}" stroke="{RED}" stroke-width="3"/>
<text x="{w/2}" y="447" text-anchor="middle" font-family="{DIN}" font-size="21" fill="{RED_D}">Malá jiskra, plná chuť.</text>
<text x="{w/2}" y="520" text-anchor="middle" font-family="{DIN}" font-size="24" font-weight="bold" letter-spacing="3" fill="#ffffff">20 CIGARET</text>
<text x="{w/2}" y="549" text-anchor="middle" font-family="{DIN}" font-size="17" letter-spacing="2" fill="{ORANGE}">Kčs 12,-</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<text x="{w/2}" y="35" text-anchor="middle" font-family="{DIN}" font-size="19" font-weight="600" letter-spacing="4" fill="#ffffff">CIGARETY S FILTROM</text>
<use href="#spark" transform="translate({w/2},150) scale(0.62)"/>
<text x="{w/2}" y="282" text-anchor="middle" font-family="{DIN}" font-size="72" font-weight="bold" fill="{BLUE_D}"
      textLength="250" lengthAdjust="spacingAndGlyphs">JISKRA</text>
<text x="{w/2}" y="316" text-anchor="middle" font-family="{DIN}" font-size="19" fill="{RED_D}">Malá jiskra, plná chuť.</text>
<text x="{w/2}" y="342" text-anchor="middle" font-family="{DIN}" font-size="17" fill="{RED_D}">Malá iskra, plná chuť.</text>
<rect x="34" y="370" width="293" height="84" fill="none" stroke="{INK}" stroke-width="2"/>
<text x="{w/2}" y="404" text-anchor="middle" font-family="{DIN}" font-size="18" font-weight="600" fill="{INK}">Kouření škodí zdraví.</text>
<text x="{w/2}" y="434" text-anchor="middle" font-family="{DIN}" font-size="18" font-weight="600" fill="{INK}">Fajčenie škodí zdraviu.</text>
<text x="{w/2}" y="520" text-anchor="middle" font-family="{DIN}" font-size="18" font-weight="bold" letter-spacing="2" fill="#ffffff">VYROBENO V ČSSR</text>
<text x="{w/2}" y="548" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{ORANGE}">ŠARŽE 0384 · 1984</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<g transform="translate({w/2},266) rotate(90)">
  <text x="0" y="-14" text-anchor="middle" font-family="{DIN}" font-size="23" font-weight="bold" letter-spacing="1" fill="{BLUE_D}">20 CIGARET S FILTREM</text>
  <text x="0" y="16" text-anchor="middle" font-family="{DIN}" font-size="19" fill="{RED_D}">20 cigariet s filtrom</text>
  <text x="0" y="44" text-anchor="middle" font-family="{DIN}" font-size="17" letter-spacing="2" fill="{INK}">Kčs 12,-</text>
</g>
<use href="#spark" transform="translate({w/2},522) scale(0.26)"/>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CARD}"/>
{bands(w, h)}
<g transform="translate({w/2},266) rotate(-90)">
  <text x="0" y="-18" text-anchor="middle" font-family="{DIN}" font-size="18" font-weight="bold" fill="{BLUE_D}">Tabákové závody Jiskra, n. p.</text>
  <text x="0" y="8" text-anchor="middle" font-family="{DIN}" font-size="17" fill="{RED_D}">Hradiště · Vyrobeno v ČSSR</text>
  <text x="0" y="34" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{INK}">ŠARŽE 0384 · 1984</text>
</g>
<use href="#spark" transform="translate({w/2},522) scale(0.26)"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BLUE}"/>
<rect x="0" y="{h-6}" width="{w}" height="6" fill="{RED}"/>
<use href="#spark" transform="translate(90,72) scale(0.42)"/>
<text x="232" y="92" text-anchor="middle" font-family="{DIN}" font-size="50" font-weight="bold" fill="#ffffff"
      textLength="190" lengthAdjust="spacingAndGlyphs">JISKRA</text>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{BLUE}"/>
<path d="M0 20 H{w} M0 131 H{w}" stroke="{RED}" stroke-width="4"/>
<text x="{w/2}" y="70" text-anchor="middle" font-family="{DIN}" font-size="30" font-weight="bold" fill="#ffffff">JISKRA</text>
<text x="{w/2}" y="102" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{ORANGE}">VYROBENO 03/1984 · Kčs 12,-</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # spark above JISKRA. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the filter and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#spark" transform="translate({w/2},20) scale(0.15)"/>
<text x="{w/2}" y="50" text-anchor="middle" font-family="{DIN}" font-size="17" font-weight="bold" fill="{BLUE_D}"
      textLength="64" lengthAdjust="spacingAndGlyphs">JISKRA</text>
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
