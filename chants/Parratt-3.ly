\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Parratt (1841-1924)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 g | e'2 \bar "||"
  c2 | a4 g | g f | e2 \bar "||"
  e2 | e4 e | c'2 \bar "||"
  a2 | f4 e | e d | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 f | e2 \bar "||"
  g2 | c,4 c | c b | c2 \bar "||"
  b2 | e4 d | c2 \bar "||"
  c2 | d4 c | b b | c2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 b | c2 \bar "||"
  c2 | c4 g | a g | g2 \bar "||"
  gis2 | a4 gis | a2 \bar "||"
  a2 | g4 g | g f | e2 \bar "||"
}

B_notes = \relative c {
  c2 | e4 d | c2 \bar "||"
  e2 | f4 e | d g | c,2 \bar "||"
  e2 | c4 b | a2 \bar "||"
  f'2 | b,4 c | g g | c2 \bar "||"
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
