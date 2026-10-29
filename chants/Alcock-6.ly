\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Galpin Alcock (1861-1947)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 d | c2 \bar "||"
  b2 | a4 g8 fis | g4 a | fis2 \bar "||"
  fis2 | g4 b | a2 \bar "||"
  a2 | b4 e, | c' a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 b | c2 \bar "||"
  e2 | e4 cis | e cis | d2 \bar "||"
  dis2 | e4 b | e2 \bar "||"
  c2 | f4 e | e fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 g | g2 \bar "||"
  gis2 | a4 b | b a | a2 \bar "||"
  b2 | b4 g | e2 \bar "||"
  a2 | a4 gis | a c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 f | e2 \bar "||"
  d2 | c4 b | e a, | d2 \bar "||"
  b2 | e4 d | c2 \bar "||"
  f2 | d4 e | a, d | g,2 \bar "||"
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
