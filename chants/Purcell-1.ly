\version "2.24.1"

\header{
  composer = \markup{\hspace #-52 \italic "Henry Purcell (1659-1695)"}
  tagline=#f
}

global = {
  \key g \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | g4 a | bes2 \bar "||"
  bes2 | a4 c | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 c | bes2 \bar "||"
  d2 | d4 c | d d | bes2 | \bar "||"
}

T_notes = \relative a {
  fis2 | g4 fis | g2 \bar "||"
  g2 | a4 g | bes a | g2 | \bar "||"
}

B_notes =  \relative c {
  d2 | bes4 a | g2 \bar "||"
  g'2 | f4 ees | d d | g,2 | \bar "||"
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