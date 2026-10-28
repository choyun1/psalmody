[Psalmody](../README.md) › Orders of service

# Orders of service

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

## In a Sunday file

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


## The record

The Sunday files are the music record: the History tab, hymn histories and the planner's suggestions read them together with `schedule.csv` (the old spreadsheet, used for any date without a Sunday file), so there's nothing to write down separately. `python tools/service.py record` writes the lot, one row per piece (date, service, organist, what, item), to `parish/schedule/record.csv`.
