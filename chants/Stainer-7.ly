\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 a | b2 \bar "||"
  a2 | g4 fis | g e | d2 \bar "||"
}

A_notes = \relative c' {
  a2 | a4 d | d4 e \bar "||"
  fis2 | cis4 d | e cis | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | cis4 c | b cis \bar "||"
  d2 | g,4 a | b g | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | e4 fis | g2 \bar "||"
  fis2 | e4 d | g, a | d2 \bar "||"
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
