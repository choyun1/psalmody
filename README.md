# Psalmody

Psalms of the 1979 Book of Common Prayer set to Anglican chant or to the plainchant psalm tones, typeset with LilyPond. Texts and chants are kept apart, so any text can be sung to any chant. One short file per Sunday produces the choir's PDF and cropped images for the bulletin; a local browser app plans the whole service, drafts the weekly music email, and keeps the record.

It was built for one parish's weekly use and is shared in case it helps others. It comes with:

- the words of all 150 psalms (and some canticles) from the 1979 BCP, checked word for word;
- 103 public-domain Anglican chants, with a catalog (composer, dates, key, mode, single or double);
- the Gregorian psalm tones of the Liber usualis, set automatically to any text by the natural stress of the words;
- the psalms appointed by the Revised Common Lectionary (Episcopal), Years A, B and C, both tracks;
- a browser-based planner: lectionary psalm, chant picker with notation and playback, pointing editor, preview, build, the rest of the service, the weekly email, and the history.

**Pointing.** The texts here are unpointed: the pointing in printed psalters (the Anglican Chant Psalter and others) is the publishers' work and can't be shared. The plainchant tones need no pointing. For Anglican chant, point the psalms you sing with the browser's pointing editor (or by hand, in the plain-text format below); your pointing is saved in your parish folder.

## Getting started

1. Install Python 3.9 or later and LilyPond (2.26 is what the spacing is tuned for).
2. Download this repository and double-click **Psalter.bat** (Windows) or run `psalter.sh` (Linux, macOS). It installs the Python packages it needs and opens the chant browser in your web browser.
3. Copy `parish.example/` to `parish/` and edit `parish/parish.txt`: your parish's name, lectionary track, and (if you want them) the weekly email and the music schedule. Keep `parish/` as its own private git repository if you like: it is where your Sunday files, pointing, ratings and history live, and this repository ignores it.

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

## Each week

Double-click **Psalter.bat** (on Linux, `psalter.sh`). It opens the chant browser with a **Service planner** tab:
1. Pick the date. The lectionary psalm is filled in; *The text* opens the pointed text of exactly the verses appointed.
2. Click **Choose…** next to a chant slot. A picker opens with every chant's notation, playback, moods and last use, filtered and sorted however you like (best match for the psalm, key, circle of fifths, longest since used…), plus the plainchant tones. Click **Use**. Add chant changes or more psalms the same way. (From the Chants tab, *Use in the psalm builder* does the same.)
   **Optional verses.** Verses the lectionary prints in brackets, as in `90:1-8,(9-11),12`, are left out unless you tick *sing the optional verses* under the psalm (set by `optional_verses: leave out` (or `sing`) in `parish.txt`). In a Sunday file it's `optional: yes` (or `no`) under the psalm line; the psalm line itself stays as the lectionary prints it.
   **Moving the †.** The psalm's *The text* shows its verse numbers; click one to put a † (sing the second half again) on that verse or take it off, for this Sunday only. The text file keeps its own. Under the chant it says at once whether each double chant comes out even, and where a † falls wrongly. In the Sunday file this is one line under the psalm, `daggers: 7, 15` (or `daggers: none`).
3. *Preview* shows the page straight away (chant notation and pointed text); **Exact PDF preview** runs LilyPond and shows the real PDF.
   **Before on this day.** Above the rest of the service, *Before on Proper 27* shows what was sung the last time these readings came round (three years ago, six…) and, folded away, the same day in the other years of the cycle: psalm, chant, hymns, anthems, voluntaries.
4. Under **The rest of the service**, fill in the prelude, hymns, anthem and postlude. The boxes follow the day's order of service (Eucharist, Evensong, Palm Sunday, Good Friday…; see below), chosen by the Service box or by the day itself. Anything already in the music schedule for that date is filled in, and the service music carries on from the last service of the same kind. Type a hymn number (`390`, `LEVAS 114`) and its title appears, with when it was last sung. Prelude, postlude and anthem boxes suggest everything done before. For an anthem, paste its words once; they're kept in `parish/anthems/` and come back whenever it's sung again.
5. Click **Save & build**. The PDF and the administrator's images appear as links.
6. Click **Save, build & draft the email**. It writes the week's email (greeting, the list of music with each anthem's words, the signature, all set up in `parish.txt`) and puts it in the music account's Gmail **Drafts** with the psalm images attached (`psalm_YYMMDD_chant.jpg`, `psalm_YYMMDD_text.jpg`), ready to look over and send. For the usual Sunday service it mentions the service music only when it changes; for a special service it lists it all. Edits in the box go into the draft with **Update the Gmail draft** (the earlier draft for that day goes to the Trash). The first time, it asks you to connect Gmail: see *Gmail drafts* below. Without that, *Other ways to send it* offers a prefilled Gmail message (drag the images in) or a `.eml` file for Outlook or Thunderbird.
7. **Record in the music schedule…** (under the email) shows what will change in the spreadsheet, cell by cell, then **Write** puts it there: see *The music schedule spreadsheet* below.
8. When there are changes, a **Save N changes to GitHub** button appears at the top: it commits and pushes both repositories.

Everything stays on your computer. Close the launcher's window to stop.

**The same from the command line:**

1. Start the Sunday from the lectionary:

   ```
   python tools/new_sunday.py 2026-11-08
   ```

   This writes `parish/sundays/2026-11-08.txt` with the day (Proper 27, Year A), the appointed psalm and verses, the alternatives (Track 1 / Track 2 after Pentecost; `--track 1` picks the other one), and chants whose moods suit the text, leaving out any used in the last 12 weeks:

   ```
   # Proper 27, Year A (Track 2)
   date:    2026-11-08
   psalm:   70
   #   or:  78:1-7
   chant:   ???                       # pick one; ideas below
   ```

   Put your chant on the `chant:` line. `examples/` has a worked example of every situation: one chant, a change of chant, lectionary verse lists, Evensong with the Gloria, two psalms, Psalm 119, two services on one day, the less common options, and Track 1. To change chant partway through, add `chant: Smart-1 from 9`. For Evensong or the Office, add `service: Evensong`, which switches the Gloria Patri on (`gloria: yes` or `gloria: no` overrides it either way). Psalm lines take lectionary citations as printed: `72:1-7,18-19`, `34:1-8,(19-22)`, `89:20-37`, `119:9-16`.

   `python tools/lectionary.py 2026-11-08 8` lists the next eight Sundays' psalms. The browser's *Coming up* tab shows the same with chant ideas.

2. Build:

   ```
   python tools/build.py parish/sundays/2026-11-08.txt
   ```

   The build prints a few checks first: whether each double chant comes out even (counting † verses), and how the key moves when the chant changes. Then it writes, in `parish/output/2026-11-08/`:
   - `psalm_2026-11-08.pdf`: the choir copy. A chant is printed again at the top of a page when its verses continue there.
   - `psalm_2026-11-08.ly`: the LilyPond file behind the PDF, if you want to tweak one Sunday by hand.
   - `admin/01_chant_….jpg`, `02_text_…jpg`, …: tightly cropped images, numbered in the order they are sung. The psalm title appears on the first text image only.

   Use `--check` to see only the checks, or `--pdf-only` to skip the images.

## The rest of the service and the weekly email

### Orders of service

What music a service has is written down once, in `services.txt`: one block per kind of service, one line per piece of music in the order it happens.

```
Evensong
  prelude:    Prelude
  opening:    Opening hymn                (hymn)
  preces:     Preces & Responses
  canticles:  Magnificat & Nunc dimittis
  anthem:     Anthem                      (anthem)
  closing:    Closing hymn                (hymn)
  postlude:   Postlude
```

The label is what the email says (`bare` leaves it out: "* Magnificat in B flat - Stanford"; `words=magnificat` puts the canticle's words, from `parish/anthems/magnificat.txt`, under whatever setting is sung). An order can also set its own email subject and opening line, as Evensong does ("Music for 06/13 (Evensong)", "Here's the music for the evensong on June 13th!"); a `lead:` line in the Sunday file (*Added to the opening line* in the planner) carries on that sentence for one week. The kind says how to treat what you type: `hymn` (hymn numbers, one or several), `anthem` (a hymn, or a piece whose words go in the email), `service` (service music: carried on from the last service of that kind), or nothing for anything else. `optional` hides a box until you ask for it (the Kyrie, in Lent). The psalter comes with Eucharist, Evensong, Ash Wednesday, Palm Sunday, Maundy Thursday, Good Friday and the Easter Vigil. A parish that does things differently copies the file to `parish/services.txt` and changes it (there, a column name in [brackets] says which column of an old music-schedule spreadsheet each piece was written in). Add a block for anything else that comes round (Lessons and Carols, a Requiem, Compline) and it appears in the Service box.

A Sunday file picks its order with `service: Evensong`; without one, the order named like the day (Palm Sunday, Easter Vigil, Christmas Eve) if there is one, else the first in the file. `python tools/service.py orders` lists them.

### In a Sunday file

The same lines can go in any Sunday file by hand (`examples/11-whole-service.txt`):

```
organist:  AYC
prelude:   Voluntary in A minor - Orlando Gibbons (1583-1625)
opening:   390                  # The Hymnal 1982 unless another book is named
gradual:   LEVAS 114
offertory: 596
communion: O come, ye servants of the Lord - Christopher Tye (1505-1573)
closing:   397
postlude:  Fantasia, FVB 208 - Giles Farnaby (1563-1640)
gloria in excelsis: S278        # service music, also kyrie:, sanctus:, agnus dei:
sanctus:   S128
agnus dei: S165
also:      Processional hymn: 787 (WLP)
lead:      Most of the music is by Stanford.     # added to the opening sentence
note:      A line for the office.               # after the list
```

`python tools/service.py draft parish/sundays/2026-11-08.txt` puts the email in Gmail Drafts; `… email …` only prints it and writes it, with the renamed images and the `.eml` file, to `parish/output/2026-11-08/email/`. The recipients, greeting, subject, wording, signature and layout (what each line starts with, what goes around an anthem's words, whether the usual service's service music is listed always, never or only when it changes, the images' file names) are in `parish.txt`: `parish.example/parish.txt` lists them all with their defaults. Hymn titles come from hymnary.org's indexes, which mostly give the first line; where you call a hymn something else (LEVAS 114 is listed as "Upon the mountain my Lord spoke"), add your wording to `parish/hymn_titles.csv`, or type it after the number for one Sunday (`LEVAS 114 Ev'ry Time I Feel the Spirit`). `python tools/new_sunday.py` starts these lines for you, filled from the music schedule where it has the date.

The Sunday files are now the music record: the History tab, hymn histories and the planner's suggestions read them together with `schedule.csv` (the old spreadsheet, used for any date without a Sunday file), so there's nothing to write down separately. `python tools/service.py record` writes the lot, one row per piece (date, service, organist, what, item), to `parish/schedule/record.csv`.

### Just a psalm

**Psalm only** at the top of the planner hides the rest of the service and the email: a date is optional (*no date* for a rehearsal or a one-off; name the file instead), and everything else (chants, chant changes, the †, the preview, the PDF and images) works the same. From the Psalms tab, *set this psalm to a chant* opens it there. A file without a date stays out of the history and the schedule.

### The music schedule spreadsheet

**Record in the music schedule…** (under the email; or `python tools/spreadsheet.py parish/sundays/2026-11-08.txt`, `--write` to write) shows what the Sunday would change in the spreadsheet, cell by cell, then writes it. It finds the year's tab and the date's column, and fills the rows from the [brackets] in `parish/services.txt`: `390 (EH1982)` with the cell linked to the hymn on hymnary.org, `S278 (EH1982)`, `Kyrie S86 (EH1982)` when the Kyrie shares the Gloria's row, `70 (Goss-10)`, both canticles of one setting as `Magnificat & Nunc dimittis in G - Stanford`. Only cells the Sunday file has something for are touched. A service the sheet has no column for (a Saturday Evensong) gets one, in date order, laid out like its neighbours; a new year gets a new tab.

The spreadsheet is expected to have a column per service, with its date in the first row, and a row per piece named in the first column (the [bracket] names, plus Psalm, Organist and Proper for the day). Within that, `parish.txt` describes yours: a tab per year or one tab for everything, how many columns a service takes, your own row names ("Opening hymn = Opening"), how a hymn is written in a cell and under what name each hymnal, and whether hymn cells link to hymnary.org (`parish.example/parish.txt` has them all). A spreadsheet laid out the other way round (a row per service) isn't supported yet. `tools/import_schedule.py` reads such a spreadsheet's past years into `schedule.csv`, so the planner knows what was done before. Services marked `spreadsheet: no` in `services.txt` (Lessons and Carols) stay out: their Sunday file is the record.

`spreadsheet:` in `parish.txt` says where the spreadsheet is: `google` for a Google Sheet, or the path of an `.xlsx` file (then a copy goes to `schedule/backups/` before each write; close it in Excel first).

**Connecting the Google Sheet, once.** The planner reaches the sheet through a small script that lives in the sheet itself (`tools/google_sheet.gs`) and runs as the music account, so no Google Cloud setup is needed. The first time you click *Record in the music schedule…*, it shows the steps: copy the script (it carries a secret made for you), paste it into the sheet's *Extensions › Apps Script*, deploy it as a web app, paste the web app's address back into the planner. The address and secret are kept on this computer (like the Gmail password), never in a repository. The same script has `fixHymnLinks`: run it once from the script editor to point every hymn cell's link at the hymn it names, on the whole cell; it lists each change with a link to the cell. (`addMissingHymnLinks` also links hymn cells that have none.)

### Lessons and Carols, and other services in a free order

A service whose order of service has `repeat` pieces (Advent Lessons and Carols: lessons, hymns and carols, as many as you like, in any order) shows in the planner as a list: pick what each row is, type it, move rows with ↑ ↓, add more at the bottom. *Start from last year's order* copies the previous one to begin with. A lesson is typed as the reading (`Isaiah 40:1-11`); its one-line summary comes from `parish/lessons.csv`, or type it after a `|`. The email numbers them (*The First Lesson: Isaiah 40:1–11 (God comforts his people…)*) and puts each carol's words after it, from `parish/anthems/` as for anthems.

The **History** tab's *Whole services* view has **Download the whole record (CSV)**: every service on record, one row per piece, with the lectionary day and hymn titles (handy for planning repertoire elsewhere). It lists every service on record, with a filter (a date, a hymn number, a composer) and a choice of kind of service.

### Gmail drafts

The launcher saves the draft into Gmail over IMAP, with an app password: a password Google makes for one program, which you can revoke at any time and which can't change the account's settings. Once:

1. Signed in to Google as the music account (2-Step Verification has to be on), open [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords) and make one called "Psalter".
2. Paste it into **Connect Gmail** under the email in the Service planner (or run `python tools/gmail.py connect`).

It's kept in the computer's own password store (Windows Credential Manager, the macOS Keychain) via the `keyring` package, or, without it, in a file only you can read in your home folder; never in either repository. `python tools/gmail.py forget` removes it. If the page for app passwords says they aren't available, the parish's Google Workspace admin has turned them off; they can allow them for the music account.

## Plainchant psalm tones

The **Chants** tab has a *Plainchant psalm tones* view with every tone and ending in notation, with playback, the mode's traditional character, and a button to use it in the psalm builder.

For Lent, Holy Week or any time a plainer setting suits, put `tone: VIIa` (or any Liber Usualis tone and ending: `1D`, `8G`, `4E`, `per` …) in place of `chant:`; see `examples/10-plainchant-tone.txt`. The builder accepts `tone 7a` in the chant box.

The page prints the tone on a four-line staff with a movable C (or F) clef and square notes, since only the relative pitch matters, then every verse pointed for the tone in words:

- a short stroke where the cadence begins;
- **bold** for the accented syllables;
- a small slur under any syllable sung to more than one note;
- † for a flex;
- the syllables sung to the intonation in brackets and italic: *(My God),* my God, why have you forsaken me?

The intonation is sung on verse 1 only. For a psalm or canticle where it should come on every verse, tick *sing the tone's intonation on every verse* under the psalm (or put `intonation: every verse` under the psalm line).

The accents follow the natural stress of the words (from a pronouncing dictionary, with little words such as *the*, *of*, *my* left unstressed), so the Anglican pointing isn't needed. The tone formulas are in `reference/psalm_tones.json`, from the public-domain jgabc project.

## The chant browser

Open it with the launcher, or just double-click `parish/site/index.html` (it works offline straight from the folder; the builder's Check, Build and exact-preview buttons, and saving, need the launcher).

- **Coming up**: the next Sundays and feasts with their appointed psalms, moods and chant ideas.
- **Service planner**: see above.

- **Chants**: every chant with its notation, key, single or double, soprano range, the psalm ACP sets it to, your rating and notes, and how often and when you last used it. Filter by mood, mode, rating; sort by longest since used. **Play** gives a rough organ-like playback.
- **Psalms**: every text with its mood tags, the chants that match those tags best, and what you sang it to before.
- **History**: every pairing since September 2023. A new Sunday joins the history once it's confirmed as sung: click **Mark as sung** (listed at the top of the History tab once the date has passed, with the launcher), tick *sung* in the builder, or add `sung: yes` to its file. Until then it shows as *planned* under Coming up, and its chants are still avoided in suggestions for nearby Sundays.

**Tagging chants.** On any chant, click *Edit mood, rating, notes* and click mood tags on or off; then click **Save** at the top. With the launcher this writes `parish/chant_notes.csv` directly (opened as a plain file, Chrome or Edge ask you to pick that file once; other browsers download it). You can also type tags straight into the Mood column of that file, separated by `;`.

**Matching.** A chant scores fully for each mood it shares with the text and partly for one in the same family (bright, calm, shadowed, dark). The text's first tag counts most. Ties go to higher rating, then to the chant used least recently. The psalm moods in `texts/moods.csv` are a first draft for you to correct.

`python tools/browser.py` refreshes the page after you change the catalog, moods, texts or Sunday files. It draws notation only for new or changed chants (that part needs LilyPond).

## The text format

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

## The look

All the typographic choices are named settings at the top of `style/psalm-style.ily`, each with a one-line comment: typeface and weight, bar height and spacing, brackets, held-syllable mark, dagger, indents, verse spacing. Change a number and rebuild. Nothing else needs touching.

## Setting up a computer

- LilyPond **2.26.0**: the spacing is tuned for this version. A different version still works, and the build prints a note saying it isn't 2.26.0. If `lilypond` is not on the PATH, set the `LILYPOND` environment variable to the program.
- Python 3.9 or later, then `pip install -r requirements.txt`.

## Adding a chant

Copy it into `chants/` in the same layout as the others: `global`, `S_notes`, `A_notes`, `T_notes`, `B_notes`, the composer in `\header`, and the score in a `\markup { \fill-line { \score … } }` block. Then add a row to `chants/catalog.csv` (or to `parish/chants/` and its catalog if it's still under copyright). The build works out single or double and the key from the notes.

## Old-format text files

`python tools/import_ly.py Psalm_xxx.ly` converts a text file in the old LilyPond `\line` layout to the format above.

## Roadmap

- **Pointing that can be shared.** Automatic Anglican-chant pointing from word stress (as the plainchant tones already do), checked against printed psalters, so that every psalm comes pointed.
- **The plainchant tones.** An audit of the tone pointing against printed English plainsong psalters, and a hand override for an accent.
- **Canticles.** All the BCP canticles (1–21) and the Gloria Patri.
- **More parishes.** A first-run setup that writes `parish.txt`; importing a music spreadsheet laid out a row per service; more hymnals; other psalters (Coverdale, Common Worship) and lectionaries.
- **A demo** of the chant browser on GitHub Pages.
- **The corpus.** The chants in LilyPond and MusicXML with their metadata, as a dataset, and studies it allows: keys and ranges across composers and periods, whether mood tags follow from musical features, and automatic pointing.

## License

The code is under the MIT License (`LICENSE`). The texts' mood tags, the chant catalog and the other data are under Creative Commons Attribution 4.0 (`LICENSE-DATA.md`). The psalm texts are from the 1979 Book of Common Prayer, which is in the public domain, as are the chants included here. The psalm tones come from the jgabc project (public domain). The EB Garamond fonts are under the SIL Open Font License (`style/fonts/OFL.txt`).
