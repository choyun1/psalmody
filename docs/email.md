[Psalmody](../README.md) › The weekly email

# The weekly email

**Save, build & draft the email** in the planner writes the week's email to the parish office: a greeting, the list of music with each anthem's words, and your signature, with the psalm images attached. It goes into the music account's Gmail **Drafts** to look over and send. For the usual Sunday service it mentions the service music only when it changes; for a special service it lists it all.

From the command line, `python tools/service.py draft parish/sundays/2026-11-08.txt` puts the email in Gmail Drafts; `… email …` only prints it and writes it, with the renamed images and the `.eml` file, to `parish/output/2026-11-08/email/`. The recipients, greeting, subject, wording, signature and layout (what each line starts with, what goes around an anthem's words, whether the usual service's service music is listed always, never or only when it changes, the images' file names) are in `parish.txt`: `parish.example/parish.txt` lists them all with their defaults. Hymn titles come from hymnary.org's indexes, which mostly give the first line; where you call a hymn something else (LEVAS 114 is listed as "Upon the mountain my Lord spoke"), add your wording to `parish/hymn_titles.csv`, or type it after the number for one Sunday (`LEVAS 114 Ev'ry Time I Feel the Spirit`). `python tools/new_sunday.py` starts these lines for you, filled from the music schedule where it has the date.

## Gmail drafts

The launcher saves the draft into Gmail over IMAP, with an app password: a password Google makes for one program, which you can revoke at any time and which can't change the account's settings. Once:

1. Signed in to Google as the music account (2-Step Verification has to be on), open [myaccount.google.com/apppasswords](https://myaccount.google.com/apppasswords) and make one called "Psalter".
2. Paste it into **Connect Gmail** under the email in the Service planner (or run `python tools/gmail.py connect`).

It's kept in the computer's own password store (Windows Credential Manager, the macOS Keychain) via the `keyring` package, or, without it, in a file only you can read in your home folder; never in either repository. `python tools/gmail.py forget` removes it. If the page for app passwords says they aren't available, the parish's Google Workspace admin has turned them off; they can allow them for the music account.
