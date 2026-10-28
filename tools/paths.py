"""Where things live.

The psalter (this folder) is the general part: tools, style, texts, public-domain chants, lectionary,
tones. Everything belonging to one parish lives in its own folder, `parish/` inside this one
(its own private git repository):

    parish/parish.txt          name, lectionary track, patronal feast, Christmas psalms
    parish/chant_notes.csv     your ratings, mood tags and notes on every chant
    parish/chants/             chants you may not publish (still under copyright), with catalog.csv
    parish/sundays/            one file per Sunday or service
    parish/output/             the PDFs and images built from them
    parish/site/               the chant browser, built for this parish
    parish/legacy/             anything from before (old files, history.csv)

Without a parish folder the tools still work, using the psalter folder for those things.
"""
import csv, os

CORE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
_p = os.path.join(CORE, 'parish')
PARISH = _p if os.path.isdir(_p) else None
HOME = PARISH or CORE                       # where the parish's own files go

PARISH_TXT = os.path.join(HOME, 'parish.txt')
NOTES = os.path.join(HOME, 'chant_notes.csv')
SUNDAYS = os.path.join(HOME, 'sundays')
OUTPUT = os.path.join(HOME, 'output')
SITE = os.path.join(HOME, 'site')
LEGACY_HISTORY = os.path.join(HOME, 'legacy', 'history.csv')
CHANT_DIRS = [os.path.join(CORE, 'chants')] + ([os.path.join(PARISH, 'chants')] if PARISH else [])
# psalm texts: the general folder has the 1979 BCP words (unpointed unless the pointing may be published);
# a parish's own pointed copies, in parish/texts/, take their place
TEXT_DIRS = [os.path.join(CORE, 'texts')] + ([os.path.join(PARISH, 'texts')] if PARISH else [])
OWN_TEXTS = TEXT_DIRS[-1]                   # where pointing done in the browser is saved

CATALOG_COLUMNS = ['Chant', 'Composer', 'Years', 'Key', 'Mode', 'Single/Double', 'Source', 'ACP Psalm']
NOTE_COLUMNS = ['Chant', 'Rating', 'Mood', 'Notes', 'Pin']    # Pin: favorite, to try


def text_file(name):
    """The text a name refers to (e.g. Psalm_019): the parish's pointed copy if it has one."""
    for d in reversed(TEXT_DIRS):
        p = os.path.join(d, name + '.txt')
        if os.path.exists(p):
            return p
    return None


def text_names():
    """Every text, by name, from both folders."""
    out = set()
    for d in TEXT_DIRS:
        if os.path.isdir(d):
            out |= {f[:-4] for f in os.listdir(d) if f.endswith('.txt')}
    return sorted(out)


def chant_file(name):
    for d in reversed(CHANT_DIRS):           # a parish copy wins over the public one
        p = os.path.join(d, name + '.ly')
        if os.path.exists(p):
            return p
    return None


def _read(path):
    if not os.path.exists(path):
        return []
    with open(path, encoding='utf-8', newline='') as fh:
        return list(csv.DictReader(fh))


def catalog():
    """Every chant: the facts from each catalog.csv, plus your rating, mood and notes."""
    rows, seen = [], {}
    for d in CHANT_DIRS:
        for r in _read(os.path.join(d, 'catalog.csv')):
            r = {k: r.get(k, '') for k in CATALOG_COLUMNS}
            r['private'] = d != CHANT_DIRS[0]
            if r['Chant'] in seen:
                rows[seen[r['Chant']]] = r
            else:
                seen[r['Chant']] = len(rows)
                rows.append(r)
    notes = {r['Chant']: r for r in _read(NOTES)}
    for r in rows:
        n = notes.get(r['Chant'], {})
        for k in NOTE_COLUMNS[1:]:
            r[k] = n.get(k, '')
    return rows


def write_notes(rows):
    """rows: dicts with Chant, Rating, Mood, Notes, Pin."""
    os.makedirs(os.path.dirname(NOTES), exist_ok=True)
    with open(NOTES, 'w', encoding='utf-8', newline='') as fh:
        w = csv.DictWriter(fh, NOTE_COLUMNS, extrasaction='ignore')
        w.writeheader()
        for r in rows:
            if any((r.get(k) or '').strip() for k in NOTE_COLUMNS[1:]):
                w.writerow(r)
