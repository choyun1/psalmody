# Psalmody

Psalms of the 1979 Book of Common Prayer set to Anglican chant or to the plainchant psalm tones, typeset with LilyPond. Texts and chants are kept apart, so any text can be sung to any chant. One short file per Sunday produces the choir's PDF and cropped images for the bulletin. A local browser app plans the whole service, drafts the weekly music email and keeps the record.

It was built for one parish's weekly use and is shared in case it helps others.

![The service planner: the appointed psalm with its mood tags, the chant, and the rest of the service](docs/images/planner.png)

| | |
|---|---|
| ![Choosing a chant: every chant with notation, playback, moods and when it was last used](docs/images/chant-picker.png) | ![A psalm set to Tone VIIa: the tone, then each verse pointed in words](docs/images/plainchant-page.png) |
| *Choosing a chant* | *A plainchant page, pointed automatically* |

## What's included

- The words of all 150 psalms (and some canticles) from the 1979 BCP, checked word for word.
- 103 public-domain Anglican chants, with a catalog: composer, dates, key, mode, single or double.
- The Gregorian psalm tones of the Liber usualis, set to any text automatically by the natural stress of the words.
- The psalms appointed by the Revised Common Lectionary (Episcopal), Years A, B and C, both tracks.
- A browser-based planner: lectionary psalm, chant picker with notation and playback, pointing editor, preview, build, the rest of the service, the weekly email, the music schedule, and the history.

**Pointing.** The texts here are unpointed, because the pointing in printed psalters (the Anglican Chant Psalter and others) is the publishers' work and can't be shared. The plainchant tones need no pointing. For Anglican chant, point the psalms you sing with the browser's pointing editor (or by hand, in the plain-text format); your pointing is saved in your parish folder.

## Getting started

1. Install Python 3.9 or later and [LilyPond](https://lilypond.org) (2.26 is what the spacing is tuned for).
2. Download this repository and double-click **Psalter.bat** (Windows) or run `psalter.sh` (Linux, macOS). It installs the Python packages it needs and opens the chant browser in your web browser.
3. Copy `parish.example/` to `parish/` and edit `parish/parish.txt`: your parish's name, lectionary track, and (if you want them) the weekly email and the music schedule. Keep `parish/` as its own private git repository if you like. It's where your Sunday files, pointing, ratings and history live, and this repository ignores it.

## Contents

1. **[Each week](docs/weekly.md)**: planning a Sunday in the browser, step by step
   - [From the command line](docs/weekly.md#from-the-command-line)
   - [Just a psalm](docs/weekly.md#just-a-psalm)
   - [Lessons and Carols, and other services in a free order](docs/weekly.md#lessons-and-carols-and-other-services-in-a-free-order)
2. **[Orders of service](docs/services.md)**: which music each kind of service has
   - [In a Sunday file](docs/services.md#in-a-sunday-file)
   - [The record](docs/services.md#the-record)
3. **[The weekly email](docs/email.md)**: its wording and layout, and drafting it in Gmail
   - [Gmail drafts](docs/email.md#gmail-drafts)
4. **[The music schedule spreadsheet](docs/spreadsheet.md)**: writing each service into an .xlsx or a Google Sheet
5. **[Plainchant psalm tones](docs/plainchant.md)**: the Liber usualis tones, pointed automatically
6. **[The chant browser](docs/browser.md)**: Coming up, Chants, Psalms, History; mood tags and matching
7. **[The text format](docs/texts.md)**: how a pointed psalm is written, and checking the words
8. **[Setup and files](docs/setup.md)**: what's where, the look, adding a chant
9. **[Roadmap](docs/roadmap.md)**

![The Chants tab: filter by mood, mode, key and rating; every chant in notation with playback](docs/images/chants.png)

## License

The code is under the MIT License (`LICENSE`). The texts' mood tags, the chant catalog and the other data are under Creative Commons Attribution 4.0 (`LICENSE-DATA.md`). The psalm texts are from the 1979 Book of Common Prayer, which is in the public domain, as are the chants included here. The psalm tones come from the jgabc project (public domain). The EB Garamond fonts are under the SIL Open Font License (`style/fonts/OFL.txt`).
