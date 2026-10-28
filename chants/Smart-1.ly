\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "Henry Smart (1813-1879)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  e2 | a4 cis | b2 \bar "||"
  e2 | a,4 gis | fis fis | e2 | \bar "||"
  cis'2 | b4 ais | b2 \bar "||"
  d2 | cis4 b | fis gis | a2 \bar "||"
}

A_notes = \relative c' {
  cis2 | e4 e | e2 \bar "||"
  e2 | e8 dis e4 | e dis | e2 | \bar "||"
  gis2 | fis4 fis | fis2 \bar "||"
  fis4. gis8 | a4 fis | fis e8 d | cis2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 a | gis2 \bar "||"
  gis2 | a4 b | cis b8 a | gis2 | \bar "||"
  e'2 | d4 cis | b2 \bar "||"
  b2 | e4 d | d cis8 b | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | cis4 a | e'2 \bar "||"
  cis2 | fis4 gis | a b | e,2 | \bar "||"
  cis2 | fis4. e8 | d2 \bar "||"
  b2 | cis4 d | b e | a,2 | \bar "||"
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