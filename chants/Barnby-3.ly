\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key fis \minor
  \time 2/4
}


S_notes = \relative g' {
  fis2 | fis4 a | gis2 \bar "||"
  gis2 | a4 gis | a b | cis2 | \bar "||"
  cis2 | d4 cis | b2 \bar "||"
  a2 | gis4 a8 b | a4 gis | fis2 | \bar "||"
}

A_notes = \relative c' {
  cis2 | cis4 cis | d2 \bar "||"
  cis2 | cis4 cis | fis fis | e2 | \bar "||"
  e2 | d4 e | fis2 \bar "||"
  fis2 | fis4 fis | fis eis | fis2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 a | b2 \bar "||"
  b2 | a4 cis | fis, gis | a2 | \bar "||"
  fis2 | fis4 ais | b2 \bar "||"
  cis2 | d4 b | cis4. b8 | a2 | \bar "||"
}

B_notes =  \relative c {
  fis2 | fis4 fis | fis2 \bar "||"
  eis2 | fis4 e? | d d | a2 | \bar "||"
  ais2 | b4 cis | d2 \bar "||"
  cis2 | b4 d | cis cis | fis2 | \bar "||"
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