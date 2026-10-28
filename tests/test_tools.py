"""Checks of the tools' logic, quick to run and needing no LilyPond:

    python -m unittest discover tests

Each test names the behavior it guards; most came from bugs found once, so they stay fixed.
"""
import datetime as dt, os, re, subprocess, sys, tempfile, unittest

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))
import build, emit, history, lectionary, paths, service   # noqa: E402

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
        self.assertEqual(open(f).read(), 'one\n')
        self.assertEqual(history.changes()[0]['message'], 'Undid: Service: a')
        self.assertFalse(history.undo('parish', last['sha'])[0])            # already undone
        self.assertTrue(history.undo('parish', history.changes()[0]['sha'])[0])
        self.assertEqual(open(f).read(), 'two\n')
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
