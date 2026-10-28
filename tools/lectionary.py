#!/usr/bin/env python3
"""Which day of the church year a date is, and the psalm the Revised Common Lectionary appoints for it.

    python tools/lectionary.py 2026-11-08          # one date
    python tools/lectionary.py 2026-11-08 8        # the next 8 Sundays from that date

The psalm table is reference/rcl_psalms.csv (Episcopal edition, 1979 BCP numbering).
"""
import csv, datetime as dt, os, sys

TOOLS = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(TOOLS)
D = dt.date
ONE = dt.timedelta(days=1)


def easter(y):
    """Gregorian Easter (anonymous algorithm)."""
    a, b, c = y % 19, y // 100, y % 100
    d, e = b // 4, b % 4
    f = (b + 8) // 25
    g = (b - f + 1) // 3
    h = (19 * a + b - d - g + 15) % 30
    i, k = c // 4, c % 4
    l = (32 + 2 * e + 2 * i - h - k) % 7
    m = (a + 11 * h + 22 * l) // 451
    month = (h + l - 7 * m + 114) // 31
    day = ((h + l - 7 * m + 114) % 31) + 1
    return D(y, month, day)


def sunday_on_or_after(d):
    return d + dt.timedelta(days=(6 - d.weekday()) % 7)


def advent1(y):
    """First Sunday of Advent: the Sunday from 27 November to 3 December."""
    return sunday_on_or_after(D(y, 11, 27))


def lect_year(d):
    """A, B or C: the year that began on the First Sunday of Advent before (or on) this date."""
    y = d.year if d >= advent1(d.year) else d.year - 1
    return 'ABC'[(y + 1) % 3 - 1] if (y + 1) % 3 else 'C'


NAMES = {
    'advent': 'Advent {n}', 'christmas_sunday1': 'First Sunday after Christmas',
    'christmas_sunday2': 'Second Sunday after Christmas', 'epiphany1': 'First Sunday after the Epiphany (Baptism of Our Lord)',
    'epiphany_last': 'Last Sunday after the Epiphany', 'lent': 'Lent {n}', 'palm_sunday': 'Palm Sunday',
    'easter': 'Easter Day', 'pentecost': 'Day of Pentecost', 'trinity': 'Trinity Sunday', 'easter_n': 'Easter {n}',
}


def day_of(d):
    """-> (key, label) for a date: Sundays plus the principal fixed and movable feasts."""
    y = d.year
    E = easter(y)
    fixed = {(12, 24): ('christmas_eve', 'Christmas Eve'), (12, 25): ('christmas_day', 'Christmas Day'),
             (1, 1): ('holy_name', 'The Holy Name'), (1, 6): ('epiphany', 'The Epiphany'),
             (2, 2): ('presentation', 'The Presentation'),
             (8, 6): ('transfiguration', 'The Transfiguration'), (11, 1): ('all_saints', "All Saints' Day")}
    pat = PARISH.get('patronal')
    if pat:
        md, key, *name = pat.split()
        mo, dy = (int(x) for x in md.split('-'))
        fixed[(mo, dy)] = (key, ' '.join(name) + ' (patronal)')
    movable = {E - dt.timedelta(days=46): ('ash_wednesday', 'Ash Wednesday'),
               E - dt.timedelta(days=3): ('maundy_thursday', 'Maundy Thursday'),
               E - dt.timedelta(days=2): ('good_friday', 'Good Friday'),
               E - ONE: ('easter_vigil', 'The Great Vigil of Easter'),
               E + dt.timedelta(days=39): ('ascension', 'Ascension Day')}
    if d in movable:
        return movable[d]
    if (d.month, d.day) in fixed and not (d.month == 12 and d.day == 24):
        return fixed[(d.month, d.day)]
    if d.weekday() != 6:
        if (d.month, d.day) in fixed:
            return fixed[(d.month, d.day)]
        return None, d.strftime('%A')
    # Sundays
    a1 = advent1(y)
    if d >= a1:
        n = (d - a1).days // 7 + 1
        if d < D(y, 12, 25):
            return f'advent{n}', f'Advent {n}'
        return 'christmas_sunday1', 'First Sunday after Christmas'
    if d < D(y, 1, 6):
        return ('christmas_sunday1', 'First Sunday after Christmas') if d.day <= 1 else \
               ('christmas_sunday2', 'Second Sunday after Christmas')
    ash = E - dt.timedelta(days=46)
    if d < ash:
        ep1 = sunday_on_or_after(D(y, 1, 7))
        if d == ash - dt.timedelta(days=3):
            return 'epiphany_last', 'Last Sunday after the Epiphany'
        n = (d - ep1).days // 7 + 1
        label = 'First Sunday after the Epiphany' if n == 1 else f'Epiphany {n}'
        return f'epiphany{n}', label
    if d < E:
        n = (d - (ash + dt.timedelta(days=4))).days // 7 + 1
        return ('palm_sunday', 'Palm Sunday') if n == 6 else (f'lent{n}', f'Lent {n}')
    if d == E:
        return 'easter', 'Easter Day'
    if d < E + dt.timedelta(days=49):
        n = (d - E).days // 7 + 1
        return f'easter{n}', f'Easter {n}'
    if d == E + dt.timedelta(days=49):
        return 'pentecost', 'Day of Pentecost'
    if d == E + dt.timedelta(days=56):
        return 'trinity', 'Trinity Sunday'
    # Propers: Proper n is the Sunday closest to 11 May + 7(n-1) days
    for n in range(1, 30):
        anchor = D(y, 5, 11) + dt.timedelta(days=7 * (n - 1))
        if abs((d - anchor).days) <= 3:
            return f'proper{n}', f'Proper {n}'
    return None, 'Sunday'


def load_parish():
    """parish.txt: the settings specific to one church (name, track, patronal feast, Christmas psalms)."""
    out = {'name': '', 'track': '2'}
    import paths
    path = paths.PARISH_TXT
    if os.path.exists(path):
        for line in open(path, encoding='utf-8'):
            line = line.split('#', 1)[0].strip()
            if ':' in line:
                k, v = line.split(':', 1)
                out[k.strip().lower()] = v.strip()
    return out


PARISH = load_parish()
HOUSE = {}
for _k, _default in (('christmas_eve', 'christmas1 christmas2 christmas3'), ('christmas_day', 'christmas1 christmas2 christmas3')):
    _order = PARISH.get(_k, _default).split()
    HOUSE[_k] = (_order[0], _order[1:])


def table():
    path = os.path.join(ROOT, 'reference', 'rcl_psalms.csv')
    rows = {}
    if os.path.exists(path):
        for r in csv.DictReader(open(path, encoding='utf-8')):
            for yr in r['year']:
                rows[(r['day'], yr)] = r
    return rows


def appointed(d, rows=None):
    """-> dict(date, key, label, year, psalm, alt) for a date."""
    rows = rows if rows is not None else table()
    key, label = day_of(d)
    yr = lect_year(d)
    if key in HOUSE:
        main, others = HOUSE[key]
        r = rows.get((main, yr))
        alts = [rows[(o, yr)]['psalm'] for o in others if (o, yr) in rows]
        return {'date': d.isoformat(), 'key': key, 'label': label, 'year': yr,
                'psalm': r['psalm'] if r else None, 'alt': alts}
    r = rows.get((key, yr)) if key else None
    return {'date': d.isoformat(), 'key': key, 'label': label, 'year': yr,
            'psalm': r['psalm'] if r else None,
            'alt': [a.strip() for a in r['alt'].split('|') if a.strip()] if r and r.get('alt') else []}


def main():
    d = D.fromisoformat(sys.argv[1]) if len(sys.argv) > 1 else D.today()
    n = int(sys.argv[2]) if len(sys.argv) > 2 else 1
    rows = table()
    if n > 1:
        d = sunday_on_or_after(d)
    for i in range(n):
        a = appointed(d + dt.timedelta(days=7 * i), rows)
        fmt = lambda p: ('Psalm ' + p) if p and p[0].isdigit() else (p or '?')
        if a['key'] and a['key'].startswith('proper') and a['alt']:
            what = f"Track 1: {fmt(a['psalm'])}   Track 2: {fmt(a['alt'][0])}" + \
                   ''.join(f'  or {fmt(x)}' for x in a['alt'][1:])
        else:
            what = fmt(a['psalm']) + ''.join(f'  or {fmt(x)}' for x in a['alt'])
        print(f"{a['date']}  {a['label']:<38} Year {a['year']}  {what}")


if __name__ == '__main__':
    main()
