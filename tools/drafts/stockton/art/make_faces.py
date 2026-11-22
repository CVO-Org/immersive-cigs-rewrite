"""Stockton pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Stockton brand (mainstream American full-flavour filter cigarette, modern era).
First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png and faces-sheet.png next to this file.
"""
import math, os, pathlib, random, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("STOCKTON_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "stockton_edgeprofile"))

NAVY, NAVY_D = "#17295a", "#0c1736"
RED = "#c8202d"
WHITE = "#f6f4ee"
SILVER = "#b8bfcc"
INK = "#111111"
HEAVY = "'Arial Black', 'Segoe UI Black', sans-serif"
SANS = "Arial, 'Segoe UI', sans-serif"
COND = "Bahnschrift, 'Arial Narrow', sans-serif"
MONO = "Consolas, 'Courier New', monospace"


def star_path(r_out, r_in):
    pts = []
    for i in range(10):
        r = r_out if i % 2 == 0 else r_in
        a = math.radians(-90 + i * 36)
        pts.append(f"{r * math.cos(a):.3f},{r * math.sin(a):.3f}")
    return "M" + " L".join(pts) + "Z"


STAR = star_path(1.0, 0.40)

# The Stockton mark: a red diamond with a white rim and a white five-point star, on a navy keyline.
# Drawn at unit size 100 (diamond half-diagonal), centred on 0,0.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.95" numOctaves="2" seed="7" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.6 1.0" />
</filter>
<linearGradient id="sheen" x1="0" y1="0" x2="1" y2="1">
  <stop offset="0" stop-color="#ffffff" stop-opacity="0.10"/>
  <stop offset="0.5" stop-color="#ffffff" stop-opacity="0"/>
  <stop offset="1" stop-color="#000000" stop-opacity="0.10"/>
</linearGradient>
<g id="mark">
  <path d="M0 -100 L100 0 L0 100 L-100 0Z" fill="{NAVY}"/>
  <path d="M0 -88 L88 0 L0 88 L-88 0Z" fill="{WHITE}"/>
  <path d="M0 -76 L76 0 L0 76 L-76 0Z" fill="{RED}"/>
  <path d="{STAR}" transform="translate(0,4) scale(50)" fill="{WHITE}"/>
</g>
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.06"/>'
            f'<rect width="{w}" height="{h}" fill="url(#sheen)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def warning_box(x, y, w, h, lines, size):
    out = [f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#ffffff"/>',
           f'<rect x="{x+5}" y="{y+5}" width="{w-10}" height="{h-10}" fill="none" stroke="{INK}" stroke-width="4"/>']
    lh = size * 1.22
    y0 = y + h / 2 - (len(lines) - 1) * lh / 2 + size * 0.36
    for i, (txt, bold) in enumerate(lines):
        out.append(f'<text x="{x + w/2}" y="{y0 + i*lh:.1f}" text-anchor="middle" font-family="{SANS}" font-size="{size}" '
                   f'font-weight="{"bold" if bold else "normal"}" fill="{INK}">{txt}</text>')
    return "".join(out)


def barcode(x, y, h, seed=3):
    rnd = random.Random(seed)
    out, cx = [], x
    for _ in range(30):
        bw = rnd.choice([1, 1, 2, 3])
        out.append(f'<rect x="{cx}" y="{y}" width="{bw}" height="{h}" fill="{INK}"/>')
        cx += bw + rnd.choice([1, 2, 2, 3])
    return (f'<rect x="{x-6}" y="{y-6}" width="{cx-x+12}" height="{h+24}" fill="#ffffff"/>' + "".join(out) +
            f'<text x="{(x+cx)/2}" y="{y+h+14}" text-anchor="middle" font-family="{MONO}" font-size="11" fill="{INK}">0 28200 00417 6</text>')


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{WHITE}"/>
<rect width="{w}" height="62" fill="{NAVY}"/>
<rect y="62" width="{w}" height="6" fill="{RED}"/>
<text x="{w/2}" y="40" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="5" fill="{WHITE}">FILTER CIGARETTES</text>
<use href="#mark" transform="translate({w/2},165) scale(0.80)"/>
<text x="{w/2}" y="310" text-anchor="middle" font-family="{HEAVY}" font-size="64" fill="{NAVY}"
      textLength="330" lengthAdjust="spacingAndGlyphs">STOCKTON</text>
<rect x="30" y="326" width="{w-60}" height="4" fill="{RED}"/>
<text x="{w/2}" y="356" text-anchor="middle" font-family="{COND}" font-size="19" font-weight="bold" letter-spacing="3" fill="{RED}">AMERICA'S FULL FLAVOR</text>
<rect y="374" width="{w}" height="58" fill="{NAVY}"/>
<text x="{w/2}" y="401" text-anchor="middle" font-family="{COND}" font-size="17" font-weight="bold" letter-spacing="3" fill="{WHITE}">20 CLASS A CIGARETTES</text>
<text x="{w/2}" y="422" text-anchor="middle" font-family="{COND}" font-size="13" letter-spacing="4" fill="{SILVER}">KING SIZE</text>
{warning_box(0, 432, w, 132, [("WARNING:", True), ("Smoking causes lung cancer,", True), ("heart disease and emphysema.", True)], 21)}
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{WHITE}"/>
<rect width="{w}" height="62" fill="{NAVY}"/>
<rect y="62" width="{w}" height="6" fill="{RED}"/>
<text x="{w/2}" y="40" text-anchor="middle" font-family="{COND}" font-size="20" font-weight="bold" letter-spacing="5" fill="{WHITE}">FILTER CIGARETTES</text>
<use href="#mark" transform="translate({w/2},138) scale(0.52)"/>
<text x="{w/2}" y="238" text-anchor="middle" font-family="{HEAVY}" font-size="50" fill="{NAVY}"
      textLength="300" lengthAdjust="spacingAndGlyphs">STOCKTON</text>
<rect x="40" y="252" width="{w-80}" height="3" fill="{RED}"/>
<text x="{w/2}" y="278" text-anchor="middle" font-family="{COND}" font-size="16" font-weight="bold" letter-spacing="3" fill="{RED}">AMERICA'S FULL FLAVOR</text>
{warning_box(0, 296, w, 268, [("WARNING:", True), ("Cigarettes are addictive.", True), ("Quitting smoking now greatly", False), ("reduces serious risks", False), ("to your health.", False)], 22)}
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{NAVY}"/>
<rect x="0" y="0" width="{w}" height="62" fill="{NAVY_D}"/>
<rect y="62" width="{w}" height="6" fill="{RED}"/>
<use href="#mark" transform="translate({w/2},118) scale(0.34)"/>
<g transform="translate({w/2},330) rotate(90)">
  <text x="0" y="12" text-anchor="middle" font-family="{HEAVY}" font-size="50" fill="{WHITE}"
        textLength="330" lengthAdjust="spacingAndGlyphs">STOCKTON</text>
  <text x="0" y="46" text-anchor="middle" font-family="{COND}" font-size="17" font-weight="bold" letter-spacing="4" fill="{SILVER}">AMERICA'S FULL FLAVOR</text>
</g>
<rect y="{h-38}" width="{w}" height="6" fill="{RED}"/>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{WHITE}"/>
<rect x="0" y="0" width="{w}" height="62" fill="{NAVY}"/>
<rect y="62" width="{w}" height="6" fill="{RED}"/>
<g transform="translate({w/2},300) rotate(-90)">
  <text x="0" y="-30" text-anchor="middle" font-family="{COND}" font-size="22" font-weight="bold" letter-spacing="2" fill="{NAVY}">20 CLASS A CIGARETTES</text>
  <text x="0" y="-4" text-anchor="middle" font-family="{SANS}" font-size="14" fill="{INK}">Stockton Tobacco Company</text>
  <text x="0" y="16" text-anchor="middle" font-family="{SANS}" font-size="14" fill="{INK}">Richmond, Virginia · Made in U.S.A.</text>
  <text x="0" y="44" text-anchor="middle" font-family="{SANS}" font-size="12" fill="{INK}">Tar 10 mg · Nicotine 0.8 mg · CO 10 mg</text>
</g>
<rect y="{h-38}" width="{w}" height="6" fill="{RED}"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{NAVY}"/>
<rect y="{h-6}" width="{w}" height="6" fill="{NAVY_D}"/>
<use href="#mark" transform="translate(62,75) scale(0.40)"/>
<text x="216" y="88" text-anchor="middle" font-family="{HEAVY}" font-size="40" fill="{WHITE}"
      textLength="230" lengthAdjust="spacingAndGlyphs">STOCKTON</text>
<rect x="110" y="102" width="212" height="3" fill="{RED}"/>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{WHITE}"/>
<rect y="0" width="{w}" height="10" fill="{NAVY}"/>
<rect y="{h-10}" width="{w}" height="10" fill="{NAVY}"/>
{barcode(30, 38, 60)}
<text x="250" y="60" text-anchor="middle" font-family="{HEAVY}" font-size="24" fill="{NAVY}">STOCKTON</text>
<text x="250" y="84" text-anchor="middle" font-family="{MONO}" font-size="13" fill="{INK}">LOT 0417 R</text>
<text x="250" y="104" text-anchor="middle" font-family="{MONO}" font-size="13" fill="{INK}">RICHMOND VA</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # mark above STOCKTON. Rendered at 4x; compose with --paper-logo-rotate -90 so its top
    # (the mark) points at the filter and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#mark" transform="translate({w/2},17) scale(0.16)"/>
<text x="{w/2}" y="48" text-anchor="middle" font-family="{HEAVY}" font-size="14" fill="{NAVY}"
      textLength="66" lengthAdjust="spacingAndGlyphs">STOCKTON</text>
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


def sheet():
    from PIL import Image
    ims = {n: Image.open(HERE / f"{n}.png").convert("RGBA") for n in FACES}
    out = Image.new("RGBA", (361 * 2 + 151 * 2 + 50, 564 + 151 + 40), (90, 90, 90, 255))
    x = 10
    for n in ("back", "left", "front", "right"):
        out.alpha_composite(ims[n], (x, 10))
        x += ims[n].width + 10
    out.alpha_composite(ims["top"], (10, 584))
    out.alpha_composite(ims["bottom"], (381, 584))
    lg = ims["logo"]
    bg = Image.new("RGBA", lg.size, (255, 255, 255, 255))
    bg.alpha_composite(lg)
    out.alpha_composite(bg.resize((lg.width // 2, lg.height // 2)), (752, 600))
    out.save(HERE / "faces-sheet.png")
    print("wrote faces-sheet.png")


if __name__ == "__main__":
    for n in (sys.argv[1:] or FACES):
        render(n, FACES[n]())
    sheet()
