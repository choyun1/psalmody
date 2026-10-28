\version "2.24.1"

\header{
  composer = \markup{\hspace #-31 \italic "Martin Luther (1483-1546)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | c4 c | g2 | \bar "||"
  b2 | c4 b | a a | g2 | \bar "||"
  c2 | b4 a | g2 | \bar "||"
  a2 | f4 e | d d | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | c4 e | d2 | \bar "||"
  e2 | e4 e | e fis | g2 | \bar "||"
  e2 | e4 c | e2 | \bar "||"
  e2 | d4 c | c b | c2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 g | b2 | \bar "||"
  g2 | a4 gis | a c | b2 | \bar "||"
  a2 | g4 a | c2 | \bar "||"
  a2 | a4 g | a g | e2 | \bar "||"
}

B_notes =  \relative c {
  c2 | e4 c | g'2 | \bar "||"
  e2 | a,4 b | c d | g,2 | \bar "||"
  a2 | e'4 f | c2 | \bar "||"
  cis2 | d4 e | f g | c,2 | \bar "||"
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