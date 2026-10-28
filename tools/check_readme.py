#!/usr/bin/env python3
"""Check the README: its Contents box lists every ## section, in order, and its links lead somewhere.

    python tools/check_readme.py
"""
import os, re, sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def anchor(heading):
    return re.sub(r'[^\w\- ]', '', heading.strip().lower()).replace(' ', '-')


def main():
    text = open(os.path.join(ROOT, 'README.md'), encoding='utf-8').read()
    problems = []
    box = re.search(r'<table><tr><td>(.*?)</td></tr></table>', text, re.S)
    listed = re.findall(r'\]\(#([^)]+)\)', box.group(1)) if box else []
    sections = [anchor(h) for h in re.findall(r'^## (.+)$', text, re.M)]
    if listed != sections:
        problems.append(f'the Contents box lists {listed}\n  but the sections are {sections}')
    for target in re.findall(r'\]\(([^)#\s]+)(?:#[^)]*)?\)|src="([^"]+)"', text):
        t = next(x for x in target if x)
        if not t.startswith(('http://', 'https://')) and not os.path.exists(os.path.join(ROOT, t)):
            problems.append(f'link to a missing file: {t}')
    for a in re.findall(r'\]\(#([^)]+)\)', text):
        if a not in sections:
            problems.append(f'link to a missing section: #{a}')
    print('\n'.join(problems) or f'README: {len(sections)} sections, all in the Contents box; links fine')
    return 1 if problems else 0


if __name__ == '__main__':
    sys.exit(main())
