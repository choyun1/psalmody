\version "2.24.1"

\header{
  composer = \markup{\hspace #-30.5 \italic "John Randall (1716-1799)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | d,4 e | fis2 \bar "||"
  a2 | d4 cis | cis b | a2 | \bar "||"
  fis2 | g4 a | b2 \bar "||"
  a2 | g4 fis | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  fis2 | d4 e | e d | cis2 | \bar "||"
  d2 | d4 c | b2 \bar "||"
  d2 | cis4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  fis2 | a4 a | a2 \bar "||"
  a2 | gis4 a | a gis | a2 | \bar "||"
  a2 | g4 fis | g2 \bar "||"
  a2 | a4 a | a g | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | fis4 a | d,2 \bar "||"
  d2 | b4 a | e' e | a,2 | \bar "||"
  d2 | b4 a | g2 \bar "||"
  fis'2 | e4 d | a a | d2 | \bar "||"
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