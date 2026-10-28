[Psalmody](../README.md) › The chant browser

# The chant browser

Open it with the launcher, or just double-click `parish/site/index.html` (it works offline straight from the folder; the builder's Check, Build and exact-preview buttons, and saving, need the launcher).

- **Coming up**: the next Sundays and feasts with their appointed psalms, moods and chant ideas.
- **Service planner**: see [Each week](weekly.md).
- **Chants**: every chant with its notation, key, single or double, soprano range, the psalm ACP sets it to, your rating and notes, and how often and when you last used it. Filter by mood, mode, rating; sort by longest since used. **Play** gives a rough organ-like playback.
- **Psalms**: every text with its mood tags, the chants that match those tags best, and what you sang it to before.
- **History**: every pairing since September 2023. A new Sunday joins the history once it's confirmed as sung: click **Mark as sung** (listed at the top of the History tab once the date has passed, with the launcher), tick *sung* in the builder, or add `sung: yes` to its file. Until then it shows as *planned* under Coming up, and its chants are still avoided in suggestions for nearby Sundays.

**Tagging chants.** On any chant, click *Edit mood, rating, notes* and click mood tags on or off; then click **Save** at the top. With the launcher this writes `parish/chant_notes.csv` directly (opened as a plain file, Chrome or Edge ask you to pick that file once; other browsers download it). You can also type tags straight into the Mood column of that file, separated by `;`.

**Matching.** A chant scores fully for each mood it shares with the text and partly for one in the same family (bright, calm, shadowed, dark). The text's first tag counts most. Ties go to higher rating, then to the chant used least recently. The psalm moods in `texts/moods.csv` are a first draft for you to correct.

`python tools/browser.py` refreshes the page after you change the catalog, moods, texts or Sunday files. It draws notation only for new or changed chants (that part needs LilyPond).
