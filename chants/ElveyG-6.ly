\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 bes | a2 \bar "||"
  bes2 | c4 es | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | es4 d8 es | f2 \bar "||"
  f2 | g4 es | f4. es8 | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 bes | c2 \bar "||"
  bes4. a8 | g4 c | bes a | bes2 \bar "||"
}

B_notes = \relative c {
  bes2 | es4 g | f2 \bar "||"
  d2 | es4 c | f f | bes,2 \bar "||"
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
