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
  g2 | c4 b | a2 \bar "||"
  fis2 | g4 b | a fis | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | g4 g | e2 \bar "||"
  d2 | e4 fis | e d | d2 \bar "||"
}

T_notes = \relative c' {
  b2 | c4 d | c2 \bar "||"
  b2 | b4 b | c a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | e4 g | a2 \bar "||"
  b2 | e,4 d | c d | g2 \bar "||"
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
