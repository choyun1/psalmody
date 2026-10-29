\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Daniel Purcell (c. 1664-1717)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 fis | g2 \bar "||"
  c2 | fis,4 g | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | c4 c | b2 \bar "||"
  e2 | d4 d | d d | d2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 a | g2 \bar "||"
  g2 | d'8 c b4 | a a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | a4 d, | g2 \bar "||"
  c,2 | d4 g | d d | g,2 \bar "||"
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
