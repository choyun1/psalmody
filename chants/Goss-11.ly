\version "2.24.1"

\header{
  composer = \markup{\hspace #-49.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | b4 a | c2 \bar "||"
  b2 | a4 g | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | c2 \bar "||"
  d2 | e4 d | c c | b2 | \bar "||"
}

T_notes = \relative a {
  b2 | g4 a | g2 \bar "||"
  fis2 | e4 g | a a | d,2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 fis | e2 \bar "||"
  d2 | c4 b | a a | g2 | \bar "||"
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