"""A chant from MusicXML (exported by MuseScore, Finale, Sibelius, Dorico…), in the layout of the chant files.

    python tools/musicxml.py chant.musicxml          # print the chant file it makes

The four voices are found whichever way the score is laid out: four parts (Soprano, Alto, Tenor, Bass),
or two staves with two voices each (an SATB "closed score"), in score order. Each becomes a voice of the
chant (S_notes, A_notes, T_notes, B_notes) in LilyPond's relative notes, with its bars; a double barline
in the score ends a phrase (\\bar "||"). Without any, a chant of 7 bars is taken as single (3 + 4) and of 14
as double (3 + 4 + 3 + 4). The key, the time and the composer come from the score too.
"""
import io, os, re, sys, zipfile
import xml.etree.ElementTree as ET

TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)

FIFTHS_MAJOR = ['ces', 'ges', 'des', 'aes', 'ees', 'bes', 'f', 'c', 'g', 'd', 'a', 'e', 'b', 'fis', 'cis']   # -7 … 7
FIFTHS_MINOR = ['aes', 'ees', 'bes', 'f', 'c', 'g', 'd', 'a', 'e', 'b', 'fis', 'cis', 'gis', 'dis', 'ais']


def read(data, filename=''):
    """The score's XML from a .musicxml/.xml file or a compressed .mxl (bytes)."""
    if data[:2] == b'PK' or filename.lower().endswith('.mxl'):
        z = zipfile.ZipFile(io.BytesIO(data))
        names = z.namelist()
        try:
            root = ET.fromstring(z.read('META-INF/container.xml'))
            path = next(e.get('full-path') for e in root.iter() if e.tag.endswith('rootfile'))
        except (KeyError, StopIteration):
            path = next(n for n in names if n.endswith(('.xml', '.musicxml')) and not n.startswith('META-INF'))
        data = z.read(path)
    root = ET.fromstring(data)
    for e in root.iter():                               # namespaces aside
        e.tag = e.tag.split('}')[-1]
    if root.tag != 'score-partwise':
        raise ValueError('only "partwise" MusicXML is read (what MuseScore, Finale, Sibelius and Dorico export)')
    return root


def lily_pitch(p):
    step, octave = p.findtext('step').lower(), int(p.findtext('octave'))
    alter = int(float(p.findtext('alter') or 0))
    acc = {-2: 'eses', -1: 'es', 0: '', 1: 'is', 2: 'isis'}[alter]
    name = step + acc
    marks = octave - 3                                     # LilyPond's c is the C below middle C (octave 3)
    return name + ("'" * marks if marks > 0 else "," * -marks)


def lily_dur(divs, per_quarter):
    """A length in divisions -> LilyPond's 2, 4., 8 … (None if it isn't a plain or dotted note)."""
    from fractions import Fraction as F
    whole = F(divs, per_quarter * 4)
    for base in (1, 2, 4, 8, 16, 32):
        for dots in range(3):
            if F(1, base) * (2 - F(1, 2 ** dots)) == whole:
                return str(base) + '.' * dots
    if whole == 2:
        return '\\breve'
    return None


def streams(root):
    """[(part name, staff, voice, [measures: [(kind, lily text)]], double bars after measure i)] in score order."""
    names = {sp.get('id'): (sp.findtext('part-name') or '') for sp in root.iter('score-part')}
    out = {}
    order = []
    meta = {'fifths': 0, 'mode': 'major', 'time': '', 'doubles': set()}
    for part in root.findall('part'):
        per_quarter = 1
        for mi, m in enumerate(part.findall('measure')):
            a = m.find('attributes')
            if a is not None:
                per_quarter = int(a.findtext('divisions') or per_quarter)
                k = a.find('key')
                if k is not None and mi == 0:
                    meta['fifths'], meta['mode'] = int(k.findtext('fifths') or 0), (k.findtext('mode') or 'major')
                t = a.find('time')
                if t is not None and mi == 0:
                    meta['time'] = f"{t.findtext('beats')}/{t.findtext('beat-type')}"
            for b in m.findall('barline'):
                if (b.findtext('bar-style') or '') in ('light-light', 'light-heavy', 'heavy-heavy'):
                    meta['doubles'].add(mi)
            for n in m.findall('note'):
                if n.find('grace') is not None:
                    continue
                staff, voice = n.findtext('staff') or '1', n.findtext('voice') or '1'
                key = (part.get('id'), staff, voice)
                if key not in out:
                    out[key] = {}
                    order.append(key)
                notes = out[key].setdefault(mi, [])
                dur = lily_dur(int(n.findtext('duration') or 0), per_quarter) if n.find('duration') is not None else None
                if n.find('chord') is not None and notes:           # another note of a chord: <a c> in the voice
                    notes[-1] = ('chord', _add_to_chord(notes[-1][1], lily_pitch(n.find('pitch'))))
                    continue
                tie = any(t.get('type') == 'start' for t in n.findall('tie'))
                if n.find('rest') is not None:
                    notes.append(('rest', 'r' + (dur or '')))
                else:
                    notes.append(('note', lily_pitch(n.find('pitch')) + (dur or '') + ('~' if tie else '')))
    return [(names.get(k[0], ''), k[1], k[2], out[k]) for k in order], meta


def _add_to_chord(txt, p):
    """'c'2~' + "e'" -> "<c' e'>2~"; '<c' e'>2' + "g'" -> "<c' e' g'>2"."""
    m = re.match(r"^<([^>]*)>(.*)$", txt) or re.match(r"^([a-g](?:is|es)*[',]*)(.*)$", txt)
    return '<' + ' '.join(m.group(1).split() + [p]) + '>' + m.group(2)


NOTE = re.compile(r"^(<[^>]*>|[a-gr](?:is|es)*[',]*)(\\breve|\d+\.*)?(~?)$")


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


def _height(head):
    """"fis'" -> a number that orders pitches (semitones from the c below middle C)."""
    m = re.match(r"^([a-g])((?:is|es)*)([',]*)$", head)
    acc = m.group(2).count('is') - m.group(2).count('es')
    return 'c d ef g a b'.index(m.group(1)) + acc + 12 * (m.group(3).count("'") - m.group(3).count(','))


def split_chords(ms):
    """A staff written as two-note chords (soprano and alto on one stem) -> (upper voice, lower voice);
    a single note is sung by both. None if it isn't written that way."""
    upper, lower, chords = {}, {}, 0
    for mi, notes in ms.items():
        upper[mi], lower[mi] = [], []
        for kind, txt in notes:
            m = NOTE.match(txt)
            if kind == 'chord':
                heads = sorted(m.group(1)[1:-1].split(), key=_height)
                if len(heads) != 2:
                    return None
                chords += 1
                upper[mi].append(('note', heads[1] + (m.group(2) or '') + m.group(3)))
                lower[mi].append(('note', heads[0] + (m.group(2) or '') + m.group(3)))
            else:
                upper[mi].append((kind, txt))
                lower[mi].append((kind, txt))
    return (upper, lower) if chords else None


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


def to_relative(absolute):
    """'aes'2 ees'4 …' (absolute) -> ("c''", 'as2 es4 …') for \\relative."""
    import ly.document, ly.pitch.abs2rel
    d = ly.document.Document('{ ' + absolute + ' }')
    ly.pitch.abs2rel.abs2rel(ly.document.Cursor(d))
    m = re.match(r"^\\relative\s+(\S+)\s*\{(.*)\}\s*$", d.plaintext().strip(), re.S)
    if not m:
        raise ValueError('could not turn the notes into relative ones')
    return m.group(1), m.group(2).strip()


def to_parts(data, filename=''):
    """-> (parts as chantedit.parts gives them, {'composer', 'title'}) from a MusicXML file's bytes."""
    root = read(data, filename)
    found, meta = streams(root)
    voiced = [s for s in found if any(k == 'note' or k == 'chord' for ms in s[3].values() for k, _ in ms)]
    if len(voiced) < 4:                                    # chords on a stem: two voices each
        voiced = [v for s in voiced for v in ([s[:3] + (h,) for h in split_chords(s[3])] if split_chords(s[3]) else [s])]
    if len(voiced) < 4:
        raise ValueError(f'found {len(voiced)} voice(s); a chant has four (Soprano, Alto, Tenor, Bass)')
    n_measures = max(max(s[3]) for s in voiced) + 1
    ends = set(phrase_ends(n_measures, meta['doubles']))
    labels = [('S_notes', 'Soprano'), ('A_notes', 'Alto'), ('T_notes', 'Tenor'), ('B_notes', 'Bass')]
    voices = []
    for (var, label), (_, _, _, ms) in zip(labels, voiced[:4]):
        lines, line = [], []
        for mi in range(n_measures):
            bar = ' '.join(t for _, t in ms.get(mi, [])) or 'r1'
            line.append(bar)
            if mi in ends:
                lines.append(' | '.join(line) + ' \\bar "||"')
                line = []
        if line:
            lines.append(' | '.join(line))
        start, body = to_relative(' '.join(drop_repeated_lengths(' '.join(lines).split())))
        voices.append({'var': var, 'label': label, 'start': start, 'body': body.replace(' \\bar "||" ', ' \\bar "||"\n')})
    mode = 'minor' if meta['mode'] == 'minor' else 'major'
    tonic = (FIFTHS_MINOR if mode == 'minor' else FIFTHS_MAJOR)[max(-7, min(7, meta['fifths'])) + 7]
    creator = next((c.text for c in root.iter('creator') if c.get('type') == 'composer' and c.text), '')
    title = root.findtext('work/work-title') or root.findtext('movement-title') or ''
    return ({'key': {'tonic': tonic, 'mode': mode}, 'time': meta['time'] or '2/4', 'credit': creator.strip(),
             'voices': voices}, {'composer': creator.strip(), 'title': title.strip()})


if __name__ == '__main__':
    import chantedit
    data = open(sys.argv[1], 'rb').read()
    parts, info = to_parts(data, sys.argv[1])
    print(chantedit.apply(chantedit.template(info['composer']), parts))
