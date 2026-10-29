\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | b4 cis | d2 \bar "||"
  b2 | cis4 a | gis a | b2 \bar "||"
  a2 | b4 cis | d2 \bar "||"
  b2 | cis4 a | a gis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | d2 \bar "||"
  e2 | e4 e | d cis | e2 \bar "||"
  cis2 | fis4 e | d2 \bar "||"
  e2 | e4 cis | b b | cis2 \bar "||"
}

T_notes = \relative c' {
  cis2 | b4 a | a2 \bar "||"
  b2 | a4 a | b e,8 fis | gis2 \bar "||"
  a2 | fis4 ais | b2 \bar "||"
  gis2 | a4 e | fis e | e2 \bar "||"
}

B_notes = \relative c' {
  a2 | gis4 a | fis2 \bar "||"
  gis2 | a4 cis, | b a | e'2 \bar "||"
  fis2 | d4 cis | b2 \bar "||"
  e2 | a,4 cis | d e | a,2 \bar "||"
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
