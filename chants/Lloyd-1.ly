\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Harford Lloyd (1849-1919)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | b4 e | d2 \bar "||"
  b2 | cis4 b | a b | gis2 \bar "||"
  a2 | a4 g | fis2 \bar "||"
  b2 | gis4 a | b cis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | fis4 e | a2 \bar "||"
  e2 | e4 eis | fis fis | e2 \bar "||"
  e2 | fis4 e | a,2 \bar "||"
  fis'2 | e4 cis | fis gis | a2 \bar "||"
}

T_notes = \relative c' {
  cis2 | d4 b | a2 \bar "||"
  b2 | e4 cis | cis b | b2 \bar "||"
  a2 | d4 a | a2 \bar "||"
  d2 | b4 a | d d | cis2 \bar "||"
}

B_notes = \relative c' {
  a2 | a4 gis | fis2 \bar "||"
  gis2 | a4 gis | fis d | e2 \bar "||"
  cis2 | b4 cis | d2 \bar "||"
  b2 | e4 fis | d e | a2 \bar "||"
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
