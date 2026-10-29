\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | d,4 c' | b2 \bar "||"
  b2 | a4 b | g e | fis2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | g2 \bar "||"
  g4. fis8 | e4 d | d cis | d2 \bar "||"
}

T_notes = \relative c {
  fis2 | g4 a | d2 \bar "||"
  d2 | cis4 d | b8 a g4 | a2 \bar "||"
}

B_notes = \relative c {
  d2 | e4 fis | g2 \bar "||"
  g2 | g4 fis | e e | d2 \bar "||"
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
