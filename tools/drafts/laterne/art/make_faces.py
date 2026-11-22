"""Laterne pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Laterne brand (fictional German filterless cigarette, 1940s civilian tobacco-company look).
First pass, no artist art. Deliberately free of any state emblem: no eagle, no swastika, no runes, no slogans
of the period. The tax stamp is a plain guilloche band with numbers only.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
"""
import math, os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("LATERNE_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "laterne_edgeprofile"))

# Night blue card, lamplight amber, cream and an old gilt.
NIGHT, NIGHT_D = "#1b2742", "#101829"
AMBER, GLOW = "#f0a92e", "#ffd877"
CREAM = "#efe4c8"
GOLD = "#c9a14a"
RED = "#8e2a22"
INK = "#141c30"
SANS = "Bahnschrift, 'Segoe UI', Arial, sans-serif"   # DIN-like, the German standard lettering of the 1930s
SERIF = "Lora, Georgia, 'Times New Roman', serif"
MONO = "Consolas, 'Courier New', monospace"

# --- Hand-drawn Art Deco capitals: cap height 100, thick 20 / thin 6 strokes. ----------------------
def _r(x, y, w, h):
    return f'<rect x="{x}" y="{y}" width="{w}" height="{h}"/>'

def _p(*pts):
    return '<polygon points="' + " ".join(f"{x},{y}" for x, y in pts) + '"/>'

GLYPHS = {
    "L": (56, _r(0, 0, 20, 100) + _r(0, 94, 56, 6)),
    "A": (78, _p((0, 100), (7, 100), (36, 0), (29, 0)) + _p((29, 0), (49, 0), (78, 100), (56, 100)) + _r(12, 66, 40, 6)),
    "T": (64, _r(0, 0, 64, 6) + _r(22, 0, 20, 100)),
    "E": (54, _r(0, 0, 20, 100) + _r(0, 0, 54, 6) + _r(0, 47, 44, 6) + _r(0, 94, 54, 6)),
    "R": (70, _r(0, 0, 20, 100) + '<path d="M10 3 H38 A25 25 0 0 1 38 53 H10" fill="none" stroke-width="6" stroke="currentColor"/>'
              + _p((30, 50), (50, 50), (72, 100), (50, 100))),
    "N": (64, _r(0, 0, 6, 100) + _p((0, 0), (20, 0), (64, 100), (44, 100)) + _r(58, 0, 6, 100)),
}
GAP = 11


def deco(word, cx, top, width, colour):
    """The word in the deco capitals, centred on cx, scaled to the given width."""
    total = sum(GLYPHS[c][0] for c in word) + GAP * (len(word) - 1)
    s = width / total
    x, parts = 0, []
    for c in word:
        w, g = GLYPHS[c]
        parts.append(f'<g transform="translate({x},0)">{g}</g>')
        x += w + GAP
    return (f'<g transform="translate({cx - width / 2},{top}) scale({s})" fill="{colour}" color="{colour}">'
            + "".join(parts) + "</g>")


# --- The mark: a gas street lantern with its light. Centre about the middle of the glass. -------
def rays(n, r_in, r_out):
    out = []
    for i in range(n):
        a = math.radians(-180 + (i + 0.5) * 360 / n)
        out.append(f"M{r_in*math.cos(a):.1f},{r_in*math.sin(a):.1f} L{r_out*math.cos(a):.1f},{r_out*math.sin(a):.1f}")
    return " ".join(out)

LANTERN = f"""
<radialGradient id="halo" cx="50%" cy="50%" r="50%">
  <stop offset="0%" stop-color="{GLOW}" stop-opacity="0.55"/>
  <stop offset="45%" stop-color="{AMBER}" stop-opacity="0.22"/>
  <stop offset="100%" stop-color="{AMBER}" stop-opacity="0"/>
</radialGradient>
<linearGradient id="pane" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0%" stop-color="{GLOW}"/>
  <stop offset="100%" stop-color="{AMBER}"/>
</linearGradient>
<g id="light">
  <circle cx="0" cy="-18" r="135" fill="url(#halo)"/>
  <path d="{rays(24, 70, 128)}" transform="translate(0,-18)" stroke="{GOLD}" stroke-width="2.2" opacity="0.75"/>
</g>
<g id="lamp">
  <rect x="-5" y="34" width="10" height="70" fill="{GOLD}"/>
  <polygon points="-26,22 26,22 14,38 -14,38" fill="{GOLD}"/>
  <polygon points="-36,-58 36,-58 24,22 -24,22" fill="url(#pane)" stroke="{GOLD}" stroke-width="5" stroke-linejoin="round"/>
  <path d="M-12,-58 L-8,22 M12,-58 L8,22" stroke="{GOLD}" stroke-width="3"/>
  <polygon points="-46,-58 46,-58 14,-86 -14,-86" fill="{GOLD}"/>
  <rect x="-16" y="-92" width="32" height="7" fill="{GOLD}"/>
  <circle cx="0" cy="-100" r="7" fill="{GOLD}"/>
  <path d="M-4,-12 Q0,-34 4,-12 Q0,-4 -4,-12z" fill="#fff6d6"/>
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
  <stop offset="70%" stop-color="#0a0d16" stop-opacity="0"/>
  <stop offset="100%" stop-color="#0a0d16" stop-opacity="0.30"/>
</radialGradient>
<linearGradient id="night" x1="0" y1="0" x2="0" y2="1">
  <stop offset="0%" stop-color="{NIGHT}"/>
  <stop offset="100%" stop-color="{NIGHT_D}"/>
</linearGradient>
{LANTERN}
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def frame(w, h, foot=478):
    """Night-blue card, gilt double rule with stepped corners, cream foot band."""
    return f"""
<rect width="{w}" height="{h}" fill="url(#night)"/>
<rect x="0" y="{foot}" width="{w}" height="{h-foot}" fill="{CREAM}"/>
<rect x="0" y="{foot-8}" width="{w}" height="3" fill="{GOLD}"/>
<rect x="0" y="{foot-3}" width="{w}" height="3" fill="{AMBER}"/>
<path d="M14,{foot-18} V30 H30 V14 H{w-30} V30 H{w-14} V{foot-18}" fill="none" stroke="{GOLD}" stroke-width="2.5"/>
<path d="M21,{foot-18} V36 H36 V21 H{w-36} V36 H{w-21} V{foot-18}" fill="none" stroke="{GOLD}" stroke-width="1"/>
"""


def front():
    w, h = 361, 564
    return svg(w, h, f"""
{frame(w, h)}
<text x="{w/2}" y="60" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="600" letter-spacing="5" fill="{GOLD}">ORIENT-MISCHUNG</text>
<use href="#light" transform="translate({w/2},200) scale(0.92)"/>
<use href="#lamp" transform="translate({w/2},200) scale(0.92)"/>
{deco("LATERNE", w/2, 330, 296, CREAM)}
<rect x="60" y="402" width="{w-120}" height="2" fill="{GOLD}"/>
<text x="{w/2}" y="440" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="23" fill="{AMBER}">Mild wie Laternenlicht.</text>
<text x="{w/2}" y="520" text-anchor="middle" font-family="{SANS}" font-size="28" font-weight="bold" letter-spacing="3" fill="{NIGHT}">20 CIGARETTEN</text>
<text x="{w/2}" y="547" text-anchor="middle" font-family="{SANS}" font-size="15" letter-spacing="2" fill="{RED}">OHNE MUNDSTÜCK · 4 Pf. das Stück</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
{frame(w, h)}
<use href="#light" transform="translate({w/2},128) scale(0.5)"/>
<use href="#lamp" transform="translate({w/2},128) scale(0.5)"/>
{deco("LATERNE", w/2, 206, 230, CREAM)}
<text x="{w/2}" y="292" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="19" fill="{AMBER}">Mild wie Laternenlicht.</text>
<rect x="60" y="310" width="{w-120}" height="1.5" fill="{GOLD}"/>
<g font-family="{SERIF}" fill="{CREAM}" text-anchor="middle" font-size="16">
  <text x="{w/2}" y="346">Feinste Orient-Tabake,</text>
  <text x="{w/2}" y="369">sorgfältig gemischt und gelagert,</text>
  <text x="{w/2}" y="392">für die stille Stunde am Abend</text>
  <text x="{w/2}" y="415">und die lange Fahrt.</text>
</g>
<rect x="60" y="436" width="{w-120}" height="1.5" fill="{GOLD}"/>
<text x="{w/2}" y="518" text-anchor="middle" font-family="{SANS}" font-size="18" font-weight="bold" letter-spacing="1" fill="{NIGHT}">CIGARETTENFABRIK C. W. LINDNER</text>
<text x="{w/2}" y="545" text-anchor="middle" font-family="{SANS}" font-size="15" letter-spacing="3" fill="{RED}">DRESDEN · GEGR. 1898</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
{frame(w, h)}
<g transform="translate({w/2 + 45},245) rotate(90)">{deco("LATERNE", 0, 0, 300, CREAM)}</g>
<text transform="translate({w/2 - 40},245) rotate(90)" x="0" y="0" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="600" letter-spacing="3" fill="{GOLD}">20 CIGARETTEN</text>
<use href="#lamp" transform="translate({w/2},518) scale(0.36)" />
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
{frame(w, h)}
<g transform="translate({w/2},245) rotate(-90)">
  <text x="0" y="-22" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="bold" letter-spacing="1" fill="{CREAM}">C. W. LINDNER · DRESDEN</text>
  <text x="0" y="6" text-anchor="middle" font-family="{SANS}" font-size="16" letter-spacing="2" fill="{GOLD}">FEINSTE ORIENT-TABAKE</text>
  <text x="0" y="34" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="17" fill="{AMBER}">Mild wie Laternenlicht.</text>
</g>
<use href="#lamp" transform="translate({w/2},518) scale(0.36)" />
""")


def guilloche(x0, x1, y, amp, period, phase=0):
    pts = []
    x = x0
    while x <= x1:
        pts.append(f"{x:.1f},{y + amp*math.sin((x - x0) / period * 2*math.pi + phase):.1f}")
        x += 2
    return "M" + " L".join(pts)


def top():
    # Up = the back edge; the lower edge meets the front. The tax band runs over the lid, back to front.
    w, h = 361, 151
    waves = "".join(f'<path d="{guilloche(0, 151, 0, 6, 22, k*0.8)}" transform="translate(0,{6 + k*7.5})"/>' for k in range(9))
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="url(#night)"/>
<rect x="0" y="{h-8}" width="{w}" height="3" fill="{GOLD}"/>
<rect x="0" y="{h-3}" width="{w}" height="3" fill="{AMBER}"/>
<use href="#light" transform="translate(236,58) scale(0.3)"/>
<use href="#lamp" transform="translate(236,58) scale(0.3)"/>
{deco("LATERNE", 236, 96, 170, CREAM)}
<g transform="translate(30,0)">
  <rect x="0" y="0" width="64" height="{h}" fill="#d9cfa8"/>
  <g transform="translate(64,0) rotate(90)" fill="none" stroke="#7a6a3a" stroke-width="0.8" opacity="0.7">{waves}</g>
  <rect x="5" y="0" width="54" height="{h}" fill="none" stroke="{RED}" stroke-width="1.5"/>
  <g transform="translate(32,{h/2}) rotate(-90)" font-family="{SANS}" fill="{RED}" text-anchor="middle">
    <rect x="-52" y="-22" width="104" height="44" fill="#d9cfa8" opacity="0.85"/>
    <text x="0" y="-7" font-size="13" font-weight="bold" letter-spacing="1">TABAKSTEUER</text>
    <text x="0" y="9" font-size="14" font-weight="bold">80 Pf.</text>
    <text x="0" y="21" font-size="10">20 Stück</text>
  </g>
</g>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="url(#night)"/>
<path d="M0 18 H{w} M0 133 H{w}" stroke="{GOLD}" stroke-width="3"/>
{deco("LATERNE", w/2, 42, 190, CREAM)}
<text x="{w/2}" y="104" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">Nr. 4417 · 20 CIGARETTEN · DRESDEN</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it), lantern above LATERNE.
    # Rendered at 4x; compose with --paper-logo-rotate -90 --paper-logo-u 300 so its top points at the
    # mouth end and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<g transform="translate({w/2},23) scale(0.19)">
  <path d="{rays(16, 70, 112)}" transform="translate(0,-18)" stroke="{GOLD}" stroke-width="6"/>
  <rect x="-6" y="34" width="12" height="30" fill="{NIGHT}"/>
  <polygon points="-26,22 26,22 14,38 -14,38" fill="{NIGHT}"/>
  <polygon points="-36,-58 36,-58 24,22 -24,22" fill="{AMBER}" stroke="{NIGHT}" stroke-width="8" stroke-linejoin="round"/>
  <polygon points="-46,-58 46,-58 14,-86 -14,-86" fill="{NIGHT}"/>
  <circle cx="0" cy="-98" r="9" fill="{NIGHT}"/>
</g>
{deco("LATERNE", w/2, 39, 66, NIGHT)}
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
