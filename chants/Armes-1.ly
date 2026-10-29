\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Philip Armes (1836-1908)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 b8 a | g2 \bar "||"
  g2 | g4 d | g b | a2 \bar "||"
  a2 | b4 c8 b | a2 \bar "||"
  a2 | d4 d | c a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 fis | g2 \bar "||"
  e2 | d4 a | d g | fis2 \bar "||"
  e2 | f4 e | e2 \bar "||"
  d2 | d4 f | e fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | c4 d8 c | b2 \bar "||"
  c2 | g4 fis | g d' | d2 \bar "||"
  c2 | d4 e8 d | c2 \bar "||"
  fis,2 | g4 gis | a c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 d | e2 \bar "||"
  c2 | b4 d8 c | b4 g | d'2 \bar "||"
  a'2 | a4 gis | a2 \bar "||"
  c,2 | b4 b | c d | g,2 \bar "||"
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
