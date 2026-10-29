\version "2.24.1"

\header{
  composer = \markup{\hspace #-53 \italic "Edward Elgar (1857-1934)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  d'2 | e4 d | b2 \bar "||"
  a2 | d4 b | a g | b2 | \bar "||"
}

A_notes = \relative c' {
  g'2 | g4 a | g2 \bar "||"
  e2 | d4 fis | fis e | d2 | \bar "||"
}

T_notes = \relative a {
  b2 | b4 d | d2 \bar "||"
  c2 | a4 b | c b | b2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | e4 fis | g2 \bar "||"
  g2 | fis4 d | e e | g2 | \bar "||"
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