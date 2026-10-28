[Psalmody](../README.md) › Plainchant psalm tones

# Plainchant psalm tones

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
