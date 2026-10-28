#!/usr/bin/env python3
"""Start a Sunday file from the lectionary.

    python tools/new_sunday.py 2026-11-08            # writes parish/sundays/2026-11-08.txt
    python tools/new_sunday.py 2026-11-08 --track 1  # the semicontinuous psalm in the season after Pentecost
    python tools/new_sunday.py 2026-11-08 --show     # print it instead of writing the file

The file comes pre-filled with the day, the appointed psalm and verses, the alternatives, and chants
whose moods match the text, best first, leaving out chants used in the last few months. Pick one,
edit anything you like, then run tools/build.py on it.
"""
import argparse, csv, datetime as dt, os, re, sys

TOOLS = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(TOOLS)
sys.path.insert(0, TOOLS)
import build, lectionary, paths   # noqa: E402

DEFAULT_TRACK = int(lectionary.PARISH.get('track', '2'))     # set in parish.txt
RECENT_WEEKS = 12


def read_csv(path):
    return list(csv.DictReader(open(path, encoding='utf-8'))) if os.path.exists(path) else []


def tags(s):
    return [t.strip() for t in re.split(r'[;,]', s or '') if t.strip()]


def groups():
    g = {}
    for line in open(os.path.join(ROOT, 'moods.txt'), encoding='utf-8'):
        line = line.split('#', 1)[0]
        if ':' in line:
            name, ts = line.split(':', 1)
            for t in ts.split(','):
                if t.strip():
                    g[t.strip()] = name.strip()
    return g


def score(text_tags, chant_tags, G):
    s, hits = 0.0, []
    for i, t in enumerate(text_tags):
        w = 1.0 if i == 0 else 0.75
        if t in chant_tags:
            s += w
            hits.append(t)
        elif any(G.get(c) and G.get(c) == G.get(t) for c in chant_tags):
            s += 0.4 * w
    return (s / len(text_tags) if text_tags else 0), hits


def history():
    rows = read_csv(paths.LEGACY_HISTORY)
    for path in sorted(os.listdir(paths.SUNDAYS)) if os.path.isdir(paths.SUNDAYS) else []:
        if path.endswith('.txt') and not path.startswith('_'):
            try:
                s = build.parse_sunday(os.path.join(paths.SUNDAYS, path))
                for item in s['items']:
                    for name, _ in item['chants']:
                        if name in ('???', '?'):
                            continue
                        rows.append({'date': s['date'], 'chant': name, 'text': item['spec']})
            except SystemExit:
                pass
    for r in rows:                    # 'Turle-2 down 2', and 'Turle-5' (a copy of it), are Turle-2
        if r.get('chant') and not r['chant'].startswith('tone:'):
            r['chant'] = paths.split_chant(r['chant'])[0]
    return rows


def text_moods(text_ids, verses):
    """Mood tags of the sections of these texts that overlap the verses being sung."""
    out = []
    for r in read_csv(os.path.join(ROOT, 'texts', 'moods.csv')):
        if r['text'] not in text_ids:
            continue
        if r['verses'] != 'all' and verses is not None:
            lo, _, hi = r['verses'].partition('-')
            rng = range(int(lo), int(hi or lo) + 1)
            if not any(v in rng for v in verses):
                continue
        for t in tags(r['mood']):
            if t not in out:
                out.append(t)
    return out


def suggest(spec, date, n=8):
    segs = build.resolve(spec)
    ids = [os.path.basename(p)[:-4] for p, _ in segs]
    verses = None if any(t is None for _, t in segs) else [v for _, t in segs for v in t]
    mood = text_moods(ids, verses)
    G = groups()
    hist = history()
    recent = {h['chant'] for h in hist
              if h['date'][:10] >= (date - dt.timedelta(weeks=RECENT_WEEKS)).isoformat() and h['date'][:10] < date.isoformat()}
    last = {}
    for h in hist:
        last[h['chant']] = max(last.get(h['chant'], ''), h['date'][:10])
    out = []
    for c in paths.catalog():
        s, hits = score(mood, tags(c.get('Mood')), G)
        if s > 0 and c['Chant'] not in recent:
            r = int(c['Rating']) if (c.get('Rating') or '').isdigit() else 0
            out.append((s, r, last.get(c['Chant'], ''), c, hits))
    out.sort(key=lambda x: (-x[0], -x[1], x[2]))
    return mood, out[:n], recent


def service_lines(date, service_name=None):
    """The rest of the service, in its order of service: what the imported record already has for
    the date, the service music carried on from last time, and blanks for the rest."""
    import service
    order = service.order_name(service_name, service.day_label(date))
    _, have = service.planned(date)
    have = dict((k, v) for k, v in have if k not in ('also', 'note'))
    _, prev = service.previous_service_music(date, order)
    out = ['', f'# The rest of the service ({order})']
    pad = lambda k: (k + ':').ljust(max(11, len(k) + 2))
    out.append(pad('organist') + have.get('organist', ''))
    for s in service.slots(order):
        v = have.get(s['key']) or (prev.get(s['key'], '') if s['kind'] == 'service' else '')
        if v or not s['optional']:
            out.append(pad(s['key']) + v)
    return out


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('date')
    ap.add_argument('--track', type=int, choices=(1, 2), default=DEFAULT_TRACK)
    ap.add_argument('--show', action='store_true')
    ap.add_argument('--force', action='store_true', help='overwrite an existing file')
    args = ap.parse_args()
    d = dt.date.fromisoformat(args.date)
    a = lectionary.appointed(d)
    if not a['psalm']:
        raise SystemExit(f"{d}: {a['label']} (Year {a['year']}): no psalm in reference/rcl_psalms.csv; write the file by hand")
    psalm, alts = a['psalm'], list(a['alt'])
    if a['key'] and a['key'].startswith('proper') and alts and args.track == 2:
        psalm, alts = alts[0], [a['psalm']] + alts[1:]
    spec = psalm.replace('Psalm ', '').replace('Ps. ', '')
    lines = [f"# {a['label']}, Year {a['year']}" + (f" (Track {args.track})" if a['key'] and a['key'].startswith('proper') else ''),
             f"date:    {d.isoformat()}"]
    if a['key'] in ('ash_wednesday', 'good_friday', 'maundy_thursday', 'easter_vigil'):
        lines.append(f"service: {a['label']}")
    skipped = []
    cands = [spec] + [x for x in alts]
    chosen = None
    for c in cands:
        c = c.replace('Ps. ', '').strip()
        try:
            build.resolve(c)
            chosen = c
            break
        except SystemExit as e:
            skipped.append((c, str(e)))
    if chosen is None:
        mood, sugg, recent = [], [], set()
        lines.append(f'psalm:   {spec}        # no text for any of the appointed psalms yet')
    else:
        mood, sugg, recent = suggest(chosen, d)
        note = ''
        if re.search(r'\d[a-d]\b', chosen):
            note = '        # a/b/c = part of a verse only; the whole verse is printed'
        lines.append(f'psalm:   {chosen}{note}')
        for c, why in skipped:
            lines.append(f'#   (appointed first: {c}, which is not in the library yet)')
    alts = [x for x in cands if x.replace('Ps. ', '').strip() != chosen]
    if alts:
        lines.append('#   or:  ' + '   or  '.join(alts))
    lines.append('chant:   ???                       # pick one; ideas below')
    lines += service_lines(d.isoformat(), next((l.split(':', 1)[1].strip() for l in lines if l.startswith('service:')), None))
    lines.append('')
    if sugg:
        lines.append(f"# Chants whose moods match ({', '.join(mood)}), leaving out ones used in the last {RECENT_WEEKS} weeks:")
        for s, r, last, c, hits in sugg:
            lines.append(f"#   {c['Chant']:<16} {c['Key']} {c['Mode'].lower():<6} {c['Single/Double'].lower():<7} "
                         f"{'★' * r:<5} shares: {', '.join(hits) or 'same family'}   last used: {last or 'never'}")
    else:
        lines.append(f"# Text moods: {', '.join(mood) or 'none'}. No chant matches yet: give chants mood tags in the browser.")
    text = '\n'.join(lines) + '\n'
    if args.show:
        print(text)
        return
    os.makedirs(paths.SUNDAYS, exist_ok=True)
    out = os.path.join(paths.SUNDAYS, d.isoformat() + '.txt')
    if os.path.exists(out) and not args.force:
        raise SystemExit(f'{os.path.relpath(out)} already exists (use --force to replace it)')
    open(out, 'w', encoding='utf-8').write(text)
    print(text)
    print('wrote ' + os.path.relpath(out))


if __name__ == '__main__':
    main()
