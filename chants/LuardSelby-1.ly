\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Bertram Luard-Selby (1853-1918)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | f4 e | a2 \bar "||"
  a2 | g4 b | c d | c b \bar "||"
  b2 | c4 d | g,2 \bar "||"
  bes2 | a4 g8 f | e4 d | e2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | c2 \bar "||"
  d2 | e4 f | e f | e d \bar "||"
  f2 | e4 f | e2 \bar "||"
  e2 | f4 e8 d | c4 b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | a4 bes | a2 \bar "||"
  b2 | c4 g | g a | g g \bar "||"
  d'2 | c4 g | g2 \bar "||"
  g2 | f4 a | g g | g2 \bar "||"
}

B_notes = \relative c {
  c2 | a'4 g | f2 \bar "||"
  f2 | e4 d | c f | g g \bar "||"
  g,2 | a4 b | c2 \bar "||"
  cis2 | d4 f | g g, | c2 \bar "||"
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
