#!/usr/bin/env python3
"""Check the pointed texts: every file reads, and its words match the 1979 BCP exactly.

    python tools/check_texts.py              # all files in texts/
    python tools/check_texts.py texts/Psalm_019.txt

Pointing (| . * = † —) and quote style are ignored; words, spelling, capitals and punctuation are compared.
"""
import json, os, re, sys, glob

TOOLS = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(TOOLS)
sys.path.insert(0, TOOLS)
import pointed      # noqa: E402

# places where the reference transcription (bcponline.org) is itself wrong; the text files follow the printed book
KNOWN_REFERENCE_SLIPS = {('Psalm_089_Part_1.txt', 18)}

BCP = json.load(open(os.path.join(ROOT, 'reference', 'bcp1979.json'), encoding='utf-8'))


def words_of_txt(lines):
    toks = [t for ln in lines for t in pointed.tokens(ln['text']) if t not in ('|', '.', '*', '—')]
    out = []
    for t in toks:
        t = t.replace('=', '')
        if out and out[-1].endswith('-') and t.startswith('-'):      # split word: re- | -vives
            out[-1] = out[-1][:-1] + t[1:]
        elif out and out[-1].endswith('-') and out[-1] != '-':       # hyphenated word: loving- | kindness
            out[-1] = out[-1] + t
        else:
            out.append(t)
    return out


def norm(words):
    s = ' '.join(words)
    s = s.replace('“', '"').replace('”', '"').replace('‘', "'").replace('’', "'")
    s = s.replace('"', '').replace(" ' ", ' ')
    s = re.sub(r"(?<![A-Za-z])'|'(?![A-Za-z])", '', s)      # quote marks, keep apostrophes inside words
    s = s.replace(' *', '')
    s = re.sub(r"LORD'S\b", "LORD's", s)
    return re.sub(r'\s+', ' ', s).strip()


CANTICLES = json.load(open(os.path.join(ROOT, 'reference', 'bcp1979_canticles.json'), encoding='utf-8'))


def reference(fname):
    c = re.match(r'Canticle_(\d+)\.txt$', fname)
    if c:
        cant = CANTICLES.get(str(int(c.group(1))))
        return {v['n']: v['text'] for v in cant['verses']} if cant else None
    m = re.match(r'Psalm_(\d+)(?:_Part_(\w+)|_V_(\w+))?\.txt$', fname)
    if not m:
        return None
    ps = BCP.get(str(int(m.group(1))))
    if not ps:
        return None
    vs = ps['verses']
    if m.group(2):
        vs = [v for v in vs if str(v.get('part')) == m.group(2)]
    if m.group(3):
        vs = [v for v in vs if v.get('section') == m.group(3)]
    return {v['n']: v['text'] for v in vs}


def verse_problems(filename, v, ref='look it up'):
    """What's wrong with one pointed verse of a text (by its file name, Psalm_085.txt): one * and the BCP's words."""
    ref = reference(filename) if ref == 'look it up' else ref
    out = []
    stars = sum(1 for ln in v['lines'] for t in pointed.tokens(ln['text']) if t == '*')
    if stars != 1:
        out.append(f'v. {v["n"]}: {stars} asterisks (should be 1)')
    if ref is not None:
        if v['n'] not in ref:
            return out + [f'v. {v["n"]}: not in the BCP for this psalm']
        a, b = norm(words_of_txt(v['lines'])), norm(ref[v['n']].split())
        if a != b and (filename, v['n']) not in KNOWN_REFERENCE_SLIPS:
            aw, bw = a.split(), b.split()
            i = next((k for k in range(min(len(aw), len(bw))) if aw[k] != bw[k]), min(len(aw), len(bw)))
            out.append(f'v. {v["n"]}: "{" ".join(aw[max(0, i - 3):i + 4])}"  — BCP: "{" ".join(bw[max(0, i - 3):i + 4])}"')
    return out


def check(path):
    problems = []
    try:
        doc = pointed.load(path)
    except Exception as e:
        return [f'cannot read: {e}']
    ref = reference(os.path.basename(path))
    nums = [v['n'] for v in doc['verses']]
    if nums != sorted(nums) or len(set(nums)) != len(nums):
        problems.append('verse numbers out of order or repeated')
    for v in doc['verses']:
        problems += verse_problems(os.path.basename(path), v, ref)
    if ref is not None:
        missing = sorted(set(ref) - set(nums))
        if missing and 'unpointed' not in ' '.join(doc['comments']).lower():
            problems.append('verses missing: ' + ', '.join(map(str, missing)))
    return problems


def main():
    import paths as P
    paths = sys.argv[1:] or [f for d in P.TEXT_DIRS for f in sorted(glob.glob(os.path.join(d, '*.txt')))]
    bad = 0
    for p in paths:
        pr = check(p)
        if pr:
            bad += 1
            print(os.path.basename(p))
            for x in pr:
                print('   ' + x)
    print(f'{len(paths)} files checked, {bad} with something to look at')


if __name__ == '__main__':
    main()
