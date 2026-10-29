\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 fis | e2 \bar "||"
  e2 | e4 fis | e fis | gis2 \bar "||"
  gis2 | a4 a | fis2 \bar "||"
  e2 | e4 a | b b | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | d4 d | e2 \bar "||"
  d2 | cis4 cis | cis dis | dis2 \bar "||"
  eis2 | fis4 e | dis2 \bar "||"
  d2 | cis4 e | fis e8 d | cis2 \bar "||"
}

T_notes = \relative c' {
  cis2 | a4 a | a2 \bar "||"
  gis2 | a4 a | gis cis | bis2 \bar "||"
  cis2 | cis4 cis | b2 \bar "||"
  b2 | b4 a | a gis | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | fis4 d | cis2 \bar "||"
  b2 | a4 fis | cis' a | gis2 \bar "||"
  cis2 | fis,4 a | b2 \bar "||"
  gis2 | a4 cis | d e | a,2 \bar "||"
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
