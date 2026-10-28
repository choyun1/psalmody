\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | cis4 a | fis2 \bar "||"
  gis2 | a4 b | cis dis | e2 | \bar "||"
  b2 | e4 cis | a2 \bar "||"
  d2 | cis4 b | a gis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | d2 \bar "||"
  d2 | e4 e | e a | gis2 | \bar "||"
  e2 | e4 e | cis2 \bar "||"
  fis4. gis8 | a4 fis | e4. d8 | cis2 | \bar "||"
}

T_notes = \relative a {
  cis2 | e4 cis | a2 \bar "||"
  b2 | a4 gis | a a | b2 | \bar "||"
  gis2 | gis4 gis | a2 \bar "||"
  b2 | e4 d | cis b | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | a4 cis | d2 \bar "||"
  b2 | cis4 e | a fis | e2 | \bar "||"
  e2 | cis4 e | fis2 \bar "||"
  b,2 | cis4 d | e e | a,2 | \bar "||"
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