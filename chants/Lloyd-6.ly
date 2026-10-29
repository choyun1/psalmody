\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Harford Lloyd (1849-1919)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | d'4 d | g,2 \bar "||"
  a2 | e'4 c | b a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | e2 \bar "||"
  e2 | e4 a | g fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 a | b2 \bar "||"
  c2 | b4 e | d c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | g4 fis | e2 \bar "||"
  a2 | gis4 a | d d, | g2 \bar "||"
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
