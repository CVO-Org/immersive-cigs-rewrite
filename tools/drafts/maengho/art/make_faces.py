"""Maengho pack faces as SVG, rendered to PNG with headless Edge.

Source art for the Maengho brand (South Korea, Vietnam War era, filterless, army-issue look). First pass, no artist art.
Run:  python make_faces.py [face ...]  -> writes <face>.svg / <face>.png next to this file.
Hangul is set in Malgun Gothic (ships with Windows; checked in the render).
"""
import os, pathlib, subprocess, sys, tempfile, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
PROFILE = pathlib.Path(os.environ.get("MAENGHO_EDGE_PROFILE", pathlib.Path(tempfile.gettempdir()) / "maengho_edgeprofile"))

OD, OD_D, OD_L = "#4d5524", "#343a17", "#6b7438"
KHAKI, CREAM = "#d8c99a", "#efe5c6"
RED, RED_D = "#b2262a", "#7c191c"
ORANGE, ORANGE_D = "#d9822b", "#a85a16"
GOLD = "#cfae52"
INK = "#1d1b16"
KR = "'Malgun Gothic', sans-serif"
LAT = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
MONO = "Consolas, 'Courier New', monospace"

# Cheap print: grain, blotches, worn edges.
DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="23" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<filter id="blotch" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.03" numOctaves="3" seed="8" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0.45  0 0 0 0 0.38  0 0 0 0 0.2  0 0 0 0.9 -0.40" />
</filter>
<radialGradient id="wear" cx="50%" cy="50%" r="75%">
  <stop offset="68%" stop-color="#2a2410" stop-opacity="0"/>
  <stop offset="100%" stop-color="#2a2410" stop-opacity="0.32"/>
</radialGradient>
<g id="tiger">
  <!-- ears -->
  <circle cx="-64" cy="-66" r="27" fill="{ORANGE}" stroke="{INK}" stroke-width="4"/>
  <circle cx="64" cy="-66" r="27" fill="{ORANGE}" stroke="{INK}" stroke-width="4"/>
  <circle cx="-64" cy="-66" r="13" fill="{INK}"/>
  <circle cx="64" cy="-66" r="13" fill="{INK}"/>
  <!-- head -->
  <ellipse cx="0" cy="0" rx="94" ry="84" fill="{ORANGE}" stroke="{INK}" stroke-width="4"/>
  <!-- side stripes -->
  <path d="M-94 -8 L-58 -2 L-92 8z M-90 24 L-52 22 L-84 38z M-82 -34 L-54 -22 L-88 -20z" fill="{INK}"/>
  <path d="M94 -8 L58 -2 L92 8z M90 24 L52 22 L84 38z M82 -34 L54 -22 L88 -20z" fill="{INK}"/>
  <!-- forehead marks -->
  <path d="M-26 -70 H26 M-20 -56 H20 M-26 -42 H26 M0 -72 V-40" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>
  <path d="M-46 -66 Q-36 -50 -44 -34 M46 -66 Q36 -50 44 -34" stroke="{INK}" stroke-width="5" fill="none" stroke-linecap="round"/>
  <!-- muzzle and cheeks -->
  <ellipse cx="-30" cy="38" rx="38" ry="28" fill="{CREAM}"/>
  <ellipse cx="30" cy="38" rx="38" ry="28" fill="{CREAM}"/>
  <ellipse cx="0" cy="62" rx="22" ry="12" fill="{CREAM}"/>
  <!-- eyes, slanted -->
  <path d="M-58 -14 Q-38 -30 -16 -12 Q-38 -4 -58 -14z" fill="#e8d84a" stroke="{INK}" stroke-width="3.5"/>
  <path d="M58 -14 Q38 -30 16 -12 Q38 -4 58 -14z" fill="#e8d84a" stroke="{INK}" stroke-width="3.5"/>
  <ellipse cx="-36" cy="-14" rx="3.5" ry="8" fill="{INK}"/>
  <ellipse cx="36" cy="-14" rx="3.5" ry="8" fill="{INK}"/>
  <path d="M-64 -34 L-14 -20 M64 -34 L14 -20" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>
  <!-- nose and snarling mouth with fangs -->
  <path d="M-15 12 H15 L0 28z" fill="{RED_D}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>
  <path d="M0 28 V34" stroke="{INK}" stroke-width="3.5"/>
  <path d="M-32 38 Q0 30 32 38 Q22 70 0 72 Q-22 70 -32 38z" fill="{RED_D}" stroke="{INK}" stroke-width="3.5" stroke-linejoin="round"/>
  <path d="M-24 38 L-18 56 L-12 36z M24 38 L18 56 L12 36z" fill="#ffffff" stroke="{INK}" stroke-width="1.5" stroke-linejoin="round"/>
  <!-- whisker dots -->
  <circle cx="-40" cy="38" r="2.5" fill="{INK}"/><circle cx="-52" cy="32" r="2.5" fill="{INK}"/><circle cx="-50" cy="46" r="2.5" fill="{INK}"/>
  <circle cx="40" cy="38" r="2.5" fill="{INK}"/><circle cx="52" cy="32" r="2.5" fill="{INK}"/><circle cx="50" cy="46" r="2.5" fill="{INK}"/>
</g>
"""


def finish(w, h):
    return (f'<rect width="{w}" height="{h}" filter="url(#blotch)" opacity="0.14"/>'
            f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.12"/>'
            f'<rect width="{w}" height="{h}" fill="url(#wear)"/>')


def svg(w, h, body, finish_it=True, scale=1):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*scale}" height="{h*scale}" viewBox="0 0 {w} {h}">'
            f'<defs>{DEFS}</defs>{body}{finish(w, h) if finish_it else ""}</svg>')


def stars(cx, y, n=5, gap=16, r=4, colour=GOLD):
    out = []
    for i in range(n):
        x = cx + (i - (n - 1) / 2) * gap
        out.append(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{colour}"/>')
    return "".join(out)


def medallion(cx, cy, s=1.0):
    return f"""
<circle cx="{cx}" cy="{cy}" r="{112*s}" fill="{RED}"/>
<circle cx="{cx}" cy="{cy}" r="{104*s}" fill="{CREAM}" stroke="{GOLD}" stroke-width="{3*s}"/>
<use href="#tiger" transform="translate({cx},{cy+8*s}) scale({0.9*s})"/>
"""


def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD}"/>
<rect x="10" y="10" width="{w-20}" height="{h-20}" fill="none" stroke="{KHAKI}" stroke-width="2"/>
<text x="{w/2}" y="44" text-anchor="middle" font-family="{KR}" font-size="18" font-weight="bold" letter-spacing="10" fill="{KHAKI}">대한민국</text>
<text x="{w/2}" y="160" text-anchor="middle" font-family="{KR}" font-size="112" font-weight="bold" fill="{CREAM}">맹호</text>
<rect x="44" y="180" width="{w-88}" height="40" fill="{RED}"/>
<text x="{w/2}" y="210" text-anchor="middle" font-family="{LAT}" font-size="30" font-weight="bold" letter-spacing="7" fill="{CREAM}">MAENGHO</text>
{medallion(w/2, 352)}
<rect x="0" y="482" width="{w}" height="{h-482}" fill="{OD_D}"/>
<path d="M0 484 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="522" text-anchor="middle" font-family="{KR}" font-size="24" font-weight="bold" letter-spacing="4" fill="{CREAM}">담배 20개비</text>
{stars(w/2, 544)}
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD}"/>
<rect x="10" y="10" width="{w-20}" height="{h-20}" fill="none" stroke="{KHAKI}" stroke-width="2"/>
<text x="{w/2}" y="44" text-anchor="middle" font-family="{KR}" font-size="18" font-weight="bold" letter-spacing="10" fill="{KHAKI}">대한민국</text>
<rect x="34" y="70" width="{w-68}" height="250" fill="{CREAM}"/>
<rect x="40" y="76" width="{w-80}" height="238" fill="none" stroke="{RED}" stroke-width="2"/>
<use href="#tiger" transform="translate({w/2},176) scale(0.8)"/>
<text x="{w/2}" y="298" text-anchor="middle" font-family="{LAT}" font-size="26" font-weight="bold" letter-spacing="7" fill="{RED}">MAENGHO</text>
<text x="{w/2}" y="370" text-anchor="middle" font-family="{KR}" font-size="26" font-weight="bold" fill="{CREAM}">용맹한 장병에게</text>
<text x="{w/2}" y="404" text-anchor="middle" font-family="{KR}" font-size="15" fill="{KHAKI}">호랑이처럼 용맹하게</text>
<path d="M70 428 H{w-70}" stroke="{GOLD}" stroke-width="2"/>
<rect x="0" y="482" width="{w}" height="{h-482}" fill="{OD_D}"/>
<path d="M0 484 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="518" text-anchor="middle" font-family="{KR}" font-size="17" font-weight="bold" letter-spacing="3" fill="{CREAM}">대한민국 제조</text>
<text x="{w/2}" y="544" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">제 0612 호 · 1967</text>
""")


def right():
    # Text runs top to bottom (turned 90 degrees clockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD}"/>
<rect x="8" y="10" width="{w-16}" height="{h-20}" fill="none" stroke="{KHAKI}" stroke-width="2"/>
<text x="{w/2}" y="120" text-anchor="middle" font-family="{KR}" font-size="70" font-weight="bold" fill="{CREAM}">맹</text>
<text x="{w/2}" y="200" text-anchor="middle" font-family="{KR}" font-size="70" font-weight="bold" fill="{CREAM}">호</text>
<g transform="translate({w/2},345) rotate(90)">
  <text x="0" y="8" text-anchor="middle" font-family="{LAT}" font-size="24" font-weight="bold" letter-spacing="5" fill="{GOLD}">MAENGHO</text>
</g>
<rect x="0" y="482" width="{w}" height="{h-482}" fill="{OD_D}"/>
<path d="M0 484 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="530" text-anchor="middle" font-family="{KR}" font-size="20" font-weight="bold" fill="{CREAM}">20개비</text>
""")


def left():
    # Text runs bottom to top (turned 90 degrees anticlockwise).
    w, h = 151, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD}"/>
<rect x="8" y="10" width="{w-16}" height="{h-20}" fill="none" stroke="{KHAKI}" stroke-width="2"/>
<g transform="translate({w/2},250) rotate(-90)">
  <text x="0" y="-18" text-anchor="middle" font-family="{KR}" font-size="22" font-weight="bold" fill="{CREAM}">맹호 담배</text>
  <text x="0" y="10" text-anchor="middle" font-family="{KR}" font-size="15" fill="{KHAKI}">대한민국 제조</text>
  <text x="0" y="36" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">제 0612 호 · 1967</text>
</g>
<rect x="0" y="482" width="{w}" height="{h-482}" fill="{OD_D}"/>
<path d="M0 484 H{w}" stroke="{GOLD}" stroke-width="3"/>
{stars(w/2, 524, 3, 18, 4)}
""")


def top():
    # Up = the back edge; the lower edge meets the front.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD}"/>
<rect x="0" y="{h-12}" width="{w}" height="12" fill="{OD_D}"/>
<rect x="70" y="30" width="221" height="80" fill="{CREAM}"/>
<rect x="76" y="36" width="209" height="68" fill="none" stroke="{RED}" stroke-width="2" stroke-dasharray="5 3"/>
<text x="{w/2}" y="82" text-anchor="middle" font-family="{KR}" font-size="34" font-weight="bold" letter-spacing="14" fill="{RED}">군용</text>
""")


def bottom():
    # Drawn upright; texture_compose.py turns it 180 degrees.
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{OD_D}"/>
<path d="M0 22 H{w} M0 129 H{w}" stroke="{GOLD}" stroke-width="3"/>
<text x="{w/2}" y="74" text-anchor="middle" font-family="{KR}" font-size="30" font-weight="bold" fill="{CREAM}">맹호</text>
<text x="{w/2}" y="104" text-anchor="middle" font-family="{MONO}" font-size="14" fill="{GOLD}">제 0612 호 · 1967</text>
""")


def logo():
    # Paper logo, drawn upright: 72 wide (round the cigarette) x 54 tall (along it),
    # tiger head above 맹호. Rendered at 4x; compose with --paper-logo-rotate -90 so
    # its top points at the mouth end and it reads from the front of the cigarette.
    w, h = 72, 54
    return svg(w, h, f"""
<use href="#tiger" transform="translate({w/2},17) scale(0.14)"/>
<text x="{w/2}" y="51" text-anchor="middle" font-family="{KR}" font-size="18" font-weight="bold" fill="{RED}">맹호</text>
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
