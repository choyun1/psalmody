\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Macpherson (1870-1927)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 a | c4 b \bar "||"
  c2 | d4 e | a, b | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | f4 g | f2 \bar "||"
  g2 | f4 e | f g8 f | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 cis | d2 \bar "||"
  g,2 | a4 b | c d | c2 \bar "||"
}

B_notes = \relative c {
  c2 | f4 a | d,2 \bar "||"
  e2 | f4 g | a g | c,2 \bar "||"
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
