"""Chergui pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Chergui brand (North Africa / Western Sahara, first pass).
Headless Edge is used on purpose: it shapes Arabic properly (right to left, joined letters).
Run:  python make_faces.py   -> writes <face>.svg / <face>.png next to this file.
"""
import pathlib, subprocess, sys, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"

RED, RED_D = "#a3301f", "#7a2116"
SAND, OCHRE = "#e3bb62", "#c08f3a"
CREAM = "#f2e6c9"
INK = "#1f1813"
STAMP, STAMP_INK = "#c9d3a6", "#3d4a22"
COND = "Bahnschrift, 'Arial Narrow', Arial, sans-serif"
SANS = "'Segoe UI', Tahoma, Arial, sans-serif"
ARAB = "'Segoe UI', Tahoma, Arial, sans-serif"   # both have Arabic glyphs
SERIF = "Georgia, serif"
MONO = "Consolas, monospace"

# Cheap print: grain, blotches, worn edges.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="5" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 1  0 0 0 0 1  0 0 0 0 1  0 0 0 0.9 -0.42" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="68%" stop-color="#000" stop-opacity="0"/>
  <stop offset="100%" stop-color="#000" stop-opacity="0.30"/>
</radialGradient>
<clipPath id="disc"><circle r="46"/></clipPath>
<!-- the mark: a low sun over two dunes, with the east wind blowing across it (from the right) -->
<g id="mark">
  <circle r="46" fill="{SAND}"/>
  <g clip-path="url(#disc)">
    <circle cx="-8" cy="4" r="20" fill="{RED}"/>
    <path d="M-50 22 Q-20 2 6 18 T52 14 V50 H-50z" fill="{OCHRE}"/>
    <path d="M-50 34 Q-12 18 22 30 T52 28 V50 H-50z" fill="{RED_D}"/>
  </g>
  <path d="M42 -20 H-4 a9 9 0 1 1 9 -9" fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>
  <path d="M44 -7 H-32" fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>
  <path d="M40 6 H10 a8 8 0 1 0 8 8" fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>
  <circle r="46" fill="none" stroke="{INK}" stroke-width="3"/>
</g>
<pattern id="zigzag" width="16" height="10" patternUnits="userSpaceOnUse">
  <rect width="16" height="10" fill="{INK}"/>
  <path d="M0 9 L8 1 L16 9" fill="none" stroke="{SAND}" stroke-width="2.2"/>
</pattern>
"""


def zigzag(x, y, w, h=10):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="url(#zigzag)"/>'


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.12"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.12"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def stamp_tail(w, y0, y1):
    # The end of the tax stamp that runs over the top of a soft pack, with a torn edge.
    x0 = w / 2 - 46
    teeth = " ".join("l4 3 l4 -3" for _ in range(11)) + " l4 3"
    return (f'<path d="M{x0} {y0} H{x0 + 92} V{y1} l-2 0 '
            f'{" ".join("l-4 4 l-4 -4" for _ in range(11))} l-2 0 Z" fill="{STAMP}"/>'
            f'<rect x="{x0 + 4}" y="{y0}" width="84" height="{y1 - y0 - 3}" fill="none" stroke="{STAMP_INK}" stroke-width="1"/>')


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{SAND}"/>
<rect width="{w}" height="232" fill="{RED}"/>
{stamp_tail(w, 0, 34)}
<text x="{w/2}" y="128" text-anchor="middle" font-family="{COND}" font-size="86" font-weight="bold" font-stretch="condensed" fill="{CREAM}"
      textLength="318" lengthAdjust="spacingAndGlyphs">CHERGUI</text>
<path d="M30 146 H{w-30}" stroke="{CREAM}" stroke-width="2"/>
<text x="{w/2}" y="208" text-anchor="middle" direction="rtl" font-family="{ARAB}" font-size="52" font-weight="bold" fill="{CREAM}">الشركي</text>
{zigzag(0, 232, w)}
<use href="#mark" transform="translate({w/2},340) scale(1.85)"/>
<text x="{w/2}" y="455" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="19" fill="{INK}">Le vent de l'est.</text>
<rect x="0" y="472" width="{w}" height="{h-472}" fill="{INK}"/>
<text x="{w/2}" y="506" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="2" fill="{CREAM}">TABAC BRUN · SANS FILTRE</text>
<text x="{w/2}" y="540" text-anchor="middle" font-family="{COND}" font-size="17" letter-spacing="3" fill="{SAND}">20 CIGARETTES</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{SAND}"/>
<rect width="{w}" height="232" fill="{RED}"/>
{stamp_tail(w, 0, 34)}
<text x="{w/2}" y="96" text-anchor="middle" font-family="{COND}" font-size="44" font-weight="bold" letter-spacing="2" fill="{CREAM}">CHERGUI</text>
<text x="{w/2}" y="156" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="28" fill="{CREAM}">Le vent de l'est.</text>
<text x="{w/2}" y="202" text-anchor="middle" direction="rtl" font-family="{ARAB}" font-size="26" fill="{SAND}">ريح الشرق</text>
{zigzag(0, 232, w)}
<rect x="24" y="254" width="313" height="204" fill="#fbf6ea"/>
<rect x="33" y="263" width="295" height="186" fill="none" stroke="{INK}" stroke-width="3"/>
<text x="{w/2}" y="312" text-anchor="middle" font-family="{SANS}" font-size="23" font-weight="bold" fill="{INK}">Fumer nuit gravement</text>
<text x="{w/2}" y="342" text-anchor="middle" font-family="{SANS}" font-size="23" font-weight="bold" fill="{INK}">à votre santé.</text>
<path d="M90 366 H271" stroke="{INK}" stroke-width="1.2"/>
<text x="{w/2}" y="414" text-anchor="middle" direction="rtl" font-family="{ARAB}" font-size="27" font-weight="bold" fill="{INK}">التدخين مضر بالصحة</text>
<rect x="0" y="472" width="{w}" height="{h-472}" fill="{INK}"/>
<text x="{w/2}" y="510" text-anchor="middle" font-family="{SANS}" font-size="14" letter-spacing="1" fill="{CREAM}">Régie des Tabacs de Sefrou-Ramal</text>
<text x="{w/2}" y="538" text-anchor="middle" font-family="{MONO}" font-size="13" fill="{SAND}">6 190315 020367</text>
""")


def right():
    # Text runs top to bottom (turned 90° clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{SAND}"/>
<rect width="{w}" height="232" fill="{RED}"/>
<g transform="translate({w/2},118) rotate(90)">
  <text x="0" y="-8" text-anchor="middle" font-family="{COND}" font-size="19" font-weight="bold" letter-spacing="1" fill="{CREAM}">20 CIGARETTES</text>
  <text x="0" y="24" text-anchor="middle" direction="rtl" font-family="{ARAB}" font-size="20" fill="{CREAM}">٢٠ سيجارة</text>
</g>
{zigzag(0, 232, w)}
<use href="#mark" transform="translate({w/2},350) scale(1.2)"/>
<rect x="0" y="472" width="{w}" height="{h-472}" fill="{INK}"/>
<text x="{w/2}" y="512" text-anchor="middle" font-family="{COND}" font-size="16" font-weight="bold" letter-spacing="1" fill="{CREAM}">SANS FILTRE</text>
<text x="{w/2}" y="540" text-anchor="middle" direction="rtl" font-family="{ARAB}" font-size="17" fill="{SAND}">بدون فلتر</text>
""")


def left():
    # Text runs bottom to top (turned 90° anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{SAND}"/>
<rect width="{w}" height="232" fill="{RED}"/>
<g transform="translate({w/2},118) rotate(-90)">
  <text x="0" y="-16" text-anchor="middle" font-family="{SANS}" font-size="13.5" fill="{CREAM}">Régie des Tabacs</text>
  <text x="0" y="4" text-anchor="middle" font-family="{SANS}" font-size="13.5" fill="{CREAM}">de Sefrou-Ramal</text>
  <text x="0" y="28" text-anchor="middle" font-family="{MONO}" font-size="13" fill="{SAND}">LOT 0315-SR</text>
</g>
{zigzag(0, 232, w)}
<g transform="translate({w/2},356) rotate(-90)">
  <text x="0" y="-10" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="17" fill="{INK}">Tabac brun</text>
  <text x="0" y="14" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="17" fill="{INK}">du pays.</text>
</g>
<rect x="0" y="472" width="{w}" height="{h-472}" fill="{INK}"/>
<text x="{w/2}" y="512" text-anchor="middle" font-family="{COND}" font-size="14" letter-spacing="1" fill="{SAND}">PRIX PUBLIC</text>
<text x="{w/2}" y="538" text-anchor="middle" font-family="{MONO}" font-size="16" fill="{CREAM}">9,00</text>
""")


def top():
    # Up = the back edge; the lower edge meets the front. The tax stamp runs over it, back to front.
    w, h = 361, 151
    x0 = w / 2 - 46
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<rect x="0" y="66" width="{w}" height="18" fill="{RED_D}" opacity="0.5"/>
<rect x="{x0}" y="0" width="92" height="{h}" fill="{STAMP}"/>
<rect x="{x0 + 4}" y="4" width="84" height="{h - 8}" fill="none" stroke="{STAMP_INK}" stroke-width="1"/>
<g transform="translate({w/2},{h/2}) rotate(90)">
  <text x="0" y="-14" text-anchor="middle" font-family="{SANS}" font-size="13" font-weight="bold" fill="{STAMP_INK}">TIMBRE FISCAL</text>
  <text x="0" y="4" text-anchor="middle" font-family="{SANS}" font-size="11" fill="{STAMP_INK}">SEFROU-RAMAL</text>
  <text x="0" y="22" text-anchor="middle" font-family="{MONO}" font-size="11" fill="{STAMP_INK}">Nº 0315 · 20 PCS</text>
</g>
<circle cx="{w/2 + 30}" cy="{h/2 + 36}" r="20" fill="none" stroke="{RED_D}" stroke-width="2" opacity="0.6"/>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180°.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{INK}"/>
{zigzag(0, 20, w)}
<text x="{w/2}" y="74" text-anchor="middle" font-family="{MONO}" font-size="16" fill="{SAND}">LOT 0315-SR · 11/2035</text>
<text x="{w/2}" y="100" text-anchor="middle" font-family="{SANS}" font-size="13" letter-spacing="2" fill="{CREAM}" opacity="0.85">FABRIQUÉ À SEFROU-RAMAL</text>
{zigzag(0, 121, w)}
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # the mark above CHERGUI. Rendered at 4x; compose with --paper-logo-rotate -90
    # --paper-logo-u 300 so its top points at the mouth end.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#mark" transform="translate({w/2},17) scale(0.34)"/>
<text x="{w/2}" y="50" text-anchor="middle" font-family="{COND}" font-size="17" font-weight="bold" fill="{RED}"
      textLength="66" lengthAdjust="spacingAndGlyphs">CHERGUI</text>
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
                    f"--user-data-dir={HERE / '_edgeprofile'}",
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


if __name__ == "__main__":
    for n in (sys.argv[1:] or FACES):
        render(n, FACES[n]())
