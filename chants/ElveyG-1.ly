\version "2.24.1"

\header{
  composer = \markup{\hspace #-32 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | d4 cis | d2 \bar "||"
  b2 | a4 fis | e d | e2 | \bar "||"
  fis2 | b4 ais | b2 \bar "||"
  b2 | cis4 d | fis, e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | fis4 e | d2 \bar "||"
  d2 | e4 d | b d | d cis | \bar "||"
  cis2 | b4 e | d2 \bar "||"
  d2 | g4 fis | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  fis2 | a4 g | a2 \bar "||"
  g2 | e4 fis | g gis | a2 | \bar "||"
  ais2 | fis4 fis | fis2 \bar "||"
  g2 | g4 a | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | d4 e | fis2 \bar "||"
  g2 | cis,4 d | g, b | a2 | \bar "||"
  fis'2 | d4 cis | b2 \bar "||"
  g'2 | e4 d | a' a, | d2 | \bar "||"
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