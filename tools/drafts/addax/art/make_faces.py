"""Addax pack faces and paper logo as SVG, rendered to PNG with headless Edge.

Source art for the Addax brand (first pass). American Turkish-blend filter cigarettes:
ivory card, deep teal bands, copper rules, a navy addax head with spiral horns in front
of a copper desert sun.
Run:  python make_faces.py   -> writes <face>.svg / <face>.png and faces-sheet.png next to this file.
"""
import math, pathlib, subprocess, time

HERE = pathlib.Path(__file__).resolve().parent
EDGE = r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
SCALE = 2

IVORY, IVORY_D = "#f1e8d2", "#e2d5b6"
TEAL, TEAL_D = "#0f4f5a", "#0a3840"
COPPER, COPPER_L = "#b5682f", "#d9924f"
NAVY = "#1b2838"
INK = "#151515"
COND = "'Bahnschrift SemiBold Condensed', 'Bahnschrift Condensed', Bahnschrift, 'Arial Narrow', sans-serif"
SANS = "Bahnschrift, 'Segoe UI', Arial, sans-serif"
SERIF = "Georgia, serif"


# ---------------------------------------------------------------- the addax head
def bez(p0, p1, p2, p3, t):
    u = 1 - t
    return tuple(u**3 * a + 3 * u * u * t * b + 3 * u * t * t * c + t**3 * d for a, b, c, d in zip(p0, p1, p2, p3))


def horn(p0, p1, p2, p3, w0, w1, twists=2.2, amp=4.0, n=90):
    """A tapering corkscrew horn along a cubic bezier: returns (outline path, ridge lines)."""
    pts = [bez(p0, p1, p2, p3, i / n) for i in range(n + 1)]
    left, right, ridges = [], [], []
    for i, (x, y) in enumerate(pts):
        t = i / n
        a, b = pts[max(i - 1, 0)], pts[min(i + 1, n)]
        dx, dy = b[0] - a[0], b[1] - a[1]
        l = math.hypot(dx, dy) or 1
        nx, ny = -dy / l, dx / l
        wob = amp * (1 - t) * math.sin(2 * math.pi * twists * t)
        cx, cy = x + nx * wob, y + ny * wob
        w = w0 + (w1 - w0) * t
        left.append((cx + nx * w, cy + ny * w))
        right.append((cx - nx * w, cy - ny * w))
        if i % 6 == 3 and t < 0.85:
            ridges.append(((cx + nx * w * 0.9, cy + ny * w * 0.9), (cx - nx * w * 0.9, cy - ny * w * 0.9)))
    outline = "M" + " L".join(f"{x:.1f},{y:.1f}" for x, y in left + right[::-1]) + "Z"
    rid = "".join(f"M{a[0]:.1f},{a[1]:.1f} L{b[0]:.1f},{b[1]:.1f}" for a, b in ridges)
    return outline, rid


def addax_symbol(body, accent, line):
    """Addax head facing left in a 200 x 200 box: navy head, spiral horns, pale noseband."""
    h1, r1 = horn((98, 100), (92, 62), (128, 40), (150, 2), 8.5, 1.3, twists=2.6, amp=3.0)
    h2, r2 = horn((110, 98), (108, 64), (150, 48), (178, 12), 8.0, 1.3, twists=2.6, amp=3.0)
    head = ("M26,142 C24,134 30,128 40,125 L86,104 C98,98 114,98 122,106 "
            "C130,114 132,128 130,142 L142,198 L102,198 C102,180 96,168 84,163 "
            "C68,156 48,154 34,150 Z")
    ear = "M120,110 C134,104 154,106 164,114 C152,122 134,122 122,120 Z"
    return f"""
  <path d="{h2}" fill="{body}"/>
  <path d="{r2}" stroke="{line}" stroke-width="1.4" fill="none" opacity="0.55"/>
  <path d="{ear}" fill="{body}"/>
  <path d="{head}" fill="{body}"/>
  <path d="{h1}" fill="{body}" stroke="{line}" stroke-width="0.8" stroke-opacity="0.6"/>
  <path d="{r1}" stroke="{line}" stroke-width="1.4" fill="none" opacity="0.6"/>
  <path d="M56,118 L66,113 L74,154 L63,152 Z" fill="{accent}"/>
  <circle cx="92" cy="116" r="3.6" fill="{accent}"/>
  <circle cx="91.5" cy="116" r="1.8" fill="{body}"/>
"""


DEFS = f"""
<filter id="grain" x="0" y="0" width="100%" height="100%">
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="11" result="n"/>
  <feColorMatrix in="n" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.4 0.95" />
</filter>
<radialGradient id="sun" cx="50%" cy="45%" r="55%">
  <stop offset="0%" stop-color="{COPPER_L}"/>
  <stop offset="100%" stop-color="{COPPER}"/>
</radialGradient>
<clipPath id="medclip"><circle cx="0" cy="0" r="92"/></clipPath>
<g id="medallion">
  <circle r="100" fill="{IVORY}" stroke="{TEAL}" stroke-width="5"/>
  <circle r="92" fill="{IVORY_D}"/>
  <g clip-path="url(#medclip)">
    <circle cx="6" cy="6" r="62" fill="url(#sun)"/>
    <path d="M-100,58 C-60,40 -20,46 10,58 C40,68 70,52 100,44 V100 H-100 Z" fill="{COPPER}" opacity="0.55"/>
    <path d="M-100,74 C-50,62 0,82 40,72 C70,66 90,70 100,66 V100 H-100 Z" fill="{TEAL}"/>
    <g transform="translate(-100,-104) scale(1)">{addax_symbol(NAVY, IVORY, IVORY_D)}</g>
  </g>
  <circle r="92" fill="none" stroke="{COPPER}" stroke-width="2"/>
</g>
<g id="mark">{addax_symbol(NAVY, IVORY, IVORY_D)}</g>
<g id="markivory">{addax_symbol(IVORY, TEAL, TEAL_D)}</g>
"""


def svg(w, h, body, finish=True):
    fin = f'<rect width="{w}" height="{h}" filter="url(#grain)" opacity="0.08"/>' if finish else ""
    return (f'<svg xmlns="http://www.w3.org/2000/svg" width="{w*SCALE}" height="{h*SCALE}" viewBox="0 0 {w} {h}">'
            f"<defs>{DEFS}</defs>{body}{fin}</svg>")


def barcode(x, y, w, h, seed=5):
    bars, xx, s = [], x, seed
    while xx < x + w:
        s = (s * 1103515245 + 12345) % 2**31
        bw = 1 + s % 3
        if (s >> 4) % 2:
            bars.append(f'<rect x="{xx}" y="{y}" width="{bw * 0.8:.1f}" height="{h}" fill="{INK}"/>')
        xx += bw
    return f'<rect x="{x-6}" y="{y-5}" width="{w+12}" height="{h+20}" fill="#fff"/>' + "".join(bars) + \
        f'<text x="{x + w/2}" y="{y+h+11}" font-family="Consolas, monospace" font-size="9" text-anchor="middle" fill="{INK}">0 48271 30520 7</text>'


# ---------------------------------------------------------------- faces
def front():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{IVORY}"/>
<rect width="{w}" height="78" fill="{TEAL}"/>
<rect y="78" width="{w}" height="5" fill="{COPPER}"/>
<text x="180.5" y="50" font-family="{SANS}" font-size="20" font-weight="600" letter-spacing="7" fill="{IVORY}" text-anchor="middle">AMERICAN BLEND</text>
<text x="180.5" y="185" font-family="{COND}" font-size="118" font-weight="700" fill="{NAVY}" text-anchor="middle" textLength="300" lengthAdjust="spacingAndGlyphs">ADDAX</text>
<text x="180.5" y="214" font-family="{SERIF}" font-style="italic" font-size="17" fill="{COPPER}" text-anchor="middle">Fine Turkish &amp; Domestic Tobaccos</text>
<use href="#medallion" transform="translate(180.5,320) scale(0.88)"/>
<text x="180.5" y="436" font-family="{SANS}" font-size="17" font-weight="700" letter-spacing="4" fill="{TEAL}" text-anchor="middle">FILTER CIGARETTES</text>
<rect x="0" y="452" width="{w}" height="112" fill="{TEAL}"/>
<rect x="0" y="452" width="{w}" height="4" fill="{COPPER}"/>
<rect x="16" y="468" width="329" height="82" fill="#fff" stroke="{INK}" stroke-width="3"/>
<text x="180.5" y="502" font-family="{SANS}" font-size="25" font-weight="700" fill="{INK}" text-anchor="middle">SMOKING KILLS</text>
<text x="180.5" y="532" font-family="{SANS}" font-size="15" fill="{INK}" text-anchor="middle">Quit now. Ask your doctor for help.</text>
""")


def back():
    w, h = 361, 564
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{IVORY}"/>
<rect width="{w}" height="78" fill="{TEAL}"/>
<rect y="78" width="{w}" height="5" fill="{COPPER}"/>
<text x="180.5" y="56" font-family="{COND}" font-size="44" font-weight="700" fill="{IVORY}" text-anchor="middle" letter-spacing="3">ADDAX</text>
<use href="#mark" transform="translate(130,92) scale(0.5)"/>
<text x="180.5" y="218" font-family="{SERIF}" font-style="italic" font-size="22" fill="{COPPER}" text-anchor="middle">A taste that travels.</text>
<text x="180.5" y="250" font-family="{SERIF}" font-size="13.5" fill="{NAVY}" text-anchor="middle">A blend of sun-cured Turkish leaf</text>
<text x="180.5" y="268" font-family="{SERIF}" font-size="13.5" fill="{NAVY}" text-anchor="middle">and choice American tobaccos,</text>
<text x="180.5" y="286" font-family="{SERIF}" font-size="13.5" fill="{NAVY}" text-anchor="middle">made for the long road.</text>
<rect x="0" y="312" width="{w}" height="252" fill="{TEAL}"/>
<rect x="0" y="312" width="{w}" height="4" fill="{COPPER}"/>
<rect x="16" y="330" width="329" height="218" fill="#fff" stroke="{INK}" stroke-width="3"/>
<text x="180.5" y="378" font-family="{SANS}" font-size="27" font-weight="700" fill="{INK}" text-anchor="middle">WARNING:</text>
<text x="180.5" y="416" font-family="{SANS}" font-size="21" font-weight="700" fill="{INK}" text-anchor="middle">Smoking causes lung</text>
<text x="180.5" y="444" font-family="{SANS}" font-size="21" font-weight="700" fill="{INK}" text-anchor="middle">cancer, heart disease</text>
<text x="180.5" y="472" font-family="{SANS}" font-size="21" font-weight="700" fill="{INK}" text-anchor="middle">and emphysema.</text>
<text x="180.5" y="516" font-family="{SANS}" font-size="13" fill="{INK}" text-anchor="middle">Smoke harms the people around you.</text>
""")


def right():
    # landscape: texture_compose turns it so the text runs top to bottom
    w, h = 564, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{IVORY}"/>
<rect width="{w}" height="26" fill="{TEAL}"/>
<rect y="125" width="{w}" height="26" fill="{TEAL}"/>
<rect y="26" width="{w}" height="3" fill="{COPPER}"/>
<rect y="122" width="{w}" height="3" fill="{COPPER}"/>
<text x="24" y="82" font-family="{COND}" font-size="46" font-weight="700" fill="{NAVY}">ADDAX</text>
<text x="24" y="108" font-family="{SANS}" font-size="15" font-weight="600" letter-spacing="2" fill="{COPPER}">20 FILTER CIGARETTES</text>
<text x="545" y="82" font-family="{SERIF}" font-style="italic" font-size="17" fill="{TEAL}" text-anchor="end">Turkish &amp; American</text>
<text x="545" y="104" font-family="{SERIF}" font-style="italic" font-size="17" fill="{TEAL}" text-anchor="end">Blend</text>
""")


def left():
    w, h = 564, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{IVORY}"/>
<rect width="{w}" height="26" fill="{TEAL}"/>
<rect y="125" width="{w}" height="26" fill="{TEAL}"/>
<rect y="26" width="{w}" height="3" fill="{COPPER}"/>
<rect y="122" width="{w}" height="3" fill="{COPPER}"/>
<text x="282" y="62" font-family="{SANS}" font-size="15" font-weight="600" fill="{NAVY}" text-anchor="middle">Addax Tobacco Company · Durham, N.C. · Made in U.S.A.</text>
<text x="282" y="86" font-family="{SANS}" font-size="13" fill="{NAVY}" text-anchor="middle">Tar 10 mg · Nicotine 0.8 mg · Carbon monoxide 10 mg</text>
<text x="282" y="110" font-family="{SANS}" font-size="12" fill="{COPPER}" text-anchor="middle" letter-spacing="1">FOR EXPORT · LOT A-7731 · 0911</text>
""")


def top():
    # up = back edge; the lower edge meets the front
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{TEAL}"/>
<rect y="120" width="{w}" height="4" fill="{COPPER}"/>
<rect y="124" width="{w}" height="27" fill="{IVORY}"/>
<use href="#markivory" transform="translate(32,18) scale(0.46)"/>
<text x="140" y="74" font-family="{COND}" font-size="52" font-weight="700" fill="{IVORY}">ADDAX</text>
<text x="142" y="100" font-family="{SANS}" font-size="13" letter-spacing="3" fill="{COPPER_L}">AMERICAN BLEND</text>
""")


def bottom():
    w, h = 361, 151
    return svg(w, h, f"""
<rect width="{w}" height="{h}" fill="{IVORY}"/>
<rect width="{w}" height="22" fill="{TEAL}"/>
<rect y="22" width="{w}" height="3" fill="{COPPER}"/>
{barcode(40, 48, 120, 60)}
<text x="250" y="72" font-family="{COND}" font-size="30" font-weight="700" fill="{NAVY}" text-anchor="middle">ADDAX</text>
<text x="250" y="96" font-family="{SANS}" font-size="13" fill="{NAVY}" text-anchor="middle">20 CIGARETTES</text>
""")


def logo():
    # paper logo, upright: mark on top (ends up next to the filter), name below
    w, h = 108, 144
    return svg(w, h, f"""
<use href="#mark" transform="translate(4,-2) scale(0.52)"/>
<text x="54" y="138" font-family="{COND}" font-size="34" font-weight="700" fill="{NAVY}" text-anchor="middle" textLength="96" lengthAdjust="spacingAndGlyphs">ADDAX</text>
""", finish=False)


def render(name, markup):
    svg_path = HERE / f"{name}.svg"
    svg_path.write_text(markup, encoding="utf-8")
    w = int(markup.split('width="')[1].split('"')[0])
    h = int(markup.split('height="')[1].split('"')[0])
    png = HERE / f"{name}.png"
    if png.exists():
        png.unlink()
    html = HERE / f"_{name}.html"
    html.write_text(f'<html><body style="margin:0;background:transparent">{markup}</body></html>', encoding="utf-8")
    # own profile, or a running Edge swallows the call
    subprocess.run([EDGE, "--headless=new", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
                    f"--user-data-dir={HERE / '_edgeprofile'}", "--default-background-color=00000000",
                    f"--window-size={w},{h}", f"--screenshot={png}", html.as_uri()], check=True, capture_output=True)
    for _ in range(150):
        if png.exists() and png.stat().st_size > 0:
            break
        time.sleep(0.2)
    time.sleep(0.3)
    html.unlink()
    print("wrote", png.name)


def sheet():
    from PIL import Image
    names = ["back", "left", "front", "right", "top", "bottom", "logo"]
    ims = {n: Image.open(HERE / f"{n}.png").convert("RGBA") for n in names}
    W = sum(ims[n].width for n in ["back", "front"]) + ims["left"].height + ims["right"].height + 100
    H = 1128 + 302 + 60
    out = Image.new("RGBA", (W, H), (90, 90, 90, 255))
    x = 10
    for n in ["back", "left", "front", "right"]:
        im = ims[n]
        if im.width > im.height:
            im = im.rotate(90 if n == "left" else -90, expand=True)
        out.paste(im, (x, 10), im)
        x += im.width + 20
    out.paste(ims["top"], (10, 1158), ims["top"])
    out.paste(ims["bottom"], (760, 1158), ims["bottom"])
    out.paste(ims["logo"], (1500, 1158), ims["logo"])
    out.save(HERE / "faces-sheet.png")
    print("wrote faces-sheet.png")


if __name__ == "__main__":
    for fn in (front, back, right, left, top, bottom, logo):
        render(fn.__name__, fn())
    sheet()
