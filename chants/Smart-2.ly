\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "Henry Smart (1813-1879)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  fis2 | e4 g | fis2 \bar "||"
  b2 | a4 d | cis b | a2 | \bar "||"
  c2 | b4 a | b2 \bar "||"
  e,2 | a4 d, | g e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | a4 d | d2 \bar "||"
  d2 | d4 fis | e d | cis2 | \bar "||"
  c2 | d4 d | d2 \bar "||"
  b2 | d4 d | e cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 d, | a'2 \bar "||"
  b2 | d4 a | a gis | a2 | \bar "||"
  e2 | g4 fis | g2 \bar "||"
  g2 | a4 fis | b g | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | cis4 b | a2 \bar "||"
  g'2 | fis4 d | e e | a,2 | \bar "||"
  a2 | d4 d | g,2 \bar "||"
  g'2 | fis4 b, | g a | d2 | \bar "||"
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