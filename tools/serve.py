#!/usr/bin/env python3
"""Run the chant browser with its Service planner switched on.

    python tools/serve.py           # opens http://localhost:8765 in your web browser; Ctrl+C to stop

With this running, the browser can save chant tags straight to your chant notes, write Sunday
files, run the checks, and build the PDF and images with one click. It only listens on your own
computer (localhost). Opening site/index.html directly still works, without those buttons.
"""
import csv, io, http.server, json, os, subprocess, sys, threading, urllib.parse, webbrowser

TOOLS = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(TOOLS)
PORT = int(os.environ.get('PSALTER_PORT', '8765'))
PY = sys.executable
sys.path.insert(0, TOOLS)
import paths   # noqa: E402
SITE_URL = '/' + os.path.relpath(paths.SITE, ROOT).replace(os.sep, '/') + '/index.html'


def run(args, timeout=900):
    r = subprocess.run([PY, os.path.join(TOOLS, args[0])] + args[1:], cwd=ROOT,
                       capture_output=True, text=True, timeout=timeout)
    return r.returncode, (r.stdout + ('\n' + r.stderr if r.stderr.strip() else '')).strip()


def save_verse(data):
    """Replace one verse of a text file, after checking the words still match the BCP."""
    import pointed, check_texts, tempfile, shutil
    name = safe_name(data['id'])
    src = paths.text_file(name)
    path = os.path.join(paths.OWN_TEXTS, name + '.txt')        # pointing is the parish's own: saved there
    os.makedirs(paths.OWN_TEXTS, exist_ok=True)
    doc = pointed.parse(open(src, encoding='utf-8').read())
    doc['comments'] = [c for c in doc['comments'] if 'unpointed' not in c.lower()]
    try:
        new = pointed.parse('x\n' + data['block'])['verses']
    except Exception as e:
        return {'ok': False, 'error': f'cannot read the verse: {e}'}
    if len(new) != 1 or str(new[0]['n']) != str(data['n']):
        return {'ok': False, 'error': 'keep exactly one verse, with the same number'}
    i = next(k for k, v in enumerate(doc['verses']) if str(v['n']) == str(data['n']))
    doc['verses'][i] = new[0]
    tmp = tempfile.mkdtemp()
    try:
        tp = os.path.join(tmp, name + '.txt')
        open(tp, 'w', encoding='utf-8').write(pointed.write(doc))
        problems = [p for p in check_texts.check(tp) if p.startswith(f"v. {data['n']}:")]
        if problems:
            return {'ok': False, 'error': '; '.join(problems)}
        shutil.copy(tp, path)
    finally:
        shutil.rmtree(tmp)
    v = new[0]
    threading.Thread(target=lambda: run(['browser.py']), daemon=True).start()
    return {'ok': True, 'verse': [v['n'], int(v['dagger']), [[l['text'], l['half'], int(l['wrap'])] for l in v['lines']]]}


def git_repos():
    out = []
    for d in (ROOT, paths.PARISH):
        if d and os.path.isdir(os.path.join(d, '.git')):
            out.append(d)
    return out


def git_status(d):
    r = subprocess.run(['git', 'status', '--porcelain'], cwd=d, capture_output=True, text=True)
    lines = [l for l in r.stdout.splitlines() if l.strip()]
    return {'name': 'parish' if d == paths.PARISH else 'psalter', 'changes': len(lines),
            'files': [l[3:] for l in lines[:12]]}


def safe_name(name):
    name = os.path.basename(str(name)).strip()
    if not name or name.startswith('.') or not all(c.isalnum() or c in '-_' for c in name):
        raise ValueError('file names may use letters, digits, - and _ only')
    return name


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *a, **k):
        super().__init__(*a, directory=ROOT, **k)

    def log_message(self, fmt, *args):
        pass

    def reply(self, obj, code=200):
        body = json.dumps(obj).encode()
        self.send_response(code)
        self.send_header('Content-Type', 'application/json')
        self.send_header('Content-Length', str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        u = urllib.parse.urlparse(self.path)
        if u.path == '/':
            self.send_response(302)
            self.send_header('Location', SITE_URL)
            self.end_headers()
            return
        if u.path == '/api/ping':
            return self.reply({'ok': True})
        if u.path == '/api/git':
            return self.reply({'repos': [git_status(d) for d in git_repos()]})
        if u.path == '/api/sunday':
            q = urllib.parse.parse_qs(u.query)
            try:
                name = safe_name(q.get('name', [''])[0])
            except ValueError as e:
                return self.reply({'error': str(e)}, 400)
            path = os.path.join(paths.SUNDAYS, name + '.txt')
            return self.reply({'exists': os.path.exists(path),
                               'text': open(path, encoding='utf-8').read() if os.path.exists(path) else ''})
        return super().do_GET()

    def do_POST(self):
        if self.client_address[0] not in ('127.0.0.1', '::1'):
            return self.reply({'error': 'local only'}, 403)
        n = int(self.headers.get('Content-Length', '0'))
        try:
            data = json.loads(self.rfile.read(n) or b'{}')
        except json.JSONDecodeError:
            return self.reply({'error': 'bad request'}, 400)
        path = urllib.parse.urlparse(self.path).path
        try:
            if path == '/api/notes':
                paths.write_notes(list(csv.DictReader(io.StringIO(data['csv']))))
                code, out = run(['browser.py'])
                return self.reply({'ok': code == 0, 'log': out})
            if path == '/api/sunday':
                name = safe_name(data['name'])
                os.makedirs(paths.SUNDAYS, exist_ok=True)
                with open(os.path.join(paths.SUNDAYS, name + '.txt'), 'w', encoding='utf-8') as fh:
                    fh.write(data['text'])
                return self.reply({'ok': True, 'path': os.path.relpath(os.path.join(paths.SUNDAYS, name + '.txt'), ROOT).replace(os.sep, '/')})
            if path == '/api/sung':
                name = safe_name(data['name'])
                fp = os.path.join(paths.SUNDAYS, name + '.txt')
                txt = open(fp, encoding='utf-8').read()
                yes = bool(data.get('sung', True))
                lines = [l for l in txt.splitlines() if not l.strip().lower().startswith('sung:')]
                if yes:
                    lines.append('sung:    yes')
                open(fp, 'w', encoding='utf-8').write('\n'.join(lines) + '\n')
                code, out = run(['browser.py'])
                return self.reply({'ok': True})
            if path == '/api/commit':
                msg = (data.get('message') or 'Updates from the chant browser').strip()
                out = []
                for d in git_repos():
                    st = git_status(d)
                    if not st['changes']:
                        continue
                    for args in (['add', '-A'], ['commit', '-q', '-m', msg], ['push', '-q']):
                        r = subprocess.run(['git'] + args, cwd=d, capture_output=True, text=True)
                        if r.returncode != 0:
                            return self.reply({'ok': False, 'log': f"{st['name']}: git {args[0]} failed\n{r.stderr.strip()}"})
                    out.append(f"{st['name']}: {st['changes']} change(s) saved to GitHub")
                return self.reply({'ok': True, 'log': '\n'.join(out) or 'Nothing to save.'})
            if path == '/api/anthem':
                import service
                if not data.get('title', '').strip():
                    raise ValueError('the anthem needs a title')
                f = service.write_anthem(data['title'].strip(), data.get('composer', '').strip(),
                                         data.get('source', '').strip(), data.get('text', ''))
                threading.Thread(target=lambda: run(['browser.py']), daemon=True).start()
                return self.reply({'ok': True, 'file': os.path.relpath(f, ROOT).replace(os.sep, '/')})
            if path == '/api/open':
                name = safe_name(data['name'])
                folder = os.path.join(paths.OUTPUT, name, safe_name(data['sub']) if data.get('sub') else '')
                if not os.path.isdir(folder):
                    raise ValueError('nothing built yet for ' + name)
                if sys.platform.startswith('win'):
                    os.startfile(folder)
                else:
                    subprocess.Popen(['open' if sys.platform == 'darwin' else 'xdg-open', folder])
                return self.reply({'ok': True})
            if path == '/api/text':
                return self.reply(save_verse(data))
            if path == '/api/check':
                name = safe_name(data['name'])
                code, out = run(['build.py', os.path.join(paths.SUNDAYS, name + '.txt'), '--check'])
                return self.reply({'ok': code == 0, 'log': out})
            if path == '/api/build':
                name = safe_name(data['name'])
                args = ['build.py', os.path.join(paths.SUNDAYS, name + '.txt')] + (['--pdf-only'] if data.get('pdfOnly') else [])
                code, out = run(args)
                outdir = os.path.join(paths.OUTPUT, name)
                files = []
                if os.path.isdir(outdir):
                    for dp, _, fs in os.walk(outdir):
                        for f in sorted(fs):
                            if f.endswith(('.pdf', '.jpg')):
                                files.append(os.path.relpath(os.path.join(dp, f), ROOT).replace(os.sep, '/'))
                if code == 0:
                    run(['browser.py'])          # refresh history and "coming up"
                return self.reply({'ok': code == 0, 'log': out, 'files': sorted(files)})
            import plugins                      # a parish plugin's own requests (parish/plugins/)
            handler = plugins.routes().get(path)
            if handler:
                return self.reply(handler(data, {'safe_name': safe_name, 'root': ROOT}))
        except (KeyError, ValueError) as e:
            return self.reply({'error': str(e)}, 400)
        except subprocess.TimeoutExpired:
            return self.reply({'error': 'timed out'}, 500)
        return self.reply({'error': 'unknown request'}, 404)


def main():
    if not os.path.exists(os.path.join(paths.SITE, 'data.js')):
        print('building the browser first…')
        run(['browser.py'])
    import lectionary
    if len(lectionary.links()) < 100:               # first run: find the lectionary site's pages, in the background
        def find_links():
            if run(['lectionary_links.py'])[0] == 0:
                run(['browser.py'])
        threading.Thread(target=find_links, daemon=True).start()
    srv = http.server.ThreadingHTTPServer(('127.0.0.1', PORT), Handler)
    url = f'http://localhost:{PORT}{SITE_URL}'
    print(f'Chant browser with the Service planner: {url}\n(Ctrl+C to stop)')
    threading.Timer(0.6, lambda: webbrowser.open(url)).start()
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        print('\nstopped')


if __name__ == '__main__':
    main()
