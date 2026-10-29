\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 c | f,2 \bar "||"
  g2 | e4 e | a c | c b \bar "||"
  a2 | c4 e | a,2 \bar "||"
  g2 | c4 f | e d | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | d4 c | d2 \bar "||"
  d2 | e4 d | c c8 d | e2 \bar "||"
  e2 | a4 e | d2 \bar "||"
  d2 | g4 a | g f | e2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 a | a2 \bar "||"
  g2 | g4 gis | a a | a gis \bar "||"
  c2 | e4 c | c2 \bar "||"
  b2 | c4 c | c b | c2 \bar "||"
}

B_notes = \relative c {
  c2 | b4 a | d2 \bar "||"
  b2 | c4 b | a f' | e4 e \bar "||"
  a2 | g4 g | fis2 \bar "||"
  f2 | e4 d | g g, | c2 \bar "||"
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
