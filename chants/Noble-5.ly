\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tertius Noble (1867-1953)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | d'4 c | a2 \bar "||"
  b2 | g4 gis | a c | b2 \bar "||"
  b2 | e4 c | a2 \bar "||"
  fis2 | g4 a | c a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | g4 g | fis2 \bar "||"
  fis2 | e4 e | e fis8 e | dis2 \bar "||"
  e2 | e4 a8 g | fis2 \bar "||"
  d2 | d4 d | c d | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | d4 e | d2 \bar "||"
  b2 | b4 b | e, a | fis2 \bar "||"
  gis2 | a4 c | d2 \bar "||"
  c2 | b4 a | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | b,4 c | d2 \bar "||"
  dis2 | e4 d | c a | b2 \bar "||"
  e2 | c4 a | d2 \bar "||"
  a'2 | g4 fis | e d | g,2 \bar "||"
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
