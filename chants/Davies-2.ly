\version "2.24.1"

\header{
  composer = \markup{\hspace #-38.5 \italic "Henry Walford Davies (1869-1941)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | g4 c | c b \bar "||"
  c2 | a4 g | f g | e2 | \bar "||"
  g2 | g4 e' | e d \bar "||"
  b2 | c4 a | g g | g2 | \bar "||"
}

A_notes = \relative c' {
  e2 | f4 g | g2 \bar "||"
  g2 | f4 d | c d | c2 | \bar "||"
  e2 | e4 g | fis2 \bar "||"
  g2 | g4 f? | d d | e2 | \bar "||"
}

T_notes = \relative a {
  c2 | b4 c | d2 \bar "||"
  c2 | c4 b | a b | g2 | \bar "||"
  c2 | c4 d | c2 \bar "||"
  d2 | c4 c | c b | c2 | \bar "||"
}

B_notes =  \relative c {
  c2 | d4 e | f2 \bar "||"
  e2 | f4 g | a g | c,2 | \bar "||"
  c2 | c'4 b | a2 \bar "||"
  g2 | e4 f | g g | c,2 | \bar "||"
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