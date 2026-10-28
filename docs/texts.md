[Psalmody](../README.md) › The text format

# The text format

```
Psalm 19 | Caeli enarrant

1   The heavens declare the | glory . of | God, *
      and the | firma- . -ment | shows his | handiwork.

14  Let the words of my mouth and the meditation of my
    + heart be ac- | -ceptable . in your | sight, *
      O LORD, my | strength and | my re- | -deemer.
```

| Mark | Meaning |
|---|---|
| `\|` | bar line |
| `.` (standing alone) | the next note within the bar. Two or more syllables on one note get a bracket. |
| `*` | the mediant. Lines up to and including the `*` are the first half of the verse. |
| `=word` | a held syllable, sung to both notes of the bar. It prints with two dots over the first vowel. |
| `re- \| -vives` | a word divided by the pointing; prints as re'vives |
| `loving- \| kindness` | a word that has a real hyphen; prints as loving-'kindness |
| `—` | an empty bar |
| `†` before the verse number | sing this verse to the second half of the chant again |
| `+` at the start of a line | a long line running over |
| `%` at the start of a line | a comment |

Indentation is only for reading. LORD, GOD and YAHWEH are set in small capitals automatically, and straight quotes become curly ones. Any text editor works, including GitHub's web editor.

To check the texts after editing them:

```
python tools/check_texts.py
```

It reports any word that differs from the 1979 BCP and any verse that doesn't have exactly one `*`. Files marked `% unpointed draft` have the correct words but no pointing yet.

## Old-format text files

`python tools/import_ly.py Psalm_xxx.ly` converts a text file in the old LilyPond `\line` layout to the format above.
