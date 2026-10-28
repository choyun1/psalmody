\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Attwood (1765-1838)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  d'2 | e4 fis | a,2 \bar "||"
  d2 | fis,4 b | a b | e,2 | \bar "||"
  e2 | g4 fis | g2 \bar "||"
  a2 | a4 d | fis, e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | g4 fis | e2 \bar "||"
  g2 | d4 e | fis e | e2 | \bar "||"
  e2 | e4 dis | e2 \bar "||"
  g2 | g8 fis e d | d4 cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 a | a2 \bar "||"
  g2 | a4 cis | d d | cis2 | \bar "||"
  cis2 | b4 b | b2 \bar "||"
  e2 | a,4 g | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  fis2 | e4 d | cis2 \bar "||"
  b2 | a4 g' | fis g | a2 | \bar "||"
  a2 | e4 b | e2 \bar "||"
  cis2 | d4 b | a a | d2 | \bar "||"
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