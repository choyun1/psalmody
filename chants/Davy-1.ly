\version "2.24.1"

\header{
  composer = \markup{\hspace #-27 \italic "John Davy (1763-1824)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  d'2 | cis4 a | d2 \bar "||"
  d,2 | b'4 a | g fis | e2 | \bar "||"
  fis2 | b4 d | g,2 \bar "||"
  e2 | a4 g | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  fis2 | e4 cis | d2 \bar "||"
  d2 | g4 fis | e d | cis2 | \bar "||"
  cis2 | d4 fis | e2 \bar "||"
  cis2 | d4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | g4 g | a2 \bar "||"
  b2 | e,4 fis | g a | a2 | \bar "||"
  ais2 | b4 b | b2 \bar "||"
  a2 | a4 d | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | e4 e | fis2 \bar "||"
  b2 | cis,4 d | e fis8 g | a2 | \bar "||"
  fis2 | d4 b | e2 \bar "||"
  g2 | fis4 b | a a, | d2 | \bar "||"
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