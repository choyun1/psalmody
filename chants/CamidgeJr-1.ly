\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Camidge, Jr. (1790-1859)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | fis4 a | gis2 \bar "||"
  fis2 | e4 a | d4 cis | cis b \bar "||"
  b2 | cis4 d | gis,2 \bar "||"
  gis2 | a4 b | cis b | a2 \bar "||"
}

A_notes = \relative c' {
  cis2 | cis4 cis | d2 \bar "||"
  b2 | e4 e | d e | e2 \bar "||"
  fis2 | e4 d | d2 \bar "||"
  d2 | cis4 fis | e4. d8 | cis2 \bar "||"
}

T_notes = \relative c {
  e2 | a4 fis | e2 \bar "||"
  fis4. gis8 | a4 e | fis8 gis a4 | a4 gis \bar "||"
  fis2 | ais4 b | b2 \bar "||"
  b2 | a4 a | a gis | a2 \bar "||"
}

B_notes = \relative c {
  a2 | a4 a | b2 \bar "||"
  d2 | cis4 cis | b a | e'2 \bar "||"
  d2 | cis4 b | e2 \bar "||"
  eis2 | fis4 d | e e | a,2 \bar "||"
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
