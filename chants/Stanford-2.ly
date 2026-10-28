\version "2.24.1"

\header{
  composer = \markup{\hspace #-41 \italic "Charles Villiers Stanford (1852-1924)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | d4 b | cis2 \bar "||"
  a2 | b4 g | a fis | e2 | \bar "||"
  g2 | c4 a | b2 \bar "||"
  e,2 | a4 fis | g e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 e | e2 \bar "||"
  d2 | d4 e | cis d | cis2 | \bar "||"
  b2 | e4 d | d2 \bar "||"
  cis2 | cis4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  fis2 | fis4 gis | a2 \bar "||"
  fis2 | g4 b | a a | a2 | \bar "||"
  g2 | g4 fis | g2 \bar "||"
  a2 | a4 b | b g | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | b4 e | a,2 \bar "||"
  d2 | g4 e | fis d | a2 | \bar "||"
  e'2 | c4 d | g,2 \bar "||"
  g'2 | fis4 b, | e a, | d2 | \bar "||"
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