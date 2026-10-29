\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Walford Davies (1869-1941)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 b | d c \bar "||"
  d,2 | d4 b' | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | b c \bar "||"
  c2 | b4 d | d d | d2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 fis | g2 \bar "||"
  a2 | b4 g | b a | b2 \bar "||"
}

B_notes = \relative c {
  b2 | c4 d | e2 \bar "||"
  fis2 | g4 b,8 c | d4 d | g,2 \bar "||"
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
