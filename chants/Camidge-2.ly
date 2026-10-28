\version "2.24.1"

\header{
  composer = \markup{\hspace #-35 \italic "Matthew Camidge (1764-1844)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  d2 | e4 e | fis2 \bar "||"
  gis2 | a4 d | cis b | a2 | \bar "||"
  a2 | g4 a | fis2 \bar "||"
  g2 | g4 fis | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  e2 | e4 fis | e4. d8 | cis2 | \bar "||"
  cis2 | d4 e | d2 \bar "||"
  d2 | cis4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  fis2 | a4 a | a2 \bar "||"
  b2 | a4 a | a gis | a2 | \bar "||"
  a2 | b4 a | a2 \bar "||"
  g2 | e4 fis8 g | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | a4 a | d2 \bar "||"
  d2 | cis4 d | e e | a,2 | \bar "||"
  fis'2 | b,4 cis | d2 \bar "||"
  b2 | a4 d | a a | d2 | \bar "||"
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