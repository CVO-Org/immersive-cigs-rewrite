"""Bông Sen pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Bông Sen brand (Vietnam War era, filterless soft pack). First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
"""
import os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("BONGSEN_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "bongsen_edgeprofile"))

CREAM, CREAM_D = "#eee2c2", "#d8c69c"
JADE, JADE_D = "#2e6a4c", "#1d4733"
PINK, PINK_L, PINK_D = "#d8708c", "#f1bccb", "#9c3f58"
RED, RED_D = "#b02a2c", "#7a1a1c"
GOLD = "#d6a73c"
INK = "#1f1c18"
# Fonts with Vietnamese diacritics (checked in the render).
SERIF = "'Times New Roman', serif"
SANS = "'Segoe UI', Arial, sans-serif"
MONO = "Consolas, 'Courier New', monospace"

PETAL = "M0 0 C -17 -26 -15 -64 0 -92 C 15 -64 17 -26 0 0z"

# Cheap print: grain, blotches, worn edges.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="5" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.45  0 0 0 0 0.35  0 0 0 0 0.2  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="68%" stop-color="#3a2a10" stop-opacity="0"/>
  <stop offset="100%" stop-color="#3a2a10" stop-opacity="0.30"/>
</radialGradient>
<g id="lotus">
  <!-- leaves -->
  <ellipse cx="-58" cy="14" rx="52" ry="13" fill="{JADE}" stroke="{JADE_D}" stroke-width="2"/>
  <ellipse cx="58" cy="14" rx="52" ry="13" fill="{JADE}" stroke="{JADE_D}" stroke-width="2"/>
  <path d="M-58 14 L-100 10 M-58 14 L-20 10 M58 14 L100 10 M58 14 L20 10" stroke="{JADE_D}" stroke-width="1.5"/>
  <!-- back petals -->
  <path d="{PETAL}" transform="rotate(-72) scale(0.78)" fill="{PINK_L}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="{PETAL}" transform="rotate(72) scale(0.78)" fill="{PINK_L}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="{PETAL}" transform="rotate(-48) scale(0.9)" fill="{PINK_L}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="{PETAL}" transform="rotate(48) scale(0.9)" fill="{PINK_L}" stroke="{PINK_D}" stroke-width="2"/>
  <!-- front petals -->
  <path d="{PETAL}" transform="rotate(-24)" fill="{PINK}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="{PETAL}" transform="rotate(24)" fill="{PINK}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="{PETAL}" transform="scale(1.05)" fill="{PINK}" stroke="{PINK_D}" stroke-width="2"/>
  <path d="M0 -6 V-70 M-8 -10 L-24 -60 M8 -10 L24 -60" stroke="{PINK_D}" stroke-width="1.2" opacity="0.6"/>
</g>
<g id="lotussmall">
  <path d="{PETAL}" transform="rotate(-50) scale(0.8)" fill="{PINK}"/>
  <path d="{PETAL}" transform="rotate(50) scale(0.8)" fill="{PINK}"/>
  <path d="{PETAL}" transform="rotate(-25)" fill="{PINK}" stroke="{PINK_D}" stroke-width="3"/>
  <path d="{PETAL}" transform="rotate(25)" fill="{PINK}" stroke="{PINK_D}" stroke-width="3"/>
  <path d="{PETAL}" fill="{PINK}" stroke="{PINK_D}" stroke-width="3"/>
</g>
"""


def waves(x, y, w, colour, sw=1.6, op=1.0):
    d = f"M{x} {y}" + " q6 -5 12 0 t12 0" * int(w / 24)
    return f'<path d="{d}" stroke="{colour}" stroke-width="{sw}" fill="none" opacity="{op}"/>'


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.14"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.12"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="46" fill="{RED}"/>
<text x="{w/2}" y="32" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="bold" letter-spacing="6" fill="{GOLD}">THUỐC LÁ</text>
<text x="{w/2}" y="136" text-anchor="middle" font-family="{SERIF}" font-size="86" font-weight="bold" fill="{RED}"
      textLength="330" lengthAdjust="spacingAndGlyphs">BÔNG SEN</text>
<path d="M40 156 H{w-40}" stroke="{JADE}" stroke-width="2"/>
<text x="{w/2}" y="184" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="21" fill="{JADE_D}">Thơm như hoa sen</text>
<circle cx="{w/2}" cy="330" r="122" fill="{JADE}"/>
<circle cx="{w/2}" cy="330" r="114" fill="#f4ead0" stroke="{GOLD}" stroke-width="3"/>
<circle cx="{w/2}" cy="300" r="34" fill="{GOLD}" opacity="0.55"/>
<use href="#lotus" transform="translate({w/2},378) scale(1.05)"/>
<path d="M{w/2} 392 V440" stroke="{JADE_D}" stroke-width="3"/>
{waves(w/2-96, 410, 192, JADE, 1.8)}
{waves(w/2-84, 424, 168, JADE, 1.4, 0.7)}
<rect x="0" y="470" width="{w}" height="{h-470}" fill="{JADE}"/>
<path d="M0 472 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="508" text-anchor="middle" font-family="{SANS}" font-size="20" font-weight="bold" letter-spacing="2" fill="{CREAM}">20 ĐIẾU</text>
<text x="{w/2}" y="538" text-anchor="middle" font-family="{SANS}" font-size="16" letter-spacing="3" fill="{GOLD}">KHÔNG ĐẦU LỌC</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="46" fill="{RED}"/>
<text x="{w/2}" y="32" text-anchor="middle" font-family="{SANS}" font-size="19" font-weight="bold" letter-spacing="6" fill="{GOLD}">THUỐC LÁ</text>
<text x="{w/2}" y="112" text-anchor="middle" font-family="{SERIF}" font-size="58" font-weight="bold" fill="{RED}"
      textLength="290" lengthAdjust="spacingAndGlyphs">BÔNG SEN</text>
<path d="M40 132 H{w-40}" stroke="{JADE}" stroke-width="2"/>
<!-- pond -->
<rect x="24" y="152" width="313" height="200" fill="{JADE}"/>
<rect x="30" y="158" width="301" height="188" fill="#f4ead0"/>
<use href="#lotus" transform="translate(112,300) scale(0.6)"/>
<use href="#lotus" transform="translate(250,286) scale(0.8)"/>
<path d="M112 308 V332 M250 296 V332" stroke="{JADE_D}" stroke-width="2.5"/>
{waves(42, 322, 280, JADE, 1.6)}
{waves(54, 334, 256, JADE, 1.2, 0.7)}
<text x="{w/2}" y="396" text-anchor="middle" font-family="{SERIF}" font-style="italic" font-size="27" fill="{JADE_D}">Thơm như hoa sen</text>
<text x="{w/2}" y="434" text-anchor="middle" font-family="{SANS}" font-size="15" fill="{INK}">Thuốc lá ngon, giá phải chăng.</text>
<rect x="0" y="470" width="{w}" height="{h-470}" fill="{JADE}"/>
<path d="M0 472 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="508" text-anchor="middle" font-family="{SANS}" font-size="15" font-weight="bold" letter-spacing="2" fill="{CREAM}">SẢN XUẤT TẠI VIỆT NAM</text>
<text x="{w/2}" y="536" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">LÔ 0417 · 1968</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="46" fill="{RED}"/>
<g transform="translate({w/2},255) rotate(90)">
  <text x="0" y="-6" text-anchor="middle" font-family="{SANS}" font-size="22" font-weight="bold" letter-spacing="2" fill="{RED}">20 ĐIẾU THUỐC LÁ</text>
  <text x="0" y="24" text-anchor="middle" font-family="{SANS}" font-size="17" letter-spacing="3" fill="{JADE_D}">KHÔNG ĐẦU LỌC</text>
</g>
<rect x="0" y="470" width="{w}" height="{h-470}" fill="{JADE}"/>
<path d="M0 472 H{w}" stroke="{GOLD}" stroke-width="3"/>
<use href="#lotussmall" transform="translate({w/2},542) scale(0.55)"/>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="0" width="{w}" height="46" fill="{RED}"/>
<g transform="translate({w/2},255) rotate(-90)">
  <text x="0" y="-22" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="bold" fill="{RED}">XƯỞNG THUỐC LÁ BÔNG SEN</text>
  <text x="0" y="2" text-anchor="middle" font-family="{SANS}" font-size="15" fill="{JADE_D}">Sản xuất tại Việt Nam</text>
  <text x="0" y="28" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{INK}">LÔ 0417 · 1968</text>
</g>
<rect x="0" y="470" width="{w}" height="{h-470}" fill="{JADE}"/>
<path d="M0 472 H{w}" stroke="{GOLD}" stroke-width="3"/>
<use href="#lotussmall" transform="translate({w/2},542) scale(0.55)"/>
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{CREAM}"/>
<rect x="0" y="{h-14}" width="{w}" height="14" fill="{RED}"/>
<rect x="60" y="34" width="241" height="74" fill="#e6c7a6"/>
<rect x="60" y="34" width="241" height="74" fill="none" stroke="{RED_D}" stroke-width="2" stroke-dasharray="5 3"/>
<use href="#lotussmall" transform="translate(92,88) scale(0.34)"/>
<text x="196" y="66" text-anchor="middle" font-family="{SANS}" font-size="17" font-weight="bold" letter-spacing="2" fill="{RED_D}">TEM THUẾ</text>
<text x="196" y="92" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{RED_D}">Nº 0417 · 20 ĐIẾU</text>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{JADE}"/>
<path d="M0 22 H{w} M0 129 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="72" text-anchor="middle" font-family="{SERIF}" font-size="28" font-weight="bold" fill="{CREAM}">BÔNG SEN</text>
<text x="{w/2}" y="102" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">LÔ 0417 · 1968</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # lotus above BÔNG SEN. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the mouth end and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#lotussmall" transform="translate({w/2},30) scale(0.3)"/>
<text x="{w/2}" y="50" text-anchor="middle" font-family="{SERIF}" font-size="17" font-weight="bold" fill="{RED}"
      textLength="68" lengthAdjust="spacingAndGlyphs">BÔNG SEN</text>
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
