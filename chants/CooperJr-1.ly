\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George (junior) Cooper (1820-1876)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | b4 a | g2 \bar "||"
  c2 | c4 b | c d | b2 \bar "||"
  g2 | e'4 d | c2 \bar "||"
  a2 | d4 g, | b a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 c | b2 \bar "||"
  e2 | e4 e | e d | d2 \bar "||"
  d2 | e4 e | e2 \bar "||"
  d2 | d4 cis | d fis | g2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 fis | g2 \bar "||"
  a2 | a4 gis | a a | b2 \bar "||"
  b2 | c4 gis | a2 \bar "||"
  fis2 | g4 g | g d' | b2 \bar "||"
}

B_notes = \relative c {
  g2 | b4 d | e2 \bar "||"
  a,2 | c4 e | fis fis | g2 \bar "||"
  g2 | c,4 b | a2 \bar "||"
  c2 | b4 e | d d | g2 \bar "||"
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
