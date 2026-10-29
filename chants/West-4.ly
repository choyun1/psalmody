\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Ebenezer West (1863-1929)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | d8 e f4 | g2 \bar "||"
  f2 | e4 g | c8 b a4 | g2 \bar "||"
  g2 | fis8 g a4 | b2 \bar "||"
  a2 | g4 c | c b | c2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | d2 \bar "||"
  d2 | c4 d | e fis | g2 \bar "||"
  e2 | e4 e | e dis \bar "||"
  fis2 | e4 e | a8 g f4 | e2 \bar "||"
}

T_notes = \relative c' {
  g2 | a4 c | c b \bar "||"
  g2 | g4 d' | c c | b2 \bar "||"
  b2 | c4 c | a2 \bar "||"
  b2 | b4 a8 c | f8 e d4 | c2 \bar "||"
}

B_notes = \relative c {
  c2 | f4 a | g2 \bar "||"
  b,2 | c4 b | a d | g,2 \bar "||"
  e'2 | a4 g | fis2 \bar "||"
  dis2 | e4 a | d, g | c,2 \bar "||"
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
