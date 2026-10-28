\version "2.24.1"

\header{
  composer = \markup{\hspace #-63.5 \italic "Robert Prescott Stewart (1825-1894)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | e4 f | g2 \bar "||"
  g2 | a4 c | d d | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | e4 c | d2 \bar "||"
  c2 | c4 g' | g f | e2 | \bar "||"
}

T_notes = \relative a {
  c2 | g4 a | b2 \bar "||"
  c2 | c4 c | c b | c2 | \bar "||"
}

B_notes =  \relative c {
  c2 | c4 a | g2 \bar "||"
  e'2 | f4 e | g g | c,2 | \bar "||"
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