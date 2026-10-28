# Psalmody repo notes

- Texts in `texts/*.txt` are the 1979 BCP words, unpointed, and must match it word for word; run `python tools/check_texts.py` after any text edit.
- Never add pointing copied from a printed psalter (the Anglican Chant Psalter and others are under copyright) to `texts/`. A parish's own pointed copies go in `parish/texts/`, which take the place of the unpointed ones.
- Only public-domain chants go in `chants/` (with a row in `chants/catalog.csv`); anything still under copyright goes in a parish's `parish/chants/`.
- Mood vocabulary lives in `moods.txt`; use only those tags in `texts/moods.csv` and the Mood column of a parish's chant notes.
- `parish/` is each user's own folder (often its own private repository) and is never committed here; `parish.example/` is the template. `tools/paths.py` says where everything is.
- Anything specific to one parish (name, track, email, spreadsheet, orders of service) belongs in its `parish/` folder, not in code.
- Never store a Gmail app password or a Google Sheet web-app address or secret in a repository; `tools/keystore.py` keeps them in the OS keyring or `~/.psalter/`.
