\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 d, | g2 \bar "||"
  a2 | b4 d | c a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | d2 \bar "||"
  fis2 | g4 g | g fis | g2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 fis | g2 \bar "||"
  c2 | d4 d | e c | b2 \bar "||"
}

B_notes = \relative c {
  b2 | c4 c | b2 \bar "||"
  d2 | g4 b | a d, | g2 \bar "||"
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
