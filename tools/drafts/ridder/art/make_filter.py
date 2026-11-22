"""White filter with two thin gold rings at the joint, for texture_compose.py --filter <png>.

Cuts the plain white filter (u 391-591, v 41-217) out of a texture composed with --filter white
and paints the rings, so the grain of the base texture stays.
Run:  python make_filter.py <texture composed with --filter white>  -> filter.png next to this file.
"""
import pathlib, sys
from PIL import Image, ImageDraw

HERE = pathlib.Path(__file__).resolve().parent
src = Image.open(sys.argv[1]).convert("RGBA")
filt = src.crop((391, 41, 591, 217))
d = ImageDraw.Draw(filt, "RGBA")
# u 391 is the paper joint (left edge of the crop). A 6 px gold ring, a gap, a 2 px ring.
d.rectangle((0, 0, 5, filt.height), fill=(196, 154, 60, 235))
d.rectangle((10, 0, 11, filt.height), fill=(196, 154, 60, 220))
filt.save(HERE / "filter.png")
print("wrote filter.png", filt.size)
