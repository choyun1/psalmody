\version "2.24.1"

\header{
  composer = \markup{\hspace #-27 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | c4 a | gis2 \bar "||"
  gis2 | a4 b | c d | e2 | \bar "||"
  c2 | e4 c | b2 \bar "||"
  b2 | a4 b | a gis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  e2 | e4 e | e g | g2 | \bar "||"
  g2 | g4 g | g2 \bar "||"
  f2 | e4 f | e d | c2 | \bar "||"
}

T_notes = \relative a {
  c2 | a4 a | b2 \bar "||"
  b2 | c4 b | a b | c2 | \bar "||"
  e2 | c4 c | d2 \bar "||"
  d2 | c4 d | c b | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | a4 c | e2 \bar "||"
  e2 | a4 gis | a g? | c,2 | \bar "||"
  c2 | c4 e | g2 \bar "||"
  gis2 | a4 d, | e e | a,2 | \bar "||"
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