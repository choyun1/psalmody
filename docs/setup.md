[Psalmody](../README.md) › Setup and files

# Setup and files

## Setting up a computer

- LilyPond **2.26.0**: the spacing is tuned for this version. A different version still works, and the build prints a note saying it isn't 2.26.0. If `lilypond` is not on the PATH, set the `LILYPOND` environment variable to the program.
- Python 3.9 or later, then `pip install -r requirements.txt`.

## What's where

| In this folder | |
|---|---|
| `Psalter.bat`, `psalter.sh` | Double-click to open the chant browser and service planner (Windows; Linux/macOS). |
| `texts/` | One plain-text file per psalm (or psalm part, or section of Psalm 119), with the words of the 1979 BCP, unpointed. Also `Gloria.txt`. `moods.csv` holds each text's mood tags. |
| `chants/` | Public-domain chants, one LilyPond file each, with `catalog.csv` (composer, years, key, mode, single/double, source). |
| `moods.txt` | The mood vocabulary shared by chants and texts. |
| `services.txt` | Orders of service: which music each kind of service has, and what the email calls it. |
| `examples/` | One example Sunday file for each situation. |
| `style/` | `psalm-style.ily` (every typographic setting) and the EB Garamond fonts. |
| `tools/` | The Python scripts. |
| `reference/` | The 1979 BCP psalter, the lectionary's psalm table and the Gregorian psalm tones. Add hymnal indexes as `reference/hymnals/<BOOK>.csv` (columns `number,title`) to have hymn titles filled in from numbers. |
| `parish.example/` | A parish folder to copy to `parish/`. |

| In your `parish/` folder | |
|---|---|
| `parish.txt` | Your parish's name, lectionary track, patronal feast, Christmas psalms, optional verses, the music schedule, and who the weekly email goes to. |
| `texts/` | Your pointed texts. A text here takes the place of the unpointed one in `texts/`; pointing done in the browser is saved here. |
| `services.txt` | Your own orders of service, if they differ (replaces `services.txt`). |
| `chant_notes.csv` | Your ratings, mood tags and notes on every chant. |
| `chants/` | Chants you may not publish (still under copyright), with their own `catalog.csv`. |
| `anthems/` | The words of each anthem, one file per anthem, for the email. |
| `hymnals/` | Hymnal indexes, `<BOOK>.csv` with columns `number,title` (e.g. `EH1982.csv`), so hymn titles fill in from numbers. |
| `hymn_titles.csv` | Hymn titles by number (`book,number,title`), or your own wording for some. |
| `lessons.csv` | Readings for Lessons and Carols, with the one-line summary printed under each. |
| `sundays/` | One file per Sunday or service. |
| `output/`, `site/` | What the build makes, and the chant browser built for your parish. |

Without a `parish/` folder the tools still work, keeping those things in this folder instead.

## The look

All the typographic choices are named settings at the top of `style/psalm-style.ily`, each with a one-line comment: typeface and weight, bar height and spacing, brackets, held-syllable mark, dagger, indents, verse spacing. Change a number and rebuild. Nothing else needs touching.

## Adding a chant

Copy it into `chants/` in the same layout as the others: `global`, `S_notes`, `A_notes`, `T_notes`, `B_notes`, the composer in `\header`, and the score in a `\markup { \fill-line { \score … } }` block. Then add a row to `chants/catalog.csv` (or to `parish/chants/` and its catalog if it's still under copyright). The build works out single or double and the key from the notes.
