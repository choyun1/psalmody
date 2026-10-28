"""Draw psalmody's logo as SVG files in docs/logo/.

The mark is a psalm tone in square notes on a four-line staff, as the plainchant pages print it: two
notes rising to the reciting note, the reciting note held (a long note), then the cadence falling
away. The wordmark is set in EB Garamond SemiBold (SIL Open Font License, in style/fonts/), the
typeface of the choir copies, and written into the files as outlines, so they need no font.
Colours are the chant browser's ink and accent, light and dark. Run from the repository root:

    python docs/logo/make_logo.py
"""
from pathlib import Path

from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from fontTools.ttLib import TTFont

HERE = Path(__file__).parent
FONT = HERE.parent.parent / 'style' / 'fonts' / 'EBGSemiBold-Regular.ttf'
COLORS = {'light': ('#2a2622', '#8a2b2b'), 'dark': ('#ece6dc', '#e08a7a')}
GAP = 10                         # staff-line spacing
H = 56                           # banner height, as sonore's
NOTES = [(0, 1), (1, 2), (2, 4), (3.2, 4, "long"), (4.9, 3), (5.9, 1)]   # (column, step); step 0 = bottom line


def mark(ink, accent):
    """The staff and the notes, in a 56-high box. Returns (svg elements, width)."""
    top = (H - 3 * GAP) / 2
    col, x0, n = 13, 8, GAP * 0.9
    width = x0 + col * 7.2
    y = lambda step: top + 3 * GAP - step * GAP / 2
    els = [f'<line x1="2" x2="{width - 2:.1f}" y1="{top + i * GAP:.1f}" y2="{top + i * GAP:.1f}" '
           f'stroke="{ink}" stroke-width="1.1" opacity="0.55"/>' for i in range(4)]
    for c, step, *kind in NOTES:
        w = n * (2.1 if kind else 1)
        els.append(f'<rect x="{x0 + c * col:.1f}" y="{y(step) - n / 2:.1f}" width="{w:.1f}" height="{n:.1f}" '
                   f'rx="0.8" fill="{accent}"/>')
    return els, width


def word(text, ink, x, size=44):
    font = TTFont(FONT)
    gs, cmap, upm = font.getGlyphSet(), font.getBestCmap(), font['head'].unitsPerEm
    s, pen, adv = size / upm, SVGPathPen(gs), 0
    for ch in text:
        g = cmap[ord(ch)]
        gs[g].draw(TransformPen(pen, (s, 0, 0, -s, x + adv * s, H * 0.72)))
        adv += font['hmtx'][g][0]
    return f'<path d="{pen.getCommands()}" fill="{ink}"/>', x + adv * s


def svg(els, width):
    return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {width:.0f} {H}" width="{width:.0f}" '
            f'height="{H}">' + ''.join(els) + '</svg>\n')


for mode, (ink, accent) in COLORS.items():
    m, mw = mark(ink, accent)
    (HERE / f'psalmody-mark-{mode}.svg').write_text(svg(m, mw))
    w, ww = word('psalmody', ink, 0)
    (HERE / f'psalmody-name-{mode}.svg').write_text(svg([w], ww + 4))
    w2, ww2 = word('psalmody', ink, mw + 14)
    (HERE / f'psalmody-banner-{mode}.svg').write_text(svg(m + [w2], ww2 + 4))
print('written to', HERE)
