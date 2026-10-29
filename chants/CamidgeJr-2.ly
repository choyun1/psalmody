\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Camidge, Jr. (1790-1859)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  gis2 | gis4 a | gis2 \bar "||"
  fis2 | e4 e' | dis cis | b2 \bar "||"
  b2 | a4 gis | fis2 \bar "||"
  eis2 | fis4 a | gis fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  dis2 | e4 e | e e | e2 \bar "||"
  fis2 | e4 dis | cis2 \bar "||"
  d2 | cis4 fis | e dis | e2 \bar "||"
}

T_notes = \relative c' {
  b2 | b4 a | b2 \bar "||"
  b2 | b4 b | a a | gis2 \bar "||"
  b2 | e,4 gis | cis2 \bar "||"
  b2 | a4 cis | b a | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | dis4 cis | b2 \bar "||"
  a2 | gis4 gis | a cis | e2 \bar "||"
  dis2 | cis4 b | a2 \bar "||"
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
