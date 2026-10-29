"""A chant from MusicXML (exported by MuseScore, Finale, Sibelius, Dorico…), in the layout of the chant files.

    python tools/musicxml.py chant.musicxml          # print the chant file it makes (and any warnings)

The four voices are found however the score is laid out: four parts (Soprano, Alto, Tenor, Bass), or two
staves with two voices each (an SATB "closed score"), or two staves of two-note chords, or a mixture (chords
in one bar, two voices in the next, one note for both in unison). In each staff the higher voice is the upper
one; parts named Soprano, Alto, Tenor and Bass are taken by their names. Further staves (an organ part) are
left out, with a warning. Each voice becomes a voice of the chant (S_notes … B_notes) in LilyPond's relative
notes, with its bars; a double barline ends a phrase (\\bar "||"), as does an empty bar between two (as some
exporters write a double bar). Without any, a chant of 7 bars is taken as single (3 + 4) and of 14 as double
(3 + 4 + 3 + 4). The key, the time and the composer come from the score too.
"""
import io, os, re, sys, zipfile
from fractions import Fraction as F
import xml.etree.ElementTree as ET

TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)

FIFTHS_MAJOR = ['ces', 'ges', 'des', 'aes', 'ees', 'bes', 'f', 'c', 'g', 'd', 'a', 'e', 'b', 'fis', 'cis']   # -7 … 7
FIFTHS_MINOR = ['aes', 'ees', 'bes', 'f', 'c', 'g', 'd', 'a', 'e', 'b', 'fis', 'cis', 'gis', 'dis', 'ais']
SEMITONES = {'c': 0, 'd': 2, 'e': 4, 'f': 5, 'g': 7, 'a': 9, 'b': 11}
NAMES = {'S_notes': ('soprano', 'sopranos', 's', 's.', 'treble', 'trebles'), 'A_notes': ('alto', 'altos', 'a', 'a.', 'contralto'),
         'T_notes': ('tenor', 'tenors', 't', 't.'), 'B_notes': ('bass', 'basses', 'b', 'b.', 'baritone')}
LABELS = [('S_notes', 'Soprano'), ('A_notes', 'Alto'), ('T_notes', 'Tenor'), ('B_notes', 'Bass')]
MAX_SCORE = 20 * 2 ** 20                                   # bytes of MusicXML: a chant is a few dozen KB
NOTE = re.compile(r"^(<[^>]*>|[a-gr](?:is|es)*[',]*)(\\breve|\d+\.*)?(~?)$")     # a note as written here


def read(data, filename=''):
    """The score's XML from a .musicxml/.xml file or a compressed .mxl (bytes)."""
    if data[:2] == b'PK' or filename.lower().endswith('.mxl'):
        try:
            z = zipfile.ZipFile(io.BytesIO(data))
        except zipfile.BadZipFile:
            raise ValueError('not a MusicXML file (a .mxl is a zip, and this isn\'t one)')
        names = z.namelist()
        path = None
        if 'META-INF/container.xml' in names:
            c = ET.fromstring(z.read('META-INF/container.xml'))
            path = next((e.get('full-path') for e in c.iter() if e.tag.split('}')[-1] == 'rootfile'), None)
        if path not in names:
            path = next((n for n in names if n.lower().endswith(('.xml', '.musicxml')) and not n.startswith('META-INF')), None)
        if not path:
            raise ValueError('no score inside the .mxl file')
        with z.open(path) as fh:                         # read no more than a score could be (not a zip bomb)
            data = fh.read(MAX_SCORE + 1)
        if len(data) > MAX_SCORE:
            raise ValueError(f'the score inside the .mxl file is over {MAX_SCORE // 2 ** 20} MB, far more than a chant')
    try:
        root = ET.fromstring(data)
    except ET.ParseError as e:
        raise ValueError(f'not a MusicXML file ({e})')
    for e in root.iter():                               # namespaces aside
        if isinstance(e.tag, str):
            e.tag = e.tag.split('}')[-1]
    if root.tag == 'score-timewise':
        raise ValueError('this is "timewise" MusicXML; export it again as ordinary ("partwise") MusicXML')
    if root.tag != 'score-partwise':
        raise ValueError('not a MusicXML score')
    return root


# ------------------------------------------------------------------ notes
def number(text, what, bar='', low=None, high=None, kind=int):
    """A number from the score, or a ValueError that says where (a file damaged, or written by hand)."""
    try:
        x = kind(float((text or '').strip()))
    except (ValueError, OverflowError):
        x = None
    if x is None or x != x or (low is not None and x < low) or (high is not None and x > high):
        raise ValueError(f'{"bar " + str(bar) + ": " if bar else ""}{what} {(text or "").strip()!r} isn\'t one the importer can read')
    return x


def pitch_of(p, bar=''):
    """A <pitch> -> (LilyPond name, MIDI number): ('fis'', 66)."""
    step = (p.findtext('step') or '').strip().lower()
    if step not in SEMITONES:
        raise ValueError(f'{"bar " + str(bar) + ": " if bar else ""}a note named {step!r}')
    octave = number(p.findtext('octave'), 'an octave', bar, 0, 9)
    alter = round(number(p.findtext('alter') or '0', 'an alteration', bar, -2, 2, float))
    marks = octave - 3                                     # LilyPond's c is the C below middle C (octave 3)
    name = step + {-2: 'eses', -1: 'es', 0: '', 1: 'is', 2: 'isis'}[alter] + ("'" * marks if marks > 0 else "," * -marks)
    return name, 12 * (octave + 1) + SEMITONES[step] + alter


def lily_pitch(p):
    return pitch_of(p)[0]


def lily_dur(divs, per_quarter):
    """A length in divisions -> LilyPond's 2, 4., 8 … (None if it isn't a plain or dotted note)."""
    whole = F(divs, per_quarter * 4)
    for base in (1, 2, 4, 8, 16, 32, 64):
        for dots in range(4):
            if F(1, base) * (2 - F(1, 2 ** dots)) == whole:
                return str(base) + '.' * dots
    return None                                            # (longer than a whole note: a chant hasn't such)


class Event:
    """A note, a chord or a rest in one voice: pitches [(name, midi)], length (divisions, of a quarter), tie."""
    def __init__(self, pitches, divs, per_quarter, tie, bar):
        self.pitches, self.divs, self.per_quarter, self.tie, self.bar = pitches, divs, per_quarter, tie, bar

    @property
    def length(self):
        return F(self.divs, self.per_quarter * 4)

    def text(self, pitch=None):
        d = lily_dur(self.divs, self.per_quarter)
        if d is None:
            what = 'a note longer than a whole note' if self.length > 1 else 'a note of an unusual length (in a tuplet?)'
            raise ValueError(f'bar {self.bar}: {what}, which a chant doesn\'t have; change it in the score and export it again')
        if not self.pitches:
            return 'r' + d
        if len(self.pitches) > 1:                           # a divided voice, the top note first, as in the chant files: <fis d>2
            return '<' + ' '.join(n for n, _ in sorted(self.pitches, key=lambda p: -p[1])) + '>' + d + ('~' if self.tie else '')
        return self.pitches[0][0] + d + ('~' if self.tie else '')

    def copy(self, pitch):
        return Event([pitch], self.divs, self.per_quarter, self.tie, self.bar)


# ------------------------------------------------------------------ reading the score
def parse(root):
    """-> (staves, bars, meta). staves: [(part name, staff number, [{voice: [Event]} per bar], part index)], in
    score order; bars: per part, [{'double': bool, 'number': str}] per bar; meta: key, time, warnings."""
    names = {sp.get('id'): (sp.findtext('part-name') or '').strip() for sp in root.iter('score-part')}
    order = [sp.get('id') for sp in root.iter('score-part')]
    meta = {'fifths': None, 'mode': 'major', 'time': None, 'warnings': []}
    staves, all_bars = [], []
    parts = sorted(root.findall('part'), key=lambda p: order.index(p.get('id')) if p.get('id') in order else len(order))
    for pi, part in enumerate(parts):
        per_quarter = 1
        by_staff = {}                                     # staff -> [{voice: [Event]} per bar]
        measures = part.findall('measure')
        bars = [{'double': False, 'number': m.get('number') or str(mi + 1)} for mi, m in enumerate(measures)]
        all_bars.append(bars)
        for mi, m in enumerate(measures):
            num = bars[mi]['number']
            for el in m:
                if el.tag == 'attributes':
                    if el.find('divisions') is not None:
                        per_quarter = number(el.findtext('divisions'), 'divisions', num, 1, 10 ** 6)
                    k, t = el.find('key'), el.find('time')
                    if k is not None and k.find('fifths') is not None:
                        fifths = number(k.findtext('fifths'), 'a key signature of', num, -7, 7)
                        if meta['fifths'] is None:
                            meta['fifths'], meta['mode'] = fifths, (k.findtext('mode') or 'major').strip().lower()
                        elif fifths != meta['fifths'] and pi == 0:
                            meta['warnings'].append(f'bar {num}: the key changes; the chant keeps the first one')
                    if t is not None and t.find('beats') is not None and t.find('beat-type') is not None:
                        ts = f"{t.findtext('beats') or ''}/{t.findtext('beat-type') or ''}".replace(' ', '')
                        if not re.fullmatch(r'[1-9]\d?/(1|2|4|8|16|32)', ts):
                            raise ValueError(f'bar {num}: a time signature of {ts!r}')
                        if meta['time'] is None:
                            meta['time'] = ts
                        elif ts != meta['time'] and pi == 0:
                            meta['warnings'].append(f'bar {num}: the time changes to {ts}; the chant keeps {meta["time"]}')
                elif el.tag == 'barline':
                    style = (el.findtext('bar-style') or '').strip()
                    if style in ('light-light', 'light-heavy', 'heavy-heavy', 'heavy-light'):
                        at = mi - 1 if el.get('location') == 'left' else mi
                        if at >= 0:
                            bars[at]['double'] = True
                elif el.tag == 'note':
                    if el.find('grace') is not None or el.find('cue') is not None:
                        continue
                    staff, voice = (el.findtext('staff') or '1').strip(), (el.findtext('voice') or '1').strip()
                    bar = by_staff.setdefault(staff, [])
                    while len(bar) <= mi:
                        bar.append({})
                    evs = bar[mi].setdefault(voice, [])
                    tie = any(t.get('type') == 'start' for t in el.findall('tie'))
                    if el.find('chord') is not None and evs:         # another note on the same stem
                        if el.find('pitch') is not None:
                            evs[-1].pitches.append(pitch_of(el.find('pitch'), num))
                            evs[-1].tie = evs[-1].tie or tie
                        continue
                    divs = number(el.findtext('duration') or '0', 'a note\'s length', num, 0, 10 ** 7)
                    if divs <= 0:
                        continue
                    pitches = [pitch_of(el.find('pitch'), num)] if el.find('pitch') is not None else []
                    if el.find('rest') is None and not pitches:      # an unpitched note (percussion)
                        continue
                    evs.append(Event(pitches, divs, per_quarter, tie, num))
        for staff in sorted(by_staff, key=lambda s: int(s) if s.isdigit() else 0):
            ms = by_staff[staff] + [{}] * (len(measures) - len(by_staff[staff]))
            staves.append((names.get(part.get('id'), ''), staff, ms, pi))
    return staves, all_bars, meta


def _sounding(evs):
    return [e for e in evs or [] if e.pitches]


def _mean(lines):
    ps = [p for evs in lines for e in evs or [] for _, p in e.pitches]
    return sum(ps) / len(ps) if ps else 0


def staff_voices(ms):
    """The voices that sing on a staff, in number order (at most two)."""
    voices = sorted({v for bar in ms for v, evs in bar.items() if _sounding(evs)}, key=lambda v: int(v) if v.isdigit() else 0)
    if len(voices) > 2:
        raise ValueError(f'a staff with {len(voices)} voices; a staff holds two at most (soprano and alto, or tenor and bass)')
    return voices


def has_chords(ms):
    return any(len(e.pitches) > 1 for bar in ms for evs in bar.values() for e in evs)


def staff_lines(ms, split=False):
    """A staff's bars ({voice: [Event]}) -> its sung lines, highest first. Two voices make two lines; so do chords,
    when split (soprano and alto on one stem), a single note then being sung by both (unison). Otherwise a chord
    stays a chord, a voice divided for a moment."""
    voices = staff_voices(ms)
    if len(voices) <= 1 and not split:
        v = voices[0] if voices else None
        return [[bar.get(v, []) if v else [] for bar in ms]]
    if len(voices) == 2:                                  # which voice sits higher, over the whole staff
        hi, lo = voices
        if _mean([b.get(hi) for b in ms]) < _mean([b.get(lo) for b in ms]):
            hi, lo = lo, hi
    else:
        hi = lo = voices[0] if voices else None
    upper, lower = [], []
    for bar in ms:
        a, b = _sounding(bar.get(hi)), _sounding(bar.get(lo))
        if hi != lo and a and b:                          # two voices in this bar (a chord in one: divided)
            upper.append(bar[hi])
            lower.append(bar[lo])
            continue
        evs = bar.get(hi) if a else bar.get(lo) if b else []
        u, l = [], []
        for e in evs or []:                               # chords split; a single note is sung by both (unison)
            if len(e.pitches) > 2:
                raise ValueError(f'bar {e.bar}: a chord of {len(e.pitches)} notes on one stem, where two voices share it')
            ps = sorted(e.pitches, key=lambda p: p[1])
            u.append(e.copy(ps[-1]) if ps else e)
            l.append(e.copy(ps[0]) if ps else e)
        upper.append(u)
        lower.append(l)
    return [upper, lower]


def phrase_ends(n_measures, doubles):
    if doubles:
        return sorted(d for d in doubles if d < n_measures - 1) + [n_measures - 1]
    shape = {7: [3, 4], 14: [3, 4, 3, 4], 8: [4, 4], 16: [4, 4, 4, 4]}.get(n_measures)
    if not shape:
        return [n_measures - 1]
    ends, at = [], -1
    for k in shape:
        at += k
        ends.append(at)
    return ends


def drop_repeated_lengths(tokens):
    """['c4', 'b4', 'a2'] -> ['c4', 'b', 'a2']: a length is written only when it changes, as in the chant files."""
    out, last = [], None
    for t in tokens:
        m = NOTE.match(t)
        if m and m.group(2):
            if m.group(2) == last:
                t = m.group(1) + m.group(3)
            last = m.group(2)
        out.append(t)
    return out


def to_relative(absolute):
    """'aes'2 ees'4 …' (absolute) -> ("c''", 'as2 es4 …') for \\relative."""
    import ly.document, ly.pitch.abs2rel
    d = ly.document.Document('{ ' + absolute + ' }')
    ly.pitch.abs2rel.abs2rel(ly.document.Cursor(d))
    m = re.match(r"^\\relative\s+(\S+)\s*\{(.*)\}\s*$", d.plaintext().strip(), re.S)
    if not m:
        raise ValueError('could not turn the notes into relative ones')
    return m.group(1), m.group(2).strip()


def voices_named(name):
    """The voices a staff's name gives, in order: 'Soprano' -> ['S_notes']; 'S. A.', 'Soprano/Alto', 'SA',
    'Tenors & Basses' -> two. [] for any other name (an instrument, 'Choir', 'Staff 1')."""
    words = [w for w in re.split(r'[^a-z]+', name.lower()) if w and w not in ('and', 'i', 'ii', 'solo', 'choir')]
    if len(words) == 1 and re.fullmatch(r'[satb]{2,4}', words[0]) and not any(words[0] in ns for ns in NAMES.values()):
        words = list(words[0])                            # 'SA', 'TB', 'SATB'
    out = []
    for w in words:
        var = next((v for v, ns in NAMES.items() if w in ns or w.rstrip('.') in ns), None)
        if var is None:
            return []
        out.append(var)
    return out


def _by_name(staves, lines):
    """The four lines by their staves' names (Soprano, Alto… or 'S. A.' for two), if the names give each voice
    once, whatever else the score has (instruments, an organ part); else None."""
    found = {}
    for (name, *_), ls in zip(staves, lines):
        sung = [l for l in ls if any(_sounding(b) for b in l)]
        named = voices_named(name)
        if not named or not sung:
            continue
        if len(named) != len(sung) or any(v in found for v in named):
            return None
        found.update(zip(named, sung))
    return [found[v] for v, _ in LABELS] if len(found) == 4 else None


def to_parts(data, filename=''):
    """-> (parts as chantedit.parts gives them, {'composer', 'title', 'warnings'}) from a MusicXML file's bytes."""
    root = read(data, filename)
    staves, bars, meta = parse(root)
    warnings = meta['warnings']
    # how many lines each staff sings: its voices; a staff of chords becomes two only if four aren't found otherwise
    count = [len(staff_voices(ms)) for _, _, ms, _ in staves]
    split = [False] * len(staves)
    for i, (_, _, ms, _) in enumerate(staves):
        if sum(count) >= 4:
            break
        if count[i] == 1 and has_chords(ms):
            split[i], count[i] = True, 2
    lines = [staff_lines(ms, sp) for (_, _, ms, _), sp in zip(staves, split)]
    sung = [(i, l) for i, ls in enumerate(lines) for l in ls if any(_sounding(b) for b in l)]
    four = _by_name(staves, lines)
    if four is not None:
        four = [(next(i for i, ls in enumerate(lines) if any(l is x for x in ls)), l) for l in four]
        others = sorted({staves[i][0] or f'staff {staves[i][1]}' for i, l in sung if not any(l is x for _, x in four)})
        if others:
            warnings.append(f'took the voices by their names, leaving out {", ".join(others)}')
    else:
        if len(sung) < 4:
            raise ValueError(f'found {len(sung)} voice(s); a chant has four (soprano, alto, tenor and bass)')
        if len(sung) > 4:
            left = sorted({staves[i][0] or f'staff {staves[i][1]}' for i, _ in sung[4:]})
            warnings.append(f'the score has {len(sung)} voices; took the first four, leaving out {", ".join(left)}')
        four = sung[:4]
        means = [_mean(l) for _, l in four]
        if means != sorted(means, reverse=True):
            warnings.append('the voices aren\'t in the order soprano, alto, tenor, bass (by pitch); check them in the editor')
    # each voice's bars, leaving out bars it doesn't sing in; such a bar between two ends a phrase (an exporter may
    # write a double bar so), as does a double barline
    kept = []
    for i, line in four:
        pbars = bars[staves[i][3]]
        keep, ends = [], set()
        for mi, evs in enumerate(line):
            if evs:
                keep.append(mi)
                if mi < len(pbars) and pbars[mi]['double']:
                    ends.add(len(keep) - 1)
            elif keep:                                    # a bar with nothing in it, not even a rest
                ends.add(len(keep) - 1)
        kept.append([line, keep, ends, pbars])
    counts = [len(k) for _, k, _, _ in kept]
    if not max(counts):
        raise ValueError('the score has no notes')
    if len(set(counts)) > 1:
        raise ValueError('the voices have different numbers of bars (' + ', '.join(
            f'{label.lower()} {n}' for (_, label), n in zip(LABELS, counts)) + ')')
    # bars every voice rests in: left out too, ending a phrase
    rests = [k for k in range(counts[0]) if not any(_sounding(line[keep[k]]) for line, keep, _, _ in kept)]
    for item in kept:
        line, keep, e, _ = item
        marks = set()
        for k in e:
            marks.add(k - sum(r <= k for r in rests))
        for r in rests:
            if r > 0:
                marks.add(r - 1 - sum(x < r for x in rests))
        item[1] = [mi for k, mi in enumerate(keep) if k not in rests]
        item[2] = {m for m in marks if m >= 0}
    n = len(kept[0][1])
    if not n:
        raise ValueError('the score has no notes')
    ends = set(phrase_ends(n, set().union(*(e for _, _, e, _ in kept))))
    time = meta['time'] or '2/4'
    beats, beat = (int(x) for x in time.split('/')) if re.fullmatch(r'\d+/\d+', time) else (2, 4)
    bar_len = F(beats, beat)
    voices = []
    for (var, label), (line, keep, _, pbars) in zip(LABELS, kept):
        tokens, short = [], []
        for k, mi in enumerate(keep):
            evs = line[mi]
            if sum((e.length for e in evs), F(0)) != bar_len:
                short.append(pbars[mi]['number'] if mi < len(pbars) else str(mi + 1))
            tokens += [e.text() for e in evs]
            tokens.append('\\bar "||"\n' if k in ends else '|')
        if short:
            which = ('bars ' if len(short) > 1 else 'bar ') + ', '.join(short)
            verb = "don't" if len(short) > 1 else "doesn't"
            warnings.append(f'{label}: {which} {verb} add up to {time}')
        start, body = to_relative(' '.join(drop_repeated_lengths(' '.join(tokens).split())))
        body = re.sub(r'\s*\\bar "\|\|"\s*', ' \\\\bar "||"\n', body).strip()
        voices.append({'var': var, 'label': label, 'start': start, 'body': body})
    fifths = meta['fifths'] or 0
    mode = 'minor' if meta['mode'] == 'minor' else 'major'
    if meta['mode'] not in ('major', 'minor', ''):
        warnings.append(f'the score is marked {meta["mode"]}; the chant says {mode}')
    tonic = (FIFTHS_MINOR if mode == 'minor' else FIFTHS_MAJOR)[max(-7, min(7, fifths)) + 7]
    creator = next((c.text for c in root.iter('creator') if c.get('type') == 'composer' and c.text), '') or ''
    title = root.findtext('work/work-title') or root.findtext('movement-title') or ''
    return ({'key': {'tonic': tonic, 'mode': mode}, 'time': time, 'credit': creator.strip(), 'voices': voices},
            {'composer': creator.strip(), 'title': title.strip(), 'warnings': warnings})


if __name__ == '__main__':
    import chantedit
    with open(sys.argv[1], 'rb') as fh:
        parts, info = to_parts(fh.read(), sys.argv[1])
    print(chantedit.apply(chantedit.template(info['composer']), parts))
    for w in info['warnings']:
        print('warning:', w, file=sys.stderr)
