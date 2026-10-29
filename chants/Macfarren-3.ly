\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George A. Macfarren (1813-1887)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 b | c2 \bar "||"
  e,2 | fis4 g | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | c2 \bar "||"
  c2 | c4 d | e d8 c | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 g | g2 \bar "||"
  g2 | c4 b | a a | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 g | e2 \bar "||"
  c2 | a4 b | c d | g,2 \bar "||"
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
