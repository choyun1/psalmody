"""Suggested moods for chants not yet tagged: a starting point to accept or change, never saved by itself.

    python tools/moodsuggest.py            # every untagged chant's suggestions, with the reasons
    python tools/moodsuggest.py --check    # how often the suggestions agree with the chants you've tagged

There's no reference that gives a chant's mood, so this weighs what can be read from the music and
the catalog, and learns from the moods you've already given:

- the mode: major chants lean bright and calm, minor ones shadowed and dark (modal ones mysterious);
- your own habit: the moods you give most often to chants of that mode count for more as you tag;
- how the tune moves: a high soprano lifts toward bright; big leaps toward dramatic or triumphant;
  stepwise, narrow, slow-moving lines toward serene or tender (major) and plaintive or penitent (minor);
  chromatic notes toward yearning, mysterious or anguished;
- the psalms the Anglican Chant Psalter sets it to: their moods (texts/moods.csv), where they suit the mode.
"""
import collections, os, re, sys

TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)
import paths   # noqa: E402

BASE = {   # the starting weight of each mood, by mode
    'major': {'joyful': .6, 'bright': .5, 'confident': .3, 'serene': .3},
    'minor': {'mournful': .6, 'plaintive': .6, 'wistful': .3, 'penitent': .3},
    'modal': {'mysterious': .8, 'mystical': .7, 'serene': .3, 'plaintive': .3},
}
# how the tune moves, measured against all the chants (+1 = one standard deviation above the usual), and the
# moods each tendency leans toward, by mode
LEANS = {
    'major': {'chromatic': {'tender': .7, 'sweet': .5, 'yearning': .3}, 'high': {'jubilant': .6, 'triumphant': .4, 'bright': .3},
              'leaps': {'majestic': .4, 'confident': .4, 'triumphant': .2}, 'stepwise': {'serene': .5, 'delicate': .3, 'confident': .2}},
    'minor': {'chromatic': {'mysterious': .7, 'anguished': .4, 'yearning': .4}, 'high': {'wistful': .4, 'yearning': .3},
              'leaps': {'dramatic': .6, 'anguished': .4, 'stern': .3}, 'stepwise': {'penitent': .4, 'gloomy': .4}},
    'modal': {'chromatic': {'mysterious': .5}, 'high': {'mystical': .3}, 'leaps': {'dramatic': .3}, 'stepwise': {'serene': .4}},
}
WORDS = {'chromatic': 'chromatic notes', 'high': 'a high soprano', 'leaps': 'leaps in the tune', 'stepwise': 'a stepwise tune'}
FITS = {'major': {'bright', 'calm'}, 'minor': {'shadowed', 'dark'}, 'modal': {'calm', 'shadowed'}}   # moods' groups that suit


def groups():
    g = {}
    for line in paths.read(os.path.join(paths.CORE, 'moods.txt')).splitlines():
        line = line.split('#', 1)[0]
        if ':' in line:
            name, tags = line.split(':', 1)
            for t in tags.split(','):
                if t.strip():
                    g[t.strip()] = name.strip()
    return g


def text_moods():
    """{text id: Counter of moods over its sections}"""
    out = collections.defaultdict(collections.Counter)
    for r in paths._read(os.path.join(paths.CORE, 'texts', 'moods.csv')):
        for t in re.split(r'[;,]', r.get('mood', '')):
            if t.strip():
                out[r['text']][t.strip()] += 1
    return out


def acp_texts(acp):
    """'14, 74, 18-1' -> ['Psalm_014', 'Psalm_074', 'Psalm_018_Part_1']"""
    out = []
    for part in re.split(r'[,;]\s*', acp or ''):
        m = re.match(r'^(\d+)(?:-(\d+))?$', part.strip())
        if m:
            out.append(f'Psalm_{int(m.group(1)):03d}' + (f'_Part_{m.group(2)}' if m.group(2) else ''))
    return out


def mode_of(row):
    m = (row.get('Mode') or '').strip().lower()
    return 'major' if m.startswith('maj') else 'minor' if m.startswith('min') else 'modal'


def features(voices, key_pc):
    """What the tune does: how high the soprano sits, how often it leaps or steps, how chromatic the harmony is."""
    sop = [e[0] for e in (voices.get('S_notes') or voices.get('Unison_notes') or [])]
    if len(sop) < 4:
        return {}
    steps = [abs(b - a) for a, b in zip(sop, sop[1:])]
    scale = {(key_pc + i) % 12 for i in (0, 2, 3, 4, 5, 7, 8, 9, 10, 11)}     # the key's notes, major or minor
    allp = [e[0] for evs in voices.values() for e in evs]
    return {'high': sum(sop) / len(sop), 'leaps': sum(s >= 5 for s in steps) / len(steps),
            'stepwise': sum(s <= 2 for s in steps) / len(steps),
            'chromatic': sum(p % 12 not in scale for p in allp) / len(allp)}


def standardize(feats):
    """{chant: {feature: value}} -> the same measured in standard deviations from the mean of all chants."""
    import statistics as st
    keys = {k for f in feats.values() for k in f}
    mu = {k: st.mean(f[k] for f in feats.values() if k in f) for k in keys}
    sd = {k: st.pstdev([f[k] for f in feats.values() if k in f]) or 1 for k in keys}
    return {c: {k: (v - mu[k]) / sd[k] for k, v in f.items()} for c, f in feats.items()}


def suggest(row, z, tagged, tmoods, G, n=3):
    """-> (moods, reasons) for one chant. z: its tune, standardized; tagged: [(mode, [moods])] you've tagged."""
    mode = mode_of(row)
    score = collections.Counter(BASE[mode])
    why = [mode]
    same = [ms for md, ms in tagged if md == mode]
    if same:                                               # your habit with chants of this mode
        habit = collections.Counter(t for ms in same for t in ms)
        for t, k in habit.items():
            score[t] += .6 * k / len(same)
    for feat, leans in LEANS[mode].items():
        x = (z or {}).get(feat, 0)
        if x > .5:
            for t, w in leans.items():
                score[t] += w * x
            why.append(WORDS[feat])
    psalms = acp_texts(row.get('ACP Psalm'))
    fit = [t for p in psalms for t in tmoods.get(p, ()) if G.get(t) in FITS[mode]]
    for t in fit:
        score[t] += .4 / max(1, len(psalms))
    if fit:
        why.append('the ACP sets it to ' + ', '.join(sorted({'Ps ' + p.split('_')[1].lstrip('0') for p in psalms}, key=lambda x: int(x[3:]))))
    best = [t for t, sc in score.most_common() if sc > .45 and t in G][:n]
    return best, why


def _tunes():
    """{chant: standardized tune features} for every chant with a file."""
    import chantinfo
    feats = {}
    for r in paths.catalog():
        f = paths.chant_file(r['Chant'])
        if not f:
            continue
        try:
            info = chantinfo.info(f)
        except Exception:
            continue
        k = info['key']
        pc = {'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11}.get(k[:1], 0) + (1 if '♯' in k else -1 if '♭' in k else 0)
        fe = features(info['voices'], pc)
        if fe:
            feats[r['Chant']] = fe
    return standardize(feats)


def _moods(r):
    return [t.strip() for t in re.split(r'[;,]', r.get('Mood') or '') if t.strip()]


def all_suggestions():
    """{chant: {'moods': [...], 'why': '...'}} for every chant without moods."""
    G, tm, Z = groups(), text_moods(), _tunes()
    rows = paths.catalog()
    tagged = [(mode_of(r), _moods(r)) for r in rows if _moods(r)]
    out = {}
    for r in rows:
        if not _moods(r) and r['Chant'] in Z:
            moods, why = suggest(r, Z[r['Chant']], tagged, tm, G)
            if moods:
                out[r['Chant']] = {'moods': moods, 'why': ', '.join(why)}
    return out


def check():
    """Leave one out: each tagged chant suggested from the others; how many suggestions it already has."""
    G, tm, Z = groups(), text_moods(), _tunes()
    rows = [r for r in paths.catalog() if _moods(r) and r['Chant'] in Z]
    hits = total = same_group = 0
    for r in rows:
        mine = _moods(r)
        others = [(mode_of(o), _moods(o)) for o in rows if o is not r]
        moods, why = suggest(r, Z[r['Chant']], others, tm, G)
        hits += len(set(moods) & set(mine))
        total += len(moods)
        same_group += sum(G.get(t) in {G.get(x) for x in mine} for t in moods)
        print(f"{r['Chant']:<16} yours: {', '.join(mine):<40} suggested: {', '.join(moods)}")
    print(f'\n{hits} of {total} suggestions are moods you gave; {same_group} of {total} are in the same group as yours')


if __name__ == '__main__':
    if '--check' in sys.argv:
        check()
    else:
        for name, s in sorted(all_suggestions().items()):
            print(f"{name:<16} {', '.join(s['moods']):<36} ({s['why']})")
