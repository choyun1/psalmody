\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Kelway (c. 1695-1744)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | bes4 c | a2 \bar "||"
  bes2 | g4 a | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | g4 g | f2 \bar "||"
  g2 | g4 es | d d | d2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 es | c2 \bar "||"
  bes2 | bes4 c | bes a | bes2 \bar "||"
}

B_notes = \relative c' {
  g2 | es4 c | f2 \bar "||"
  d2 | es4 c | d d | g,2 \bar "||"
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
