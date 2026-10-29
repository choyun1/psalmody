\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Galpin Alcock (1861-1947)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 g | f2 \bar "||"
  bes2 | c4 bes | bes es | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 es8 d | c2 \bar "||"
  bes2 | as'4 as | g g | f2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 c8 bes | a2 \bar "||"
  d2 | es4 f | bes, bes | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | es4 c | f2 \bar "||"
  g2 | f4 d | es g | bes2 \bar "||"
}

% Use markup to center the chant on the page
\markup {
  \fill-line {
    \score {  % centered
      <<
        \new ChoirStaff <<
          \new Staff <<
            \global
            \clef "treble"
            \new Voice = "Soprano" <<
              \voiceOne \S_notes
            >>
            \new Voice = "Alto" <<
              \voiceTwo \A_notes
            >>
          >>
          \new Staff <<
            \global
            \clef "bass"
            \new Voice = "Tenor" <<
              \voiceOne \T_notes
            >>
            \new Voice = "Bass" <<
              \voiceTwo \B_notes
            >>
          >>
        >>
      >>

      \layout {
        \context {
          \Staff
          \remove "Time_signature_engraver"
        }
      }
    }  % End score
  }
}  % End markup
