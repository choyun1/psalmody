\version "2.24.1"

\header{
  composer = \markup{\hspace #-57 \italic "Richard Goodson (1655-1718)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | c4 b | a2 \bar "||"
  a2 | d4 c | c b | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | g4 g | f2 \bar "||"
  f2 | f4 e | d d | e2 | \bar "||"
}

T_notes = \relative a {
  c2 | c4 c | c2 \bar "||"
  d2 | g,4 g | g g | g2 | \bar "||"
}

B_notes =  \relative c {
  c2 | e4 e | f2 \bar "||"
  d2 | b4 c | g' g | c,2 | \bar "||"
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