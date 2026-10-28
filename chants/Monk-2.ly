\version "2.24.1"

\header{
  composer = \markup{\hspace #-36.5 \italic "Edwin George Monk (1819-1900)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | a4 d | b2 | \bar "||"
  b2 | a4 d | d cis | d2 | \bar "||"
  c!2 | b4 e, | a2 | \bar "||"
  a2 | b4 d | c a | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 | \bar "||"
  g2 | g4 fis | e e | fis2 | \bar "||"
  e2 | e4 e | e2 | \bar "||"
  d2 | d4 g | g fis | g2 | \bar "||"
}

T_notes = \relative a {
  b2 | a4 a | g2 | \bar "||"
  b2 | cis4 d | b a | a2 | \bar "||"
  a2 | b4 b | c2 | \bar "||"
  c2 | b4 g | e' d | b2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 fis | g2 | \bar "||"
  e2 | a4 b | g a | d,2 | \bar "||"
  a'2 | a4 gis | a2 | \bar "||"
  fis2 | g4 b, | c d | g2 | \bar "||"
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