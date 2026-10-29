\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Felton (1715-1769)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | c4 d | e2 \bar "||"
  a,2 | d4 g, | a g8 fis | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | g4 f | e2 \bar "||"
  fis2 | d4 g | e d | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | c4 b | c2 \bar "||"
  a2 | b4 b | c b8 a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | e4 d | c2 \bar "||"
  d2 | b4 e | c d | g2 \bar "||"
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
