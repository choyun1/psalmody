\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c' {
  d2 | e4 g | c2 \bar "||"
  a2 | b4 d | g, fis8 g | a2 \bar "||"
  a4. b8 | c4 d | e2 \bar "||"
  fis,2 | g4 c8 b | a4 a | g2 \bar "||"
}

A_notes = \relative c' {
  b2 | c4 d | e2 \bar "||"
  d2 | d4 d | d cis | d2 \bar "||"
  d2 | g4 f | e2 \bar "||"
  d2 | d4 e | e d8 c | b2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 b | a2 \bar "||"
  a2 | g4 a | b a8 g | fis2 \bar "||"
  f2 | g4 b | c2 \bar "||"
  a2 | g4 g | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | g4 g | g2 \bar "||"
  fis2 | g4 fis | e e | d2 \bar "||"
  d2 | e4 g | c,2 \bar "||"
  c2 | b4 a8 b | c4 d | g,2 \bar "||"
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
