[Psalmody](../README.md) › Each week

# Each week

Double-click **Psalter.bat** (on Linux, `psalter.sh`). It opens the chant browser with a **Service planner** tab:
1. Pick the date. The lectionary psalm is filled in; *The text* opens the pointed text of exactly the verses appointed.
2. Click **Choose…** next to a chant slot. A picker opens with every chant's notation, playback, moods and last use, filtered and sorted however you like (best match for the psalm, key, circle of fifths, longest since used…), plus the plainchant tones. Click **Use**. Add chant changes or more psalms the same way. (From the Chants tab, *Use in the psalm builder* does the same.)
   **Optional verses.** Verses the lectionary prints in brackets, as in `90:1-8,(9-11),12`, are left out unless you tick *sing the optional verses* under the psalm (set by `optional_verses: leave out` (or `sing`) in `parish.txt`). In a Sunday file it's `optional: yes` (or `no`) under the psalm line; the psalm line itself stays as the lectionary prints it.
   **Moving the †.** The psalm's *The text* shows its verse numbers; click one to put a † (sing the second half again) on that verse or take it off, for this Sunday only. The text file keeps its own. Under the chant it says at once whether each double chant comes out even, and where a † falls wrongly. In the Sunday file this is one line under the psalm, `daggers: 7, 15` (or `daggers: none`).
3. *Preview* shows the page straight away (chant notation and pointed text); **Exact PDF preview** runs LilyPond and shows the real PDF.
   **Before on this day.** Above the rest of the service, *Before on Proper 27* shows what was sung the last time these readings came round (three years ago, six…) and, folded away, the same day in the other years of the cycle: psalm, chant, hymns, anthems, voluntaries.
4. Under **The rest of the service**, fill in the prelude, hymns, anthem and postlude. The boxes follow the day's order of service (Eucharist, Evensong, Palm Sunday, Good Friday…; see [Orders of service](services.md)), chosen by the Service box or by the day itself. Anything already in the music schedule for that date is filled in, and the service music carries on from the last service of the same kind. Type a hymn number (`390`, `LEVAS 114`) and its title appears, with when it was last sung. Prelude, postlude and anthem boxes suggest everything done before. For an anthem, paste its words once; they're kept in `parish/anthems/` and come back whenever it's sung again.
5. Click **Save & build**. The PDF and the administrator's images appear as links.
6. Click **Save, build & draft the email**. It writes the week's email (greeting, the list of music with each anthem's words, the signature, all set up in `parish.txt`) and puts it in the music account's Gmail **Drafts** with the psalm images attached (`psalm_YYMMDD_chant.jpg`, `psalm_YYMMDD_text.jpg`), ready to look over and send. For the usual Sunday service it mentions the service music only when it changes; for a special service it lists it all. Edits in the box go into the draft with **Update the Gmail draft** (the earlier draft for that day goes to the Trash). The first time, it asks you to connect Gmail: see [Gmail drafts](email.md#gmail-drafts). Without that, *Other ways to send it* offers a prefilled Gmail message (drag the images in) or a `.eml` file for Outlook or Thunderbird.
7. **Record in the music schedule…** (under the email) shows what will change in the spreadsheet, cell by cell, then **Write** puts it there: see [The music schedule spreadsheet](spreadsheet.md).
8. When there are changes, a **Save N changes to GitHub** button appears at the top: it commits and pushes both repositories.

Everything stays on your computer. Close the launcher's window to stop.

## From the command line

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

## Just a psalm

**Psalm only** at the top of the planner hides the rest of the service and the email: a date is optional (*no date* for a rehearsal or a one-off; name the file instead), and everything else (chants, chant changes, the †, the preview, the PDF and images) works the same. From the Psalms tab, *set this psalm to a chant* opens it there. A file without a date stays out of the history and the schedule.

## Lessons and Carols, and other services in a free order

A service whose order of service has `repeat` pieces (Advent Lessons and Carols: lessons, hymns and carols, as many as you like, in any order) shows in the planner as a list: pick what each row is, type it, move rows with ↑ ↓, add more at the bottom. *Start from last year's order* copies the previous one to begin with. A lesson is typed as the reading (`Isaiah 40:1-11`); its one-line summary comes from `parish/lessons.csv`, or type it after a `|`. The email numbers them (*The First Lesson: Isaiah 40:1–11 (God comforts his people…)*) and puts each carol's words after it, from `parish/anthems/` as for anthems.

The **History** tab's *Whole services* view has **Download the whole record (CSV)**: every service on record, one row per piece, with the lectionary day and hymn titles (handy for planning repertoire elsewhere). It lists every service on record, with a filter (a date, a hymn number, a composer) and a choice of kind of service.
