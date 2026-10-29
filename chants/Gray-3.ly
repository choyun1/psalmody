\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Alan Gray (1855-1935)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 fis | b2 \bar "||"
  a2 | b4 a | b d | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | d4 d | g e | fis2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 a | g2 \bar "||"
  d'2 | b4 d | b a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | b4 d | g2 \bar "||"
  fis2 | g4 fis | e a, | d2 \bar "||"
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
