\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | fis4 a | b2 \bar "||"
  b2 | g4 b | d e | d2 \bar "||"
}

A_notes = \relative c' {
  fis2 | fis4 e | g2 \bar "||"
  g2 | e4 g | fis a | fis2 \bar "||"
}

T_notes = \relative c' {
  d2 | d4 e | d2 \bar "||"
  e2 | b4 e | d cis | d2 \bar "||"
}

B_notes = \relative c {
  d2 | d'4 cis | b2 \bar "||"
  e,2 | g4 e | b' a | d,2 \bar "||"
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
