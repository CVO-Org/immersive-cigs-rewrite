"""Hejnal pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Hejnal brand (Cold War Polish, PRL state tobacco, filterless; first pass).
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file,
      python make_faces.py sheet       -> faces-sheet.png from the PNGs.
"""
import os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("HEJNAL_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "hejnal_edgeprofile"))

RED, RED_D, CREAM, INK, BRASS = "#b3292b", "#7f1b1d", "#f0e6cf", "#1d1816", "#d6a647"
COND = "Bahnschrift, 'Arial Narrow', sans-serif"
SERIF = "Georgia, serif"
MONO = "Consolas, monospace"
# Bahnschrift is a variable font: wdth 75 is its condensed cut.
CONDSTYLE = "font-stretch:condensed; font-variation-settings:'wdth' 75, 'wght' 700; font-weight:700"

# Cheap PRL print: grain over the whole face, slight ink blotches, worn edges.
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
  <stop offset="70%" stop-color="#000" stop-opacity="0"/>
  <stop offset="100%" stop-color="#000" stop-opacity="0.26"/>
</radialGradient>
"""


def trumpet(fg, bg, banner_stripe):
    """Straight herald trumpet, bell to the right, a swallowtail banner hanging from it,
    three sound arcs out of the bell. About 250 x 90, origin in the middle of the tube."""
    return f"""
<g>
  <path d="M-62 4 H32 V52 L14 42 L-6 52 L-26 42 L-44 52 L-62 42 Z" fill="{fg}"/>
  <path d="M-62 30 H32" stroke="{banner_stripe}" stroke-width="7"/>
  <rect x="-104" y="-4" width="160" height="8" fill="{fg}"/>
  <rect x="-114" y="-7" width="10" height="14" rx="2" fill="{fg}"/>
  <circle cx="-30" cy="0" r="8" fill="{fg}"/>
  <circle cx="-30" cy="0" r="3" fill="{bg}"/>
  <path d="M54 -4 Q86 -6 104 -28 L104 28 Q86 6 54 4 Z" fill="{fg}"/>
  <path d="M114 -18 q8 18 0 36 M124 -27 q12 27 0 54 M134 -36 q16 36 0 72" stroke="{fg}" stroke-width="4" fill="none" stroke-linecap="round"/>
</g>"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.10"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.11"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def ctext(x, y, txt, size, fill, extra="", cond=False, family=COND):
    style = f' style="{CONDSTYLE}"' if cond else ""
    return f'<text x="{x}" y="{y}" text-anchor="middle" font-family="{family}" font-size="{size}" fill="{fill}"{style} {extra}>{txt}</text>'


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<rect x="0" y="0" width="{w}" height="48" fill="{CREAM}"/>
{ctext(w/2, 33, "PAPIEROSY", 22, RED, 'font-weight="bold" letter-spacing="9"')}
<rect x="14" y="62" width="{w-28}" height="{h-62-92-14}" fill="none" stroke="{CREAM}" stroke-width="2"/>
<rect x="19" y="67" width="{w-38}" height="{h-72-92-14}" fill="none" stroke="{CREAM}" stroke-width="0.8"/>
<g transform="translate({w/2-14},180) rotate(-14) scale(1.15)">{trumpet(CREAM, RED, RED)}</g>
{ctext(w/2, 382, "HEJNAŁ", 128, CREAM, 'textLength="300" lengthAdjust="spacingAndGlyphs"', cond=True)}
<path d="M60 404 H{w-60}" stroke="{CREAM}" stroke-width="2"/>
{ctext(w/2, 436, "BEZ FILTRA", 22, CREAM, 'font-weight="bold" letter-spacing="7"')}
<rect x="0" y="{h-92}" width="{w}" height="92" fill="{INK}"/>
<path d="M0 {h-92} H{w}" stroke="{BRASS}" stroke-width="3"/>
{ctext(w/2, h-52, "20 SZTUK", 26, CREAM, 'font-weight="bold" letter-spacing="5"')}
{ctext(w/2, h-22, "Cena 24 zł", 17, BRASS, 'letter-spacing="2"')}
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<rect x="0" y="0" width="{w}" height="48" fill="{CREAM}"/>
{ctext(w/2, 33, "PAPIEROSY", 22, RED, 'font-weight="bold" letter-spacing="9"')}
<rect x="22" y="70" width="{w-44}" height="378" fill="{CREAM}"/>
<rect x="30" y="78" width="{w-60}" height="362" fill="none" stroke="{RED}" stroke-width="1.5"/>
<g transform="translate({w/2-8},128) rotate(-14) scale(0.72)">{trumpet(RED, CREAM, CREAM)}</g>
{ctext(w/2, 238, "HEJNAŁ", 70, RED, 'textLength="200" lengthAdjust="spacingAndGlyphs"', cond=True)}
{ctext(w/2, 278, "Na każdą godzinę.", 24, INK, 'font-style="italic"', family=SERIF)}
{ctext(w/2, 318, "Mieszanka tytoni krajowych", 17, INK)}
{ctext(w/2, 340, "o pełnym, mocnym smaku.", 17, INK)}
<path d="M80 366 H{w-80}" stroke="{RED}" stroke-width="1.2"/>
{ctext(w/2, 398, "Palenie tytoniu", 19, INK, 'font-weight="bold"')}
{ctext(w/2, 422, "szkodzi zdrowiu.", 19, INK, 'font-weight="bold"')}
<rect x="0" y="{h-92}" width="{w}" height="92" fill="{INK}"/>
<path d="M0 {h-92} H{w}" stroke="{BRASS}" stroke-width="3"/>
{ctext(w/2, h-52, "Cena 24 zł", 22, CREAM, 'font-weight="bold" letter-spacing="3"')}
{ctext(w/2, h-24, "BN-78/9131-02", 14, BRASS, family=MONO)}
""")


def right():
    # Text runs top to bottom (turned 90 deg clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<rect x="0" y="0" width="{w}" height="48" fill="{CREAM}"/>
<g transform="translate({w/2},260) rotate(90)">
  {ctext(0, -10, "20 PAPIEROSÓW", 34, CREAM, 'font-weight="bold" letter-spacing="2"')}
  {ctext(0, 26, "BEZ FILTRA", 26, CREAM, 'letter-spacing="6"')}
</g>
<rect x="0" y="{h-92}" width="{w}" height="92" fill="{INK}"/>
<path d="M0 {h-92} H{w}" stroke="{BRASS}" stroke-width="3"/>
<g transform="translate({w/2-12},{h-50}) scale(0.42)">{trumpet(BRASS, INK, INK)}</g>
""")


def left():
    # Text runs bottom to top (turned 90 deg anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<rect x="0" y="0" width="{w}" height="48" fill="{CREAM}"/>
<g transform="translate({w/2},260) rotate(-90)">
  {ctext(0, -26, "Państwowe Zakłady Tytoniowe", 19, CREAM, 'font-weight="bold"')}
  {ctext(0, 0, "Kraków · Wyprodukowano w PRL", 17, CREAM)}
  {ctext(0, 28, "PARTIA 0384 · 03.1984", 15, BRASS, family=MONO)}
</g>
<rect x="0" y="{h-92}" width="{w}" height="92" fill="{INK}"/>
<path d="M0 {h-92} H{w}" stroke="{BRASS}" stroke-width="3"/>
{ctext(w/2, h-40, "Cena 24 zł", 18, CREAM, 'font-weight="bold"')}
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{INK}"/>
<path d="M0 {h-4} H{w}" stroke="{BRASS}" stroke-width="3"/>
<g transform="translate(86,64) scale(0.5)">{trumpet(BRASS, INK, INK)}</g>
{ctext(258, 98, "HEJNAŁ", 70, CREAM, 'textLength="170" lengthAdjust="spacingAndGlyphs"', cond=True)}
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 deg.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{RED}"/>
<path d="M20 34 H{w-20} M20 {h-34} H{w-20}" stroke="{CREAM}" stroke-width="1.5"/>
{ctext(w/2, 72, "PARTIA 0384 · 03.1984", 17, CREAM, family=MONO)}
{ctext(w/2, 98, "PAŃSTWOWE ZAKŁADY TYTONIOWE · KRAKÓW", 12, CREAM, 'letter-spacing="1"')}
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # trumpet above HEJNAL. Rendered at 4x; compose with --paper-logo-rotate -90 so its
    # top points at the mouth end and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<g transform="translate(31,15) rotate(-14) scale(0.24)">{trumpet(RED, "#ffffff", "#ffffff")}</g>
{ctext(w/2, 51, "HEJNAŁ", 24, RED, 'textLength="66" lengthAdjust="spacingAndGlyphs"', cond=True)}
""", finish_it=False, scale=4)


FACES = {"front": front, "back": back, "right": right, "left": left, "top": top, "bottom": bottom, "logo": logo}


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
    for _ in range(150):
        if png.exists() and png.stat().st_size > 0:
            break
        time.sleep(0.2)
    time.sleep(0.5)
    html.unlink()
    print("wrote", png.name, w, "x", h)


def sheet():
    from PIL import Image
    im = {n: Image.open(HERE / f"{n}.png").convert("RGBA") for n in FACES}
    out = Image.new("RGBA", (1024 + 40, 151 + 564 + 151 + 40), (110, 110, 110, 255))
    ox, oy = 20, 20
    # Same arrangement as the texture: top above front, bottom below back.
    out.paste(im["top"], (ox + 512, oy), im["top"])
    out.paste(im["back"], (ox + 0, oy + 151), im["back"])
    out.paste(im["left"], (ox + 361, oy + 151), im["left"])
    out.paste(im["front"], (ox + 512, oy + 151), im["front"])
    out.paste(im["right"], (ox + 873, oy + 151), im["right"])
    out.paste(im["bottom"], (ox + 0, oy + 151 + 564), im["bottom"])
    lg = im["logo"]
    bgl = Image.new("RGBA", lg.size, (255, 255, 255, 255))
    bgl.alpha_composite(lg)
    out.paste(bgl.resize((lg.width // 2, lg.height // 2)), (ox + 512, oy + 151 + 564 + 20))
    out.convert("RGB").save(HERE / "faces-sheet.png")
    print("wrote faces-sheet.png")


if __name__ == "__main__":
    args = sys.argv[1:] or list(FACES) + ["sheet"]
    for n in args:
        if n == "sheet":
            sheet()
        else:
            render(n, FACES[n]())
