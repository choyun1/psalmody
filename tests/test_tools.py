"""Checks of the tools' logic, quick to run and needing no LilyPond:

    python -m unittest discover tests

Each test names the behavior it guards; most came from bugs found once, so they stay fixed.
"""
import datetime as dt, os, re, subprocess, sys, tempfile, unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import build, chantedit, emit, history, lectionary, paths, service   # noqa: E402

D = dt.date.fromisoformat


class Calendar(unittest.TestCase):
    def test_days(self):
        for date, key in [('2026-11-29', 'advent1'), ('2026-12-24', 'christmas_eve'), ('2023-12-24', 'advent4'),
                          ('2027-02-10', 'ash_wednesday'), ('2027-03-27', 'easter_vigil'), ('2027-05-16', 'pentecost'),
                          ('2026-11-22', 'proper29'), ('2026-11-01', 'all_saints'), ('2028-08-06', 'transfiguration')]:
            self.assertEqual(lectionary.day_of(D(date))[0], key, date)

    def test_years(self):
        self.assertEqual(lectionary.lect_year(D('2026-11-29')), 'B')
        self.assertEqual(lectionary.lect_year(D('2026-11-22')), 'A')
        self.assertEqual(lectionary.office_year(D('2026-11-29')), 'I')

    def test_colors(self):
        self.assertEqual(lectionary.color(D('2023-12-24')), lectionary.SEASON_COLORS['advent'])  # Advent 4, a Sunday
        self.assertEqual(lectionary.color(D('2026-12-24')), 'white')                               # Christmas Eve
        self.assertEqual(lectionary.color(D('2026-11-01')), 'white')                               # All Saints
        self.assertEqual(lectionary.color(D('2027-03-26')), 'black')                               # Good Friday
        self.assertEqual(lectionary.color(D('2027-06-27')), 'green')

    def test_christmas_eve_kept_on_advent_4(self):
        a = lectionary.appointed(D('2028-12-24'), key='christmas_eve')
        self.assertEqual(a['label'], 'Christmas Eve')
        self.assertTrue(a['psalm'])

    def test_parish_txt_keeps_colors(self):
        strip = lambda line: re.sub(r'#(?!(?:[0-9a-fA-F]{6}|[0-9a-fA-F]{3})\b).*', '', line).strip()
        self.assertEqual(strip('color_shades: white = #fff, gold = #fff2cc  # a note'),
                         'color_shades: white = #fff, gold = #fff2cc')


class Psalms(unittest.TestCase):
    def test_two_psalms_as_one(self):
        self.assertEqual([os.path.basename(p) for p, _ in build.resolve('42 and 43')], ['Psalm_042.txt', 'Psalm_043.txt'])

    def test_optional_verses(self):
        self.assertEqual(build.parse_verses('1-8,(9-11),12', optional=False), [1, 2, 3, 4, 5, 6, 7, 8, 12])
        self.assertEqual(build.parse_verses('1-3,21c'), [1, 2, 3, 21])

    def test_roman_part(self):
        self.assertTrue(build.resolve('89 Part I')[0][0].endswith('Psalm_089_Part_1.txt'))

    def plan(self, text):
        f = tempfile.NamedTemporaryFile('w', suffix='.txt', delete=False)
        f.write(text)
        f.close()
        try:
            return build.plan(build.parse_sunday(f.name))
        finally:
            os.unlink(f.name)

    def test_a_late_first_chant_is_refused(self):
        with self.assertRaises(SystemExit):
            self.plan('psalm: 23\nchant: Turle-2 from 3\n')

    def test_the_chant_before_carries_on(self):
        ps = self.plan('psalm: 23\nchant: Turle-2\npsalm: 24\nchant: Goss-1 from 5\n')
        self.assertEqual([(s['chant'], s['verses'][0]['n']) for s in ps[1]['sections']], [('Turle-2', 1), ('Goss-1', 5)])

    def test_this_sundays_pointing(self):
        ps = self.plan('psalm: 23\nchant: Turle-2\nverse:   1  The | LORD is my | shepherd; *\n'
                       '              I shall | not be | in | want.\n')
        v1 = ps[0]['sections'][0]['verses'][0]
        self.assertEqual(v1['lines'][0]['text'], 'The | LORD is my | shepherd; *')
        self.assertEqual(v1['lines'][1]['half'], 2)
        import check_texts
        self.assertEqual(check_texts.verse_problems('Psalm_023.txt', v1), [])
        wrong = dict(v1, lines=[dict(v1['lines'][0], text='The | LORD is my | shepherd;'), v1['lines'][1]])
        self.assertTrue(check_texts.verse_problems('Psalm_023.txt', wrong))      # no *

    def test_changes_out_of_order_are_refused(self):
        with self.assertRaises(SystemExit):
            self.plan('psalm: 23\nchant: Turle-2\nchant: Goss-1 from 4\nchant: Smart-1 from 2\n')


class Chants(unittest.TestCase):
    def test_aliases(self):
        self.assertEqual(paths.canonical('Turle-5'), 'Turle-2 down 2')
        self.assertEqual(paths.canonical('Turle-5 up 2'), 'Turle-2')
        self.assertEqual(paths.split_chant('Goss-6'), ('Goss-3', 4))

    def test_transposed_key(self):
        c = build.load_music('Turle-2 down 2')
        self.assertEqual(c['key'][2], 'C')
        self.assertIn('\\transpose d c', c['score'])
        self.assertEqual(build.load_music('Attwood-1 up 1')['key'][2], 'A')

    def test_held_yahweh(self):
        self.assertIn('\\scs "A"', emit.word_markup('=YAHWEH'))
        self.assertIn('\\scs "S"', emit.word_markup("=GOD'S"))


class ChantEditing(unittest.TestCase):
    def test_parts_round_trip(self):
        text = paths.read(paths.chant_file('Turle-2'))
        p = chantedit.parts(text)
        self.assertEqual([v['var'] for v in p['voices']], ['S_notes', 'A_notes', 'T_notes', 'B_notes'])
        self.assertEqual(chantedit.parts(chantedit.apply(text, p)), p)

    def test_an_edit_lands(self):
        text = paths.read(paths.chant_file('Turle-2'))
        p = chantedit.parts(text)
        p['key'] = {'tonic': 'c', 'mode': 'minor'}
        p['voices'][0]['body'] = 'c2 | ' + p['voices'][0]['body']      # a bar too many in the soprano's first phrase
        out = chantedit.apply(text, p)
        self.assertIn('\\key c \\minor', out)
        self.assertTrue(chantedit.check(out)[0])            # said so

    def test_the_template_is_a_good_double_chant(self):
        problems, facts = chantedit.check(chantedit.template('A. N. Other (1900-1990)'))
        self.assertEqual(problems, [])
        self.assertTrue(facts['double'])

    def test_bad_input(self):
        text = chantedit.template()
        with self.assertRaises(ValueError):
            chantedit.apply(text, {'key': {'tonic': 'h', 'mode': 'major'}})
        with self.assertRaises(ValueError):
            chantedit.apply(text, {'voices': [{'var': 'S_notes', 'start': "c''", 'body': 'c2 { d'}]})


def musicxml(voices, closed=False, double_bars=True, fifths=1, chords=False):
    """A small partwise MusicXML score from {voice: [bars: [(step, alter, octave, quarters)]]}, as an editor exports it:
    four parts, or (closed) two staves with two voices each, or (chords) two staves of two-note chords."""
    closed = closed or chords
    def note(step, alter, octave, q, staff, voice, chord=False):
        return (f"<note>{'<chord/>' if chord else ''}<pitch><step>{step}</step>{f'<alter>{alter}</alter>' if alter else ''}"
                f"<octave>{octave}</octave></pitch><duration>{int(q * 2)}</duration><voice>{voice}</voice>"
                f"{f'<staff>{staff}</staff>' if closed else ''}</note>")
    names = list(voices)
    layout = [[(names[0], 1, 1), (names[1], 1, 2)], [(names[2], 2, 3), (names[3], 2, 4)]] if closed else \
             [[(n, 1, 1)] for n in names]
    n_bars = len(voices[names[0]])
    parts, plist = [], []
    for pi, group in enumerate(layout):
        pid = f'P{pi + 1}'
        plist.append(f'<score-part id="{pid}"><part-name>{group[0][0]}</part-name></score-part>')
        measures = []
        for b in range(n_bars):
            body = ''
            if b == 0:
                body += (f'<attributes><divisions>2</divisions><key><fifths>{fifths}</fifths><mode>major</mode></key>'
                         f'<time><beats>2</beats><beat-type>4</beat-type></time>{"<staves>2</staves>" if closed else ""}</attributes>')
            if chords:                             # the two voices of a staff on one stem: <note/><note><chord/>…
                (hi, staff, _), (lo, _, _) = group
                body += ''.join(note(*u, staff, 1) + note(*l, staff, 1, chord=True)
                                for u, l in zip(voices[hi][b], voices[lo][b]))
            else:
                for gi, (name, staff, voice) in enumerate(group):
                    if gi:
                        body += '<backup><duration>4</duration></backup>'
                    body += ''.join(note(*n, staff, voice) for n in voices[name][b])
            if double_bars and b in (2, n_bars - 1):
                body += '<barline location="right"><bar-style>light-light</bar-style></barline>'
            measures.append(f'<measure number="{b + 1}">{body}</measure>')
        parts.append(f'<part id="{pid}">' + ''.join(measures) + '</part>')
    return ('<?xml version="1.0"?><score-partwise version="3.1"><identification>'
            '<creator type="composer">A. N. Other (1850-1920)</creator></identification>'
            f'<part-list>{"".join(plist)}</part-list>{"".join(parts)}</score-partwise>').encode()


H, Q = 2, 1      # a half note and a quarter, in quarters
SATB = {         # a single chant in G: 3 bars + 4 bars
    'Soprano': [[('B', 0, 4, H)], [('C', 0, 5, Q), ('B', 0, 4, Q)], [('A', 0, 4, H)],
                [('D', 0, 5, H)], [('C', 0, 5, Q), ('B', 0, 4, Q)], [('A', 0, 4, Q), ('F', 1, 4, Q)], [('G', 0, 4, H)]],
    'Alto': [[('G', 0, 4, H)], [('G', 0, 4, Q), ('G', 0, 4, Q)], [('F', 1, 4, H)],
             [('G', 0, 4, H)], [('E', 0, 4, Q), ('D', 0, 4, Q)], [('E', 0, 4, Q), ('D', 0, 4, Q)], [('D', 0, 4, H)]],
    'Tenor': [[('D', 0, 4, H)], [('E', 0, 4, Q), ('D', 0, 4, Q)], [('D', 0, 4, H)],
              [('B', 0, 3, H)], [('C', 0, 4, Q), ('G', 0, 3, Q)], [('C', 0, 4, Q), ('A', 0, 3, Q)], [('B', 0, 3, H)]],
    'Bass': [[('G', 0, 3, H)], [('C', 0, 3, Q), ('G', 0, 2, Q)], [('D', 0, 3, H)],
             [('G', 0, 2, H)], [('A', 0, 2, Q), ('B', 0, 2, Q)], [('C', 0, 3, Q), ('D', 0, 3, Q)], [('G', 0, 2, H)]],
}


class MusicXML(unittest.TestCase):
    def check_import(self, data):
        import musicxml
        parts, info = musicxml.to_parts(data, 'x.musicxml')
        self.assertEqual(info['composer'], 'A. N. Other (1850-1920)')
        self.assertEqual(parts['key'], {'tonic': 'g', 'mode': 'major'})
        self.assertEqual(parts['time'], '2/4')
        text = chantedit.apply(chantedit.template(info['composer']), parts)
        problems, facts = chantedit.check(text)
        self.assertEqual(problems, [])
        self.assertFalse(facts['double'])
        return parts

    def test_four_parts(self):
        parts = self.check_import(musicxml(SATB))
        sop = parts['voices'][0]
        self.assertEqual(sop['body'].split('\n')[0], 'b2 | c4 b | a2 \\bar "||"')
        self.assertIn('fis', sop['body'])

    def test_closed_score(self):
        self.assertEqual(self.check_import(musicxml(SATB, closed=True)), self.check_import(musicxml(SATB)))

    def test_chords_on_one_stem(self):
        self.assertEqual(self.check_import(musicxml(SATB, chords=True)), self.check_import(musicxml(SATB)))

    def test_phrases_without_double_bars(self):
        self.assertEqual(self.check_import(musicxml(SATB, double_bars=False)), self.check_import(musicxml(SATB)))

    def test_compressed_mxl(self):
        import io, zipfile
        buf = io.BytesIO()
        with zipfile.ZipFile(buf, 'w') as z:
            z.writestr('META-INF/container.xml', '<container><rootfiles><rootfile full-path="score.xml"/></rootfiles></container>')
            z.writestr('score.xml', musicxml(SATB))
        self.check_import(buf.getvalue())

    def test_too_few_voices(self):
        import musicxml as mx
        with self.assertRaises(ValueError):
            mx.to_parts(b'<score-partwise><part-list/></score-partwise>')
        with self.assertRaises(ValueError):
            mx.to_parts(b'<score-timewise/>')


class Moods(unittest.TestCase):
    def test_suggestions_follow_the_mode(self):
        import moodsuggest
        G, tm = moodsuggest.groups(), moodsuggest.text_moods()
        major, _ = moodsuggest.suggest({'Mode': 'Major', 'ACP Psalm': ''}, {}, [], tm, G)
        minor, _ = moodsuggest.suggest({'Mode': 'Minor', 'ACP Psalm': ''}, {}, [], tm, G)
        self.assertTrue(major and all(G[t] in ('bright', 'calm') for t in major))
        self.assertTrue(minor and all(G[t] in ('shadowed', 'dark') for t in minor))
        leapy, why = moodsuggest.suggest({'Mode': 'Minor', 'ACP Psalm': '7'}, {'leaps': 2.0}, [], tm, G)
        self.assertIn('dramatic', leapy)
        self.assertIn('leaps in the tune', why)


class Service(unittest.TestCase):
    def test_service_music_with_a_space(self):
        self.assertEqual(service.hymn('S 278')['number'], 'S278')
        self.assertEqual(service.hymn('LEVAS 114')['book'], 'LEVAS')
        self.assertIsNone(service.hymn('Sanctus - William Byrd'))

    def test_anthems_by_composer(self):
        lib = [{'title': 'Ave verum corpus', 'composer': 'W. A. Mozart (1756-1791)', 'file': 'ave-mozart'}]
        self.assertIsNone(service.find_anthem('Ave verum corpus - William Byrd', lib))
        self.assertEqual(service.find_anthem('Ave verum corpus - W. A. Mozart', lib)['file'], 'ave-mozart')


class Server(unittest.TestCase):
    def test_file_names(self):
        import serve
        self.assertEqual(serve.safe_name('2026-12-24-midnight'), '2026-12-24-midnight')
        for bad in ('../../etc/passwd', '/tmp/x', '.hidden', '-rf', None, 5, ''):
            with self.assertRaises(ValueError):
                serve.safe_name(bad)


class History(unittest.TestCase):
    """Record, undo, undo the undo: in a throwaway git repository standing in for the parish folder."""
    def setUp(self):
        self.d = tempfile.mkdtemp()
        subprocess.run(['git', 'init', '-q'], cwd=self.d, check=True)
        for k, v in (('user.name', 'T'), ('user.email', 't@t')):
            subprocess.run(['git', 'config', k, v], cwd=self.d, check=True)
        self.saved = paths.PARISH, paths.CORE
        paths.PARISH, paths.CORE = self.d, self.d

    def tearDown(self):
        paths.PARISH, paths.CORE = self.saved
        subprocess.run(['rm', '-rf', self.d])

    def write(self, name, text):
        p = os.path.join(self.d, name)
        open(p, 'w').write(text)
        return p

    def test_undo_and_redo(self):
        f = self.write('a.txt', 'one\n')
        history.record([f], 'New service: a')
        self.write('a.txt', 'two\n')
        history.record([f], 'Service: a')
        last = history.changes()[0]
        self.assertEqual(last['message'], 'Service: a')
        self.assertTrue(history.undo('parish', last['sha'])[0])
        self.assertEqual(paths.read(f), 'one\n')
        self.assertEqual(history.changes()[0]['message'], 'Undid: Service: a')
        self.assertFalse(history.undo('parish', last['sha'])[0])            # already undone
        self.assertTrue(history.undo('parish', history.changes()[0]['sha'])[0])
        self.assertEqual(paths.read(f), 'two\n')
        self.assertEqual(history.changes()[0]['message'], 'Redid: Service: a')

    def test_only_a_change_id_reaches_git(self):
        self.assertEqual(history.undo('parish', '--output=/tmp/x'), (False, 'no such change'))
        self.assertEqual(history.undo('parish', 'HEAD~2..HEAD'), (False, 'no such change'))

    def test_an_undo_commits_only_its_own_files(self):
        f = self.write('a.txt', 'one\n')
        history.record([f], 'New service: a')
        sha = history.changes()[0]['sha']
        g = self.write('b.txt', 'staged by hand\n')
        subprocess.run(['git', 'add', g], cwd=self.d, check=True)
        history.undo('parish', sha)
        shown = subprocess.run(['git', 'show', '--name-only', '--format=', 'HEAD'], cwd=self.d,
                               capture_output=True, text=True).stdout.split()
        self.assertEqual(shown, ['a.txt'])


if __name__ == '__main__':
    unittest.main()
