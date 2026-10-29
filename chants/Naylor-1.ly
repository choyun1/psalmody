\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Naylor (1838-1897)"}
  tagline=#f
}

global = {
  \key e \minor
  \time 2/4
}


S_notes = \relative c' {
  e2 | e4 e | fis2 \bar "||"
  g2 | a4 c | b a | g2 \bar "||"
  g2 | g4 g | a2 \bar "||"
  b2 | c4 e, | e dis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | fis2 \bar "||"
  d2 | e4 a | g fis | g2 \bar "||"
  g2 | g4 g | a2 \bar "||"
  e2 | e4 c | b b | b2 \bar "||"
}

T_notes = \relative c' {
  g2 | a4 b | c2 \bar "||"
  d2 | c4 e | d c | b2 \bar "||"
  b2 | c4 b | e2 \bar "||"
  d2 | c4 b8 a | g4 fis | g2 \bar "||"
}

B_notes = \relative c {
  e2 | fis4 g | a2 \bar "||"
  b2 | c4 c, | d d | g2 \bar "||"
  g2 | e4 d | c2 \bar "||"
  gis2 | a4 a | b b | e2 \bar "||"
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
