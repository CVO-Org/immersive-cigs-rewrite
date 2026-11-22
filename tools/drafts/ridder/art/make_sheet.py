"""Lays the six faces and the paper logo out on one sheet for review (bottom shown as it hangs, turned 180)."""
import pathlib
from PIL import Image

HERE = pathlib.Path(__file__).resolve().parent
names = ["back", "left", "front", "right"]
sheet = Image.new("RGBA", (361 * 2 + 151 * 2 + 60 + 300, 564 + 151 + 40), (90, 90, 90, 255))
x = 10
for n in names:
    im = Image.open(HERE / f"{n}.png").convert("RGBA")
    sheet.alpha_composite(im, (x, 171))
    if n == "front":
        sheet.alpha_composite(Image.open(HERE / "top.png").convert("RGBA"), (x, 10))
    if n == "back":
        sheet.alpha_composite(Image.open(HERE / "bottom.png").convert("RGBA").rotate(180), (x, 10))
    x += im.width + 10
sheet.alpha_composite(Image.open(HERE / "logo.png").convert("RGBA"), (x, 200))
sheet.save(HERE / "faces-sheet.png")
print(sheet.size)
