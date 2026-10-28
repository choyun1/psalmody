#!/usr/bin/env python3
"""The rest of the service (hymns, anthems, organ music, service music) and the weekly email.

    python tools/service.py email parish/sundays/2026-11-08.txt     # print the email and write its files
    python tools/service.py draft parish/sundays/2026-11-08.txt     # ...and put it in Gmail's Drafts
    python tools/service.py hymn 390                                 # look up a hymn: 390. Praise to the Lord…
    python tools/service.py orders                                   # list the orders of service
    python tools/service.py record                                   # every service so far -> schedule/record.csv

Which music a service has is set by its order of service in services.txt (or parish/services.txt):
Eucharist, Evensong, Palm Sunday, Good Friday… each with its own list. A Sunday file then carries the
music under those names as well as the psalm:

    service:    Evensong               # picks the order; without it, the order named like the day, else the first
    organist:   AYC
    prelude:    Prelude in A minor, BWV 543/1 - J. S. Bach (1685-1750)
    opening:    25                     # a hymn number: The Hymnal 1982 unless another book is named
    preces:     Preces & Responses - Anthony Piccolo (b. 1946)
    canticles:  Magnificat & Nunc dimittis - Jessica French (b. 1984)
    anthem:     Song for Athene - John Tavener (1944-2013)
    closing:    36
    postlude:   Fugue in A minor, BWV 543/2 - J. S. Bach (1685-1750)
    also:       Te Deum: Collegium Regale - Herbert Howells (1892-1983)    # anything else, listed where it stands
    note:       A line added to the email before the signature.

An anthem's words come from parish/anthems/ (one file per anthem; the planner writes them), so they're
typed once and turn up again whenever the anthem is sung.

The email (recipients, subject, greeting, wording, layout, signature, attachment names) is set up in
parish.txt; see parish.example/parish.txt. Its files go to output/<Sunday>/email/: the psalm images
(by default psalm_261025_chant.jpg, psalm_261025_text.jpg), the text, and a .eml file.
"""
import csv, datetime as dt, os, re, shutil, sys

TOOLS = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(TOOLS)
sys.path.insert(0, TOOLS)
import paths   # noqa: E402

# ------------------------------------------------------------------ orders of service
KINDS = ('hymn', 'anthem', 'service', 'music', 'lesson')
# the old spreadsheet's columns, for keys that share their name
DEFAULT_COLUMN = {'prelude': 'Prelude', 'opening': 'Opening', 'gloria in excelsis': 'Gloria', 'gradual': 'Gradual',
                  'offertory': 'Offertory', 'sanctus': 'Sanctus & Benedictus', 'agnus dei': 'Agnus dei',
                  'communion': 'Communion', 'closing': 'Closing', 'postlude': 'Postlude'}
ALIASES = {'gloria-in-excelsis': 'gloria in excelsis', 'lamb of god': 'agnus dei', 'agnus': 'agnus dei',
           'sanctus & benedictus': 'sanctus', 'opening hymn': 'opening', 'closing hymn': 'closing',
           'gradual hymn': 'gradual', 'offertory hymn': 'offertory', 'offertory anthem': 'offertory',
           'communion anthem': 'communion', 'communion hymn': 'communion'}


def services_file():
    own = os.path.join(paths.HOME, 'services.txt')
    return own if paths.PARISH and os.path.exists(own) else os.path.join(ROOT, 'services.txt')


META = {}            # order name -> {'subject': …, 'intro': …} from "email subject:" / "email intro:" lines


def load_orders(path=None):
    """services.txt -> {order name: [slot, ...]}, each slot {key, label, kind, optional, bare, words, columns}."""
    orders, cur = {}, None
    META.clear()
    path = path or services_file()
    if not os.path.exists(path):
        return {'Eucharist': [{'key': k, 'label': k.title(), 'kind': 'music', 'optional': False, 'columns': [c]}
                              for k, c in DEFAULT_COLUMN.items()]}
    for n, raw in enumerate(open(path, encoding='utf-8'), 1):
        line = raw.split('#', 1)[0].rstrip()
        if not line.strip():
            continue
        if not raw[0].isspace():
            cur = line.strip()
            orders[cur] = []
            META[cur] = {}
            continue
        if cur is None or ':' not in line:
            raise SystemExit(f'{path}, line {n}: expected "key: Label (kind)" under a service name')
        key, _, rest = line.strip().partition(':')
        if key.strip().lower() in ('email subject', 'email intro'):
            META[cur][key.strip().lower().split()[1]] = rest.strip()
            continue
        if key.strip().lower() == 'spreadsheet':            # "spreadsheet: no": not kept in the music schedule
            META[cur]['spreadsheet'] = rest.strip().lower() not in ('no', 'false', 'off')
            continue
        cols = []
        m = re.search(r'\[([^\]]*)\]\s*$', rest)
        if m:
            cols = [c.strip() for c in m.group(1).split(',') if c.strip()]
            rest = rest[:m.start()]
        kind, optional, bare, text, repeat = 'music', False, False, '', False
        m = re.search(r'\(([^)]*)\)\s*$', rest)
        if m:
            words = [w.strip().lower() for w in m.group(1).split(',')]
            if all(w in KINDS + ('optional', 'bare', 'repeat') or w.startswith('words=') for w in words):
                optional, bare, repeat = 'optional' in words, 'bare' in words, 'repeat' in words
                kind = next((w for w in words if w in KINDS), 'music')
                text = next((w[6:].strip() for w in words if w.startswith('words=')), '')
                rest = rest[:m.start()]
        key = key.strip().lower()
        orders[cur].append({'key': key, 'label': rest.strip() or key.title(), 'kind': kind, 'optional': optional,
                            'bare': bare, 'words': text, 'repeat': repeat,
                            'columns': cols or ([DEFAULT_COLUMN[key]] if key in DEFAULT_COLUMN else [])})
    return orders


ORDERS = load_orders()
KEYS = {s['key'] for o in ORDERS.values() for s in o} | set(ALIASES) | {'organist', 'also', 'note', 'lead'}


def order_name(service=None, label=None):
    """The order for a service: named by the service: line, else like the day, else the first."""
    names = list(ORDERS)
    for want in (service, label):
        if not want:
            continue
        for n in names:
            if n.lower() == want.lower():
                return n
        for n in names:                                   # "Christmas Eve (midnight)", "Evensong for All Saints"
            if n.lower() in want.lower() and n != names[0]:
                return n
    return names[0]


def day_label(date):
    try:
        import lectionary
        return lectionary.appointed(dt.date.fromisoformat(date[:10]))['label']
    except Exception:
        return ''


def order_of(sunday):
    svc = sunday.get('service') or ''
    return order_name(svc if svc != 'Eucharist' else None, day_label(sunday['date']))


def slots(order):
    return ORDERS.get(order) or ORDERS[next(iter(ORDERS))]


def slot(order, key):
    return next((s for s in slots(order) if s['key'] == key), None)


# ------------------------------------------------------------------ hymnals
BOOKS = {'EH1982': 'EH1982', 'H82': 'EH1982', 'EH': 'EH1982', 'HYMNAL1982': 'EH1982',
         'LEVAS': 'LEVAS', 'LEVAS2': 'LEVAS', 'LEVASII': 'LEVAS', 'WLP': 'WLP', 'EH1940': 'EH1940', 'EH1928': 'EH1928'}
_hymnals = None


def hymnals():
    global _hymnals
    if _hymnals is None:
        _hymnals = {}
        # hymnal indexes, <BOOK>.csv with columns number,title: in reference/hymnals/ or the parish's hymnals/
        for d in (os.path.join(ROOT, 'reference', 'hymnals'), os.path.join(paths.HOME, 'hymnals')):
            if not os.path.isdir(d):
                continue
            for f in sorted(os.listdir(d)):
                if f.endswith('.csv'):
                    _hymnals.setdefault(f[:-4], {}).update({r['number'].strip(): r['title'].strip()
                                        for r in csv.DictReader(open(os.path.join(d, f), encoding='utf-8'))})
        # your own wording wins: hymn_titles.csv (book,number,title) in the parish folder
        own = os.path.join(paths.HOME, 'hymn_titles.csv')
        if os.path.exists(own):
            for r in csv.DictReader(open(own, encoding='utf-8')):
                b = BOOKS.get(r['book'].strip().upper(), r['book'].strip())
                _hymnals.setdefault(b, {})[r['number'].strip()] = r['title'].strip()
    return _hymnals


HYMN_RE = re.compile(r'^(?:(?P<b1>[A-Za-z][A-Za-z0-9]*)\s+)?(?P<n>S\s?\d{1,3}|\d{1,3}[a-z]?)\.?'
                     r'(?:\s*\((?P<b2>[A-Za-z][A-Za-z0-9]*)\))?(?:\s+(?P<t>.+))?$')


def hymn(value):
    """'390' / 'LEVAS 114' / '114 (LEVAS2)' / '390 Praise to the Lord' / 'S278' -> dict, or None if not a hymn."""
    m = HYMN_RE.match((value or '').strip())
    if not m or (m.group('t') and ' - ' in m.group('t')):       # "1. Larghetto … - Handel" is a piece
        return None
    b = (m.group('b1') or m.group('b2') or 'EH1982').upper()
    if b not in BOOKS:
        return None
    book, num = BOOKS[b], m.group('n').replace(' ', '')
    title = (m.group('t') or '').strip() or hymnals().get(book, {}).get(num, '')
    return {'book': book, 'number': num, 'title': title, 'service': num.startswith('S')}


def hymn_text(h, show_book=True):
    if h['service']:
        return h['number'] + (f" ({h['title']})" if h['title'] and not show_book else '')
    s = h['number'] + ('. ' + h['title'] if h['title'] else '')
    return s + (f" ({h['book']})" if show_book else '')


# ------------------------------------------------------------------ anthems
def anthem_dir():
    return os.path.join(paths.HOME, 'anthems')


def slug(s):
    import unicodedata
    s = unicodedata.normalize('NFKD', s).encode('ascii', 'ignore').decode()
    s = re.sub(r"[’']", '', s.lower())
    return re.sub(r'[^a-z0-9]+', '-', s).strip('-')[:60] or 'anthem'


def split_piece(value):
    """'Title - Composer (dates)' -> (title, composer)"""
    title, sep, composer = (value or '').rpartition(' - ')
    return (title.strip(), composer.strip()) if sep else (value.strip(), '')


def read_anthem(path):
    head, _, body = open(path, encoding='utf-8').read().partition('\n\n')
    a = {'file': os.path.basename(path)[:-4], 'title': '', 'composer': '', 'source': '', 'text': body.strip('\n')}
    for line in head.splitlines():
        k, _, v = line.partition(':')
        k = k.strip().lower()
        if k in ('title', 'composer'):
            a[k] = v.strip()
        elif k in ('text', 'source', 'words'):
            a['source'] = v.strip()
    return a


def anthems():
    d = anthem_dir()
    return [read_anthem(os.path.join(d, f)) for f in sorted(os.listdir(d)) if f.endswith('.txt')] if os.path.isdir(d) else []


def _surname(composer):
    name = re.sub(r'\(.*?\)', '', composer).strip()
    return name.split()[-1].lower() if name else ''


def find_anthem(value, library=None):
    title, composer = split_piece(value)
    norm = lambda s: re.sub(r'[^a-z0-9]', '', s.lower())
    hits = [a for a in (library if library is not None else anthems()) if norm(a['title']) == norm(title)
            and (a['composer'] or not composer)]          # fixed words (the Magnificat) only when asked for
    if len(hits) > 1 and composer:
        hits = [a for a in hits if _surname(a['composer']) == _surname(composer)] or hits
    return hits[0] if hits else None


def write_anthem(title, composer, source, text):
    os.makedirs(anthem_dir(), exist_ok=True)
    old = find_anthem(f'{title} - {composer}' if composer else title)
    name = old['file'] if old else slug(title + ('-' + _surname(composer) if composer else ''))
    path = os.path.join(anthem_dir(), name + '.txt')
    head = [f'title:    {title}', f'composer: {composer}']
    if source:
        head.append(f'text:     {source}')
    open(path, 'w', encoding='utf-8').write('\n'.join(head) + '\n\n' + text.strip('\n') + '\n')
    return path



def hymns(value):
    """A hymn number, or several separated by commas or semicolons -> list of hymns; [] if not hymns."""
    v = (value or '').strip()
    if not v:
        return []
    parts = [p.strip() for p in re.split(r'\s*[;,]\s*', v) if p.strip()]
    if len(parts) > 1:
        hs = [hymn(p) for p in parts]
        if all(hs):
            return hs
    h = hymn(v)
    return [h] if h else []


def hymns_text(hs):
    return '; '.join(hymn_text(h) for h in hs)


def plain_hymns(hs):
    return ', '.join(h['number'] if h['service'] or h['book'] == 'EH1982' else f"{h['book']} {h['number']}" for h in hs)


# ------------------------------------------------------------------ the music of each service
def music(sunday):
    """The (key, value) service lines of a parsed Sunday, keys normalized, empty ones dropped."""
    return [(ALIASES.get(k, k), v) for k, v in sunday.get('music', []) if v.strip()]


def sunday_files():
    if not os.path.isdir(paths.SUNDAYS):
        return []
    return sorted(os.path.join(paths.SUNDAYS, f) for f in os.listdir(paths.SUNDAYS)
                  if f.endswith('.txt') and not f.startswith('_'))


def schedule():
    p = os.path.join(paths.HOME, 'schedule', 'schedule.csv')
    return list(csv.DictReader(open(p, encoding='utf-8'))) if os.path.exists(p) else []


LABELLED = re.compile(r"^([A-Z][\w' &]+?):\s+(.+)$")


def legacy_items(order, rows):
    """One date of the old spreadsheet -> (key, value) lines of the given order of service."""
    sl = slots(order)
    first_word = lambda s: s.lower().split()[0] if s.split() else ''
    got, extra = {}, []
    for r in rows:
        col, item = r['slot'], r['item'].strip()
        if not item or item.upper() == 'N/A' or col == 'Psalm':
            continue
        segs = []
        for part in re.split(r';\s+', item):
            segs += re.split(r",\s+(?=[A-Z][\w' ]*hymns?:\s)", part)
        cands = [s for s in sl if col in s['columns']]
        loose = []
        for seg in segs:
            seg = seg.strip()
            m = LABELLED.match(seg)
            target, value = None, seg
            if m:
                lab = m.group(1).lower()
                target = next((s for s in sl if s['label'].lower() == lab), None) or \
                    next((s for s in sl if lab.split()[0] == first_word(s['label'])
                          and not (re.search(r'hymns?$', lab) and not re.search(r'hymns?$', s['label'].lower()))), None)
                value = m.group(2)
                if target and target['key'] in got:
                    target = None
                if not target:
                    if hymns(value):
                        extra.append(f"{m.group(1)}: {plain_hymns(hymns(value))}")
                    else:
                        loose.append(seg)
                    continue
            else:
                for s in sl:                                      # "Kyrie S86 (EH1982)"
                    w = s['label'].split()[0]
                    if seg.lower().startswith(w.lower() + ' ') and hymns(seg[len(w):]):
                        target, value = s, seg[len(w):].strip()
                        break
            if target:
                got[target['key']] = plain_hymns(hymns(value)) if target['kind'] != 'music' and hymns(value) else value
            else:
                loose.append(seg)
        if loose:
            value = '; '.join(loose)
            free = [s for s in cands if s['key'] not in got]
            target = next((s for s in free if not s['optional']), free[0] if free else None)
            if target:
                got[target['key']] = plain_hymns(hymns(value)) if target['kind'] != 'music' and hymns(value) else value
            else:
                extra.append(f"{col}: {value}")
    keys = [s['key'] for s in sl]
    for k, v in list(got.items()):
        m = re.match(r'^(?:"?)Magnificat (?:&|and) Nunc dimittis(.*)$', v)
        if m and 'magnificat' in keys and 'nunc dimittis' in keys and k in ('magnificat', 'nunc dimittis'):
            got['magnificat'], got['nunc dimittis'] = 'Magnificat' + m.group(1), 'Nunc dimittis' + m.group(1)
    out = [(s['key'], got[s['key']]) for s in sl if s['key'] in got]
    org = next((r['organist'] for r in rows if r.get('organist') and r['organist'] != 'N/A'), '')
    return ([('organist', org)] if org else []) + out + [('also', e) for e in extra]


_services = None


def all_services(refresh=False):
    """Every service on record, oldest first: the old spreadsheet for dates without a Sunday file,
    then the Sunday files. Each is {date, name, order, items, source}."""
    global _services
    if _services is not None and not refresh:
        return _services
    import build
    out, covered = [], set()
    for p in sunday_files():
        try:
            s = build.parse_sunday(p)
        except SystemExit:
            continue
        items = music(s)
        name = os.path.basename(p)[:-4]
        if not s['date']:
            continue                                   # a psalm on its own, not a service
        if items:
            covered.add(s['date'][:10])
        out.append({'date': s['date'][:10], 'name': name, 'order': order_of(s), 'items': items, 'source': 'file',
                    'psalms': [(it['spec'], [n for n, _ in it['chants'] if n not in ('???', '?')]) for it in s['items']]})
    by = {}
    for r in schedule():
        by.setdefault(r['date'], []).append(r)
    for d, rows in by.items():
        if d in covered:
            continue
        occ = rows[0].get('occasion', '')
        order = order_name(occ, occ)
        ps = [(r['item'], []) for r in rows if r['slot'] == 'Psalm' and r['item'].strip().upper() != 'N/A']
        out.append({'date': d, 'name': d, 'order': order, 'items': legacy_items(order, rows), 'source': 'schedule',
                    'occasion': occ, 'psalms': ps})
    _services = sorted(out, key=lambda e: (e['date'], e['name']))
    return _services


def planned(date):
    """What the old spreadsheet had planned for a date (to fill in the planner)."""
    e = next((e for e in all_services() if e['date'] == date and e['source'] == 'schedule'), None)
    return (e['order'], e['items']) if e else (None, [])


def previous_service_music(date, order, name=None):
    """Service music of the most recent earlier service of the same order."""
    keys = [s['key'] for s in slots(order) if s['kind'] == 'service']
    for e in reversed(all_services()):
        if e['date'] >= date or e['name'] == name or e['order'] != order:
            continue
        sm = {k: v for k, v in e['items'] if k in keys}
        if sm:
            return e['date'], sm
    return '', {}


# ------------------------------------------------------------------ the email
def settings():
    import lectionary
    P = lectionary.PARISH
    return {
        'to': P.get('email_to', ''),
        'cc': P.get('email_cc', ''),
        'account': P.get('email_account', ''),
        'greeting': P.get('email_greeting', 'Hello,'),
        'subject': P.get('email_subject', 'Music for {mm}/{dd}'),
        'intro': P.get('email_intro', "Here's the music for {occasion}:"),
        'change': P.get('email_change', "There's a change to the service music this week:"),
        'rest': P.get('email_rest', "And here's the rest of the music for {occasion}:"),
        # the usual service's service music: listed only when it "changes" from last time, "always", or "never"
        'service_music': (P.get('email_service_music', 'changes').strip().lower() or 'changes').split()[0],
        'bullet': P.get('email_bullet', '*').strip(),
        'quotes': '' if P.get('email_quotes', 'none').strip().lower() in ('', 'none', 'no') else P['email_quotes'].strip(),
        'attachments': P.get('email_attachments', '').strip() or 'psalm_{yymmdd}_{kind}',
        'signature': [s.strip() for s in P.get('signature', '').split('|') if s.strip()],
    }


def occasion(sunday, order):
    d = dt.date.fromisoformat(sunday['date'][:10])
    if order != next(iter(ORDERS)):
        return order
    if d.weekday() == 6:
        return 'Sunday'
    return day_label(sunday['date']) or d.strftime('%A')


ORDINALS = ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eighth', 'Ninth', 'Tenth',
            'Eleventh', 'Twelfth']


def lessons():
    """parish/lessons.csv: reading -> the one-line summary printed with it (Lessons and Carols)."""
    p = os.path.join(paths.HOME, 'lessons.csv')
    return list(csv.DictReader(open(p, encoding='utf-8'))) if os.path.exists(p) else []


def lesson_key(ref):
    """'Genesis 3:1–22 or 3:1–15' -> 'genesis 3:1' (book, chapter and first verse)."""
    m = re.match(r'^\s*((?:\d\s*)?[A-Za-z]+)\s*(\d+)\s*:\s*(\d+)', ref.replace('–', '-'))
    return f'{m.group(1).lower().replace(" ", "")} {m.group(2)}:{m.group(3)}' if m else ref.strip().lower()


def split_lesson(v, lib=None):
    """'Genesis 3:1–22 | summary' -> (reading, summary); the summary from lessons.csv if not given."""
    ref, _, summary = v.partition('|')
    ref, summary = ref.strip(), summary.strip()
    if not summary:
        k = lesson_key(ref)
        summary = next((r['summary'] for r in (lib if lib is not None else lessons()) if lesson_key(r['reading']) == k), '')
    return ref, summary


def words_for(name, lib):
    """Fixed words (e.g. the Magnificat) from parish/anthems/<name>.txt, or the anthem titled so."""
    return next((a for a in lib if a['file'] == name), None) or find_anthem(name, lib)


def bullet(text, S=None):
    b = (S or settings())['bullet']
    return f'{b} {text}' if b else text


def item_line(s, v, lib, n=0, S=None):
    """One piece of music as the email lists it (plus its words). n counts lessons."""
    S = S or settings()
    if s['kind'] == 'lesson':
        ref, summary = split_lesson(v)
        name = f"The {ORDINALS[n - 1] if 0 < n <= len(ORDINALS) else str(n) + 'th'} {s['label']}"
        return [bullet(f"{name}: {ref}" + (f" ({summary})" if summary else ''), S)]
    hs = hymns(v) if s['kind'] in ('hymn', 'anthem') else []
    label = s['label'].replace('{hymn|anthem}', 'hymn' if hs else 'anthem')
    out = [bullet(v if s.get('bare') and not hs else f"{label}: {hymns_text(hs) if hs else v}", S)]
    if hs:
        return out
    a, head = None, 'Anthem text' if re.search(r'anthem', label, re.I) else f"{s['label']} text"
    if s.get('words'):
        a, head = words_for(s['words'], lib), 'Text'
    elif s['kind'] == 'anthem':
        a = find_anthem(v, lib)
    if a and a['text'].strip():
        out.append(f"{head}{' (' + a['source'] + ')' if a['source'] else ''}:")
        q = [S['quotes']] if S['quotes'] else []
        out += q + a['text'].strip('\n').splitlines() + q
    return out


def email(sunday, name):
    """Subject, recipients and body of the weekly email for a parsed Sunday."""
    S = settings()
    order = order_of(sunday)
    d = dt.date.fromisoformat(sunday['date'][:10])
    lines = [S['greeting'], '']
    items = music(sunday)
    given = dict(items)
    svc_slots = [s for s in slots(order) if s['kind'] == 'service']
    _, prev = previous_service_music(sunday['date'][:10], order, name)
    regular = order == next(iter(ORDERS))
    # the usual service: mention service music only when it changes; a special one: list it all
    changed = [s for s in svc_slots if regular and S['service_music'] == 'changes' and given.get(s['key']) and prev
               and given[s['key']] != prev.get(s['key'])]
    when = occasion(sunday, order)
    meta = META.get(order, {})
    day = d.day
    th = 'th' if 10 <= day % 100 <= 20 else {1: 'st', 2: 'nd', 3: 'rd'}.get(day % 10, 'th')
    fmt = dict(occasion=when, mm=f'{d.month:02d}', dd=f'{d.day:02d}', date=d.isoformat(), month=d.strftime('%B'),
               mon=d.strftime('%b'), day=day, dayth=f'{day}{th}', weekday=d.strftime('%A'), year=d.year)
    lead = ' '.join(v for k, v in items if k == 'lead')
    intro = (meta.get('intro') or S['intro']).format(**fmt)
    if changed:
        lines.append(S['change'].format(**fmt))
        for s in changed:
            hs = hymns(given[s['key']])
            lines.append(bullet(f"{s['label']} - {', '.join(h['number'] for h in hs) if hs and all(h['service'] for h in hs) else (hymns_text(hs) if hs else given[s['key']])}", S))
        lines += ['', S['rest'].format(**fmt) + (' ' + lead if lead else '')]
    else:
        lines.append(intro + (' ' + lead if lead else ''))
    lib = anthems()
    notes, nlesson = [], 0
    for k, v in items:
        if k == 'note':
            notes.append(v)
        elif k == 'lead':
            continue
        elif k == 'also':
            lines.append(bullet(v, S))
        elif k != 'organist':
            s = slot(order, k) or next((x for o in ORDERS.values() for x in o if x['key'] == k), None)
            if s and s['kind'] == 'service':
                if not regular or S['service_music'] == 'always':
                    hs = hymns(v)
                    lines.append(bullet(f"{s['label']}: {', '.join(h['number'] for h in hs) if hs else v}", S))
            elif s:
                if s['kind'] == 'lesson':
                    nlesson += 1
                lines += item_line(s, v, lib, nlesson, S)
    if notes:
        lines += [''] + notes
    lines += [''] + S['signature']
    return {'subject': (meta.get('subject') or S['subject']).format(**fmt),
            'to': S['to'], 'cc': S['cc'], 'account': S['account'], 'body': '\n'.join(lines) + '\n', 'order': order}


def attachments(name, date):
    """Copy the admin images to output/<name>/email/ under the names the office knows (email_attachments:
    in parish.txt, with {yymmdd}, {date}, {mm}, {dd}, {kind} = chant, text or tone; a number is added for a second)."""
    src = os.path.join(paths.OUTPUT, name, 'admin')
    dst = os.path.join(paths.OUTPUT, name, 'email')
    if os.path.isdir(dst):
        shutil.rmtree(dst)
    os.makedirs(dst)
    if not os.path.isdir(src):
        return dst, []
    extra = name[10:] if name.startswith(date) else ''              # 2026-12-24-midnight -> 261224-midnight
    pattern = settings()['attachments']
    count, out = {}, []
    for f in sorted(os.listdir(src)):
        if not f.endswith('.jpg'):
            continue
        kind = 'text' if '_text_' in f else 'tone' if '_tone_' in f else 'chant'
        count[kind] = count.get(kind, 0) + 1
        n = count[kind]
        stem = pattern.format(yymmdd=date[2:4] + date[5:7] + date[8:10] + extra, date=date + extra, mm=date[5:7],
                              dd=date[8:10], kind=kind)
        target = os.path.join(dst, f'{stem}{"" if n == 1 else n}.jpg')
        shutil.copy(os.path.join(src, f), target)
        out.append(target)
    return dst, out


def message(e, files, name):
    from email.message import EmailMessage
    from email.utils import formatdate, make_msgid
    m = EmailMessage()
    if e['account']:
        m['From'] = e['account']
    m['To'], m['Subject'], m['Date'] = e['to'], e['subject'], formatdate(localtime=True)
    if e['cc']:
        m['Cc'] = e['cc']
    m['Message-ID'] = make_msgid()
    m['X-Psalter-Draft'] = name                       # lets the next draft of the same Sunday replace this one
    m.set_content(e['body'])
    for f in files:
        m.add_attachment(open(f, 'rb').read(), maintype='image', subtype='jpeg', filename=os.path.basename(f))
    return m


def write_email(path, body=None):
    """Write the email's files; body = the text as edited in the planner, if any."""
    import build
    sunday = build.parse_sunday(path)
    name = os.path.basename(path)[:-4]
    e = email(sunday, name)
    if body:
        e['body'] = body if body.endswith('\n') else body + '\n'
    dst, files = attachments(name, sunday['date'][:10])
    open(os.path.join(dst, 'email.txt'), 'w', encoding='utf-8').write(
        f"To: {e['to']}\nCc: {e['cc']}\nSubject: {e['subject']}\n\n{e['body']}")
    m = message(e, files, name)
    m['X-Unsent'] = '1'                               # Outlook opens it as a draft
    eml = os.path.join(dst, (re.sub(r'[\\/:*?"<>|]+', '-', e['subject']).strip() or 'email') + '.eml')
    open(eml, 'wb').write(bytes(m))
    e.update(files=files, eml=eml, folder=dst, name=name)
    return e


def draft(path, body=None):
    """Write the email and put it in Gmail's Drafts, replacing an earlier draft of the same Sunday."""
    import gmail
    e = write_email(path, body)
    if not e['account']:
        raise SystemExit('set email_account in parish.txt first')
    replaced = gmail.save_draft(e['account'], bytes(message(e, e['files'], e['name'])), e['name'], e['subject'])
    e['replaced'] = replaced
    e['link'] = gmail.drafts_link(e['account'])
    return e


# ------------------------------------------------------------------ the record (replaces the spreadsheet)
def schedule_rows():
    """Every service, one row per piece: date, service, organist, slot, item."""
    rows = []
    for e in all_services():
        org = next((v for k, v in e['items'] if k == 'organist'), '')
        base = {'date': e['date'], 'service': e.get('occasion') or e['order'], 'organist': org}
        for spec, ch in e['psalms']:
            rows.append(dict(base, slot='Psalm', item=spec + (f" ({', '.join(c.replace('tone:', 'Tone ') for c in ch)})" if ch else ''), kind='psalm', key='psalm'))
        for k, v in e['items']:
            if k in ('organist', 'note', 'lead'):
                continue
            s = slot(e['order'], k)
            rows.append(dict(base, slot=s['label'].replace(' {hymn|anthem}', '') if s else ('Other' if k == 'also' else k), item=v,
                             kind=s['kind'] if s else 'music', key=k))
    return rows


def family(key, kind):
    return 'anthem' if kind == 'anthem' else 'organ' if key in ('prelude', 'postlude') else key


def repertoire():
    """Everything done before, by family (organ, anthem, preces…): {family: [[item, [dates]], ...]}."""
    out = {}
    for r in schedule_rows():
        if r['kind'] in ('psalm', 'hymn', 'service') or r['key'] == 'also' or hymns(r['item']):
            continue
        out.setdefault(family(r['key'], r['kind']), {}).setdefault(r['item'].strip(), set()).add(r['date'])
    return {f: sorted(([item, sorted(ds)] for item, ds in v.items()), key=lambda x: x[1][-1], reverse=True)
            for f, v in out.items()}


def hymn_history():
    """'EH1982 390' -> dates sung."""
    out = {}
    for r in schedule_rows():
        if r['kind'] in ('hymn', 'anthem') or r['key'] == 'also':
            v = r['item'].split(':', 1)[1] if r['key'] == 'also' and ':' in r['item'] else r['item']
            for h in hymns(v):
                if not h['service']:
                    out.setdefault(f"{h['book']} {h['number']}", []).append(r['date'])
    return out


def main():
    a = sys.argv[1:]
    if len(a) >= 2 and a[0] in ('email', 'draft'):
        e = draft(a[1]) if a[0] == 'draft' else write_email(a[1])
        print(f"To: {e['to']}\nCc: {e['cc']}\nSubject: {e['subject']}\n\n{e['body']}")
        print('Attachments: ' + (', '.join(os.path.basename(f) for f in e['files']) or 'none yet (build the images first)'))
        print('Email files: ' + os.path.relpath(e['folder']))
        if a[0] == 'draft':
            print('Saved in Gmail Drafts' + (' (replacing the earlier draft)' if e['replaced'] else '') + ': ' + e['link'])
    elif a and a[0] == 'record':
        out = os.path.join(paths.HOME, 'schedule', 'record.csv')
        os.makedirs(os.path.dirname(out), exist_ok=True)
        rows = schedule_rows()
        with open(out, 'w', newline='', encoding='utf-8') as fh:
            w = csv.DictWriter(fh, fieldnames=['date', 'service', 'organist', 'slot', 'item'], extrasaction='ignore')
            w.writeheader()
            w.writerows(rows)
        print(f'{len(rows)} rows -> {os.path.relpath(out)}')
    elif a and a[0] == 'orders':
        print('from ' + os.path.relpath(services_file()))
        for n, sl in ORDERS.items():
            print(f"\n{n}\n" + '\n'.join(f"  {s['key'] + ':':<20}{s['label']:<30}{s['kind']}{', optional' if s['optional'] else ''}" for s in sl))
    elif len(a) >= 2 and a[0] == 'hymn':
        hs = hymns(' '.join(a[1:]))
        print(hymns_text(hs) if hs else 'not a hymn number')
    else:
        print(__doc__)


if __name__ == '__main__':
    main()
