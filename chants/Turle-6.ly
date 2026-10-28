\version "2.24.1"

\header{
  composer = \markup{\hspace #-29 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | d,4 e | fis2 \bar "||"
  fis2 | fis4 fis | fis g | fis e | \bar "||"
  d'2 | fis,4 b | a2 \bar "||"
  a2 | a4 g | fis e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  cis2 | b4 ais | b e | d cis | \bar "||"
  b2 | cis4 d8 e | fis2 \bar "||"
  d2 | fis4 e | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  fis2 | fis4 a | a2 \bar "||"
  ais2 | b4 e | d b | a2 | \bar "||"
  d2 | cis4 b8 cis | d2 \bar "||"
  a2 | b4 b | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | b4 a | d2 \bar "||"
  fis2 | d4 cis | b g' | a2 | \bar "||"
  b2 | a4 g | fis2 \bar "||"
  fis2 | g4 g | a a, | d2 | \bar "||"
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