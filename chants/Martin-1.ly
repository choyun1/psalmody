\version "2.24.1"

\header{
  composer = \markup{\hspace #-40 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  e2 | a4 b | cis2 \bar "||"
  cis2 | d4 cis | cis b | a gis | \bar "||"
  a2 | cis4 d | e2 \bar "||"
  a,2 | d4 cis | cis b | a2 \bar "||"
}

A_notes = \relative c' {
  cis2 | cis4 e | e2 \bar "||"
  e2 | d4 fis | fis fis | fis eis | \bar "||"
  fis2 | g4 g | g2 \bar "||"
  fis2 | d4 e | fis gis | a2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 gis | a g \bar "||"
  fis2 | fis4 ais | ais b | cis2 | \bar "||"
  cis2 | a4 b | a2 \bar "||"
  a2 | gis4 a | a d | cis2 | \bar "||"
}

B_notes =  \relative c {
  a2 | fis'4 e | a,2 \bar "||"
  ais2 | b4 cis | d d | cis2 | \bar "||"
  fis2 | e4 d | cis2 \bar "||"
  d2 | b4 cis | d e | a,2 | \bar "||"
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