#!/usr/bin/env python3
"""Convert old-style pointed text files (LilyPond \\line markup) to the plain .txt format.

    python tools/import_ly.py old/Psalm_019.ly [more.ly ...]      # writes texts/Psalm_019.txt
    python tools/import_ly.py --stdout old/Psalm_019.ly
"""
import os, sys
TOOLS = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, TOOLS)
import pointed      # noqa: E402

args = sys.argv[1:]
to_stdout = '--stdout' in args
for path in [a for a in args if a != '--stdout']:
    txt = pointed.write(pointed.from_ly(open(path, encoding='utf-8').read()))
    if to_stdout:
        sys.stdout.write(txt)
    else:
        sys.path.insert(0, TOOLS)
        import paths
        out = os.path.join(paths.OWN_TEXTS, os.path.splitext(os.path.basename(path))[0] + '.txt')
        open(out, 'w', encoding='utf-8').write(txt)
        print('wrote', os.path.relpath(out))
