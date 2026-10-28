\version "2.24.1"

\header{
  composer = \markup{\hspace #-52.5 \italic "Henry Purcell (1659-1695)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | g4 a | b2 \bar "||"
  b2 | a4 c | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 c | b2 \bar "||"
  d2 | e4 e | d d | b2 | \bar "||"
}

T_notes = \relative a {
  fis2 | g4 fis | g2 \bar "||"
  g2 | g4 a | b a | g2 | \bar "||"
}

B_notes =  \relative c {
  d2 | b4 a | g2 \bar "||"
  g'2 | c,4 c | d d | g,2 | \bar "||"
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