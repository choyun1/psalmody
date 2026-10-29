\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Harford Lloyd (1849-1919)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | fis4 e | a2 \bar "||"
  b2 | a4 gis | a b | cis2 \bar "||"
  b2 | ais4 cis | fis,2 \bar "||"
  e2 | e4 a | a gis | gis a \bar "||"
}

A_notes = \relative c' {
  e2 | b4 e | e4 d \bar "||"
  fis2 | e4 b | e e | e2 \bar "||"
  e2 | fis4 fis | fis2 \bar "||"
  b,2 | e4 d | e e | e2 \bar "||"
}

T_notes = \relative c' {
  cis2 | b4 b | a2 \bar "||"
  d2 | cis4 b | a gis | a2 \bar "||"
  b2 | cis4 ais | cis b \bar "||"
  gis2 | a4 b | cis d | d cis \bar "||"
}

B_notes = \relative c' {
  a2 | gis4 gis | fis2 \bar "||"
  d2 | e4 d | cis e | a2 \bar "||"
  g2 | fis4 e | d2 \bar "||"
  d2 | cis4 fis | e e | a,2 \bar "||"
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
