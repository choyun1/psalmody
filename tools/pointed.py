"""Plain-text pointed psalm format: parse, write, and convert from an older LilyPond layout.

Format
------
    Psalm 19 | Caeli enarrant
    % comment lines start with %

    1   The heavens declare the | glory . of | God, *
          and the | firma- . -ment | shows his | handiwork.

    6   It goes forth from the uttermost edge of the heavens
        and runs about to the | end of . it a- | -gain; *
          nothing is | hidden . from its | burning | heat.

    14  Let the words of my mouth and the meditation of my
        + heart be ac- | -ceptable . in your | sight, *
          O LORD, my | strength and | my re- | -deemer.

    †21 He has not done so to | any . other | nations; *

Symbols:  |  bar line        .  split (next note of the bar)     *  mediant
          re- | -vives   a word divided by the pointing (printed re'vives)
          loving- | kindness   a word that really has a hyphen (printed loving-'kindness)
          =word  held syllable (sung to both notes of a bar)        —  empty bar
          †  before a verse number: repeat the second half of the chant
          +  at the start of a line: wrapped continuation of the previous line
Lines up to and including the one with * are the first half; the rest are the second half.
Indentation is only for reading. LORD / GOD / YAHWEH are set in small caps automatically.
"""
import re

SMALLCAPS = ('LORD', 'GOD', 'YAHWEH')


# ---------------------------------------------------------------- parsing .txt
def load(path):
    """parse() of a text file."""
    with open(path, encoding='utf-8') as fh:
        return parse(fh.read())


def parse(text):
    """-> dict(title, latin, comments, verses=[dict(n, dagger, lines=[dict(text, half, wrap)])])"""
    title = latin = None
    comments, verses, cur = [], [], None
    for raw in text.splitlines():
        line = raw.rstrip()
        if not line.strip():
            continue
        if line.lstrip().startswith('%'):
            comments.append(line.lstrip()[1:].strip())
            continue
        if title is None:
            t, _, l = line.partition('|')
            title, latin = t.strip(), l.strip() or None
            continue
        m = re.match(r'^\s*(†)?\s*(\d+)\s+(.*)$', line)
        if m and (cur is None or not line.startswith(' ')):
            cur = {'n': int(m.group(2)), 'dagger': bool(m.group(1)), 'lines': [], 'seen_star': False}
            verses.append(cur)
            body = m.group(3)
        else:
            if cur is None:
                raise ValueError(f'text before first verse: {line!r}')
            body = line.strip()
        wrap = body.startswith('+ ')
        if wrap:
            body = body[2:]
        half = 2 if cur['seen_star'] else 1
        cur['lines'].append({'text': body.strip(), 'half': half, 'wrap': wrap})
        if re.search(r'(^|\s)\*(\s|$)', body):
            cur['seen_star'] = True
    for v in verses:
        v.pop('seen_star')
    return {'title': title, 'latin': latin, 'comments': comments, 'verses': verses}


def write(doc):
    out = [doc['title'] + (f" | {doc['latin']}" if doc.get('latin') else '')]
    out += ['% ' + c for c in doc.get('comments', [])]
    for v in doc['verses']:
        out.append('')
        num = ('†' if v['dagger'] else '') + str(v['n'])
        for i, ln in enumerate(v['lines']):
            t = ('+ ' if ln['wrap'] else '') + ln['text']
            if i == 0:
                out.append(f'{num:<4}{t}' if len(num) < 4 else f'{num} {t}')
            else:
                out.append(('    ' if ln['half'] == 1 else '      ') + t)
    return '\n'.join(out) + '\n'


# ------------------------------------------------- converting older .ly files
MACRO = {'LORD': 'LORD', 'LCOM': 'LORD,', 'LDOT': 'LORD.', 'LEXC': 'LORD!', 'LQUE': 'LORD?',
         'LSMC': 'LORD;', 'LCLN': 'LORD:', 'LRDS': "LORD'S", 'LQUO': "LORD's",
         'LDOTQUO': 'LORD."', 'LDTQ': 'LORD."', 'GCM': 'GOD,'}


def _brace_end(s, i):
    d = 0
    for j in range(i, len(s)):
        if s[j] == '{':
            d += 1
        elif s[j] == '}':
            d -= 1
            if d == 0:
                return j
    return len(s)


def _columns(src):
    out, started = [], False
    for m in re.finditer(r'\\markup\s*\{\s*(?:\\override\s+#\([^)]*\)\s*)?\\column\s*\{', src):
        body = src[m.end():_brace_end(src, m.end() - 1)]
        if '\\fontsize #4' in body:
            started = True
        if started:
            out.append(body)
    return '\n'.join(out)


def _lines(body):
    for m in re.finditer(r'\\line\s*\{', body):
        yield body[m.end():_brace_end(body, m.end() - 1)]


def _ly_to_plain(s):
    """One \\line body (after the layout prefix) -> plain pointed text."""
    s = re.sub(r'\{\\small\s+([^}]*)\}', r'\1', s)
    s = re.sub(r'\\bold\s*\{\\(L[A-Z]+|GCM)\}', lambda m: '=\\' + m.group(1), s)
    s = re.sub(r'\\bold\s*\{([^{}]*)\}', lambda m: '=' + m.group(1).strip().replace(' ', ' ='), s)
    s = re.sub(r'\\bold\s+', '=', s)
    s = re.sub(r'\\concat\s*\{([^{}]*)\}', lambda m: re.sub(r'\\hspace\s*#-?[\d.]+', '', m.group(1)).replace(' ', '\u0000'), s)  # glue
    s = re.sub(r'\\hspace\s*#-?[\d.]+', ' ', s)
    s = re.sub(r'\\(L[A-Z]+|GCM)\b', lambda m: MACRO[m.group(1)], s)
    s = s.replace('\\dot', ' . ')
    s = s.replace("''", '"')
    s = s.replace('\u0000', '')
    s = re.sub(r'\s+', ' ', s).strip()
    s = re.sub(r'\s+([,;:!?])', r'\1', s)           # "LORD ," (kerned in the source) -> "LORD,"
    s = re.sub(r'([^\s*])\*(?=\s|$)', r'\1 *', s)       # "LORD,*" -> "LORD, *"
    s = re.sub(r'(\S)\|', r'\1 |', s)
    s = re.sub(r'\|(\S)', r'| \1', s)
    # lone quote marks (left by hand-kerning in the source) attach to their word
    toks = s.split(' ')
    out = []
    for i, t in enumerate(toks):
        if t == '"':
            nxt = toks[i + 1] if i + 1 < len(toks) else None
            prev = out[-1] if out else None
            if nxt is None or nxt == '|' or (prev and prev not in ('|', '.') and re.search(r'[.,;:!?]$', prev)):
                if prev and prev != '|':
                    out[-1] = prev + '"'
                    continue
            toks[i + 1] = '"' + nxt if nxt else nxt
            continue
        out.append(t)
    return ' '.join(out)


def from_ly(src):
    body = _columns(src)
    title = latin = None
    verses, cur, star = [], None, False
    for ln in _lines(body):
        if '\\fontsize #4' in ln:
            t = re.search(r'\\fontsize #4\s*\{([^}]*)\}', ln)
            l = re.search(r'\\italic\s*\{([^}]*)\}', ln)
            title, latin = t.group(1).strip(), (l.group(1).strip() if l else None)
            continue
        if re.search(r'\\italic\s*"', ln) and '|' not in ln:     # composer credit line in Sunday files
            continue
        m = re.match(r'^\s*\\tab\s*(\\cross\s*)?(?:\\hspace\s*#(-?[\d.]+)\s*)?(\d+)\s+\\hspace\s*#[\d.]+\s*(.*)$', ln, re.S)
        if m:
            cur = {'n': int(m.group(3)), 'dagger': bool(m.group(1)), 'lines': []}
            verses.append(cur)
            star = False
            rest, indent = m.group(4), None
        else:
            m2 = re.match(r'^\s*\\tab\s*(?:\\hspace\s*#(-?[\d.]+))?\s*(.*)$', ln, re.S)
            if not m2 or cur is None:
                continue
            indent = float(m2.group(1)) if m2.group(1) else 0
            rest = m2.group(2)
        text = _ly_to_plain(rest)
        if not text:
            continue
        wrap = indent is not None and indent >= 10
        cur['lines'].append({'text': text, 'half': 2 if star else 1, 'wrap': wrap})
        if re.search(r'(^|\s)\*(\s|$)', text):
            star = True
    comments = []
    if 'UNPOINTED DRAFT' in src:
        comments.append('unpointed draft: text of the 1979 BCP, pointing still to be added')
    return {'title': title, 'latin': latin, 'comments': comments, 'verses': verses}


# --------------------------------------------- plain text -> pointing tokens
def tokens(text):
    """Split a plain line into tokens: words, '|', '.', '*'."""
    return re.findall(r'\||(?<!\S)\.(?!\S)|(?<!\S)\*(?!\S)|\S+', text)
