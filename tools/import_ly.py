#!/usr/bin/env python3
"""Convert old-style pointed text files (LilyPond \\line markup) to the plain .txt format.

    python tools/import_ly.py old/Psalm_019.ly [more.ly ...]      # writes parish/texts/Psalm_019.txt
    python tools/import_ly.py --stdout old/Psalm_019.ly
    python tools/import_ly.py --force old/Psalm_019.ly            # replace a pointed copy already there

Pointing copied from a printed psalter is the parish's own (it may be under copyright), so this writes only
into the parish folder, never into the public texts/; and it won't replace a file there unless told to.
Run tools/check_texts.py afterwards.
"""
import os, sys
TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)
import pointed, paths      # noqa: E402


def main():
    args = sys.argv[1:]
    to_stdout, force = '--stdout' in args, '--force' in args
    files = [a for a in args if not a.startswith('--')]
    if not files:
        raise SystemExit(__doc__)
    if not to_stdout and not paths.PARISH:
        raise SystemExit('no parish folder: copy parish.example/ to parish/ first (pointing goes there, not in texts/)')
    for path in files:
        txt = pointed.write(pointed.from_ly(paths.read(path)))
        if to_stdout:
            sys.stdout.write(txt)
            continue
        out = os.path.join(paths.OWN_TEXTS, os.path.splitext(os.path.basename(path))[0] + '.txt')
        if os.path.exists(out) and not force:
            print(f'skipped {os.path.relpath(out)}: it exists (add --force to replace it)')
            continue
        os.makedirs(paths.OWN_TEXTS, exist_ok=True)
        open(out, 'w', encoding='utf-8').write(txt)
        print('wrote', os.path.relpath(out))


if __name__ == '__main__':
    main()
