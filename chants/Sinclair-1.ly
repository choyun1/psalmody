\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Robertson Sinclair (1863-1917)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | e'4 d8 c | d2 \bar "||"
  b2 | c4 b8 a | b4 g | a2 \bar "||"
  g2 | g4 g | e'2 \bar "||"
  a,2 | d4 c8 b | c4 a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 fis | g2 \bar "||"
  g2 | e4 d8 c | d4 cis | c2 \bar "||"
  b2 | f'4 e8 d | e2 \bar "||"
  d2 | d4 e | e d | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | g4 a | g2 \bar "||"
  g2 | g4 fis | g g | g4 fis \bar "||"
  g2 | b4 c | g2 \bar "||"
  fis2 | g4 g | a fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | c,4 c | b2 \bar "||"
  e2 | a,4 d | g, e' | d2 \bar "||"
  e2 | d4 g, | c2 \bar "||"
  d2 | b4 e | a, d | g,2 \bar "||"
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
