\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edwin John Crow (1841-1907)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | e4 g | c2 \bar "||"
  a2 | d4 g, | c b8 a | b2 \bar "||"
  c2 | g4 e | a2 \bar "||"
  b2 | c4 e,8 f | g4 g | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 d | e2 \bar "||"
  fis2 | g4 d | e fis | g2 \bar "||"
  g2 | e4 c | c2 \bar "||"
  d2 | e4 c | d8 e f4 | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 d | c2 \bar "||"
  d2 | d4 d | c d | d2 \bar "||"
  c2 | c4 bes | a2 \bar "||"
  g2 | g4 c | c b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | c'4 b | a2 \bar "||"
  c2 | b4 b | a d, | g2 \bar "||"
  e2 | c4 c | f2 \bar "||"
  f2 | e4 a | g g, | c2 \bar "||"
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
