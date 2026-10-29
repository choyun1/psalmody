\version "2.24.1"

\header{
  composer = \markup{\hspace #-27.5 \italic "Percy Buck (1871-1947)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | c4 a | d2 \bar "||"
  b2 | a4 d, | g fis8 e | fis2 | \bar "||"
  a2 | d4 b | e2 \bar "||"
  c2 | b4 g | c b8 a | g2 \bar "||"
}

A_notes = \relative c' {
  g'2 | g4 e | d2 \bar "||"
  d2 | cis4 d | d cis | d2 | \bar "||"
  fis2 | g4 f | e2 \bar "||"
  e2 | dis4 e | e fis | g2 | \bar "||"
}

T_notes = \relative a {
  b2 | e4 c | a2 \bar "||"
  g2 | a4 a | b a | a2 | \bar "||"
  d2 | d4 d | b2 \bar "||"
  c2 | a4 b | a c | b2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 g | fis2 \bar "||"
  g2 | g4 fis | e a, | d2 | \bar "||"
  c'2 | b4 a | gis2 \bar "||"
  a2 | fis4 e | c d | g2 | \bar "||"
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