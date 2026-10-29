\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Foster (1752-1822)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 e | d2 \bar "||"
  a'2 | fis4 b | a a | a2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 cis | d2 \bar "||"
  e2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 g | fis2 \bar "||"
  a2 | a4 g | e e | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | g,4 a | b2 \bar "||"
  cis2 | d4 g, | a a | d2 \bar "||"
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
