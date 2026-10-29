\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tertius Noble (1867-1953)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | e4 fis | gis2 \bar "||"
  gis2 | a4 b | cis4 d | cis4 b \bar "||"
  b2 | b4 cis | d2 \bar "||"
  gis,2 | a4 b | cis4 b | d4 cis \bar "||"
}

A_notes = \relative c' {
  cis2 | cis4 cis | e2 \bar "||"
  eis2 | fis4 d | e4 fis | e2 \bar "||"
  e2 | fis4 fis | fis2 \bar "||"
  eis2 | fis4 d | e4 e | fis4 e \bar "||"
}

T_notes = \relative c' {
  a2 | a4 a | b2 \bar "||"
  cis2 | cis4 a | a4 a | a4 gis \bar "||"
  g2 | b4 e | d2 \bar "||"
  cis2 | cis4 a | a4 gis | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | gis4 fis | e2 \bar "||"
  cis2 | fis4 fis | e4 d | e2 \bar "||"
  e2 | d4 cis | b2 \bar "||"
  cis2 | fis4 fis | e4 e | a,2 \bar "||"
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
