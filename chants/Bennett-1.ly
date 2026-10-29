\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | f4 a | g2 \bar "||"
  g2 | c4 b8 a | g4. f8 | f4 e \bar "||"
  g2 | a4 c | b2 \bar "||"
  b2 | e4 d8 c | c4 b | c2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 b | c2 \bar "||"
  e2 | e4 e | c b | c2 \bar "||"
  b4. e8 | e4 dis | e2 \bar "||"
  f2 | e4 fis | g4. f8 | e2 \bar "||"
}

T_notes = \relative c' {
  g2 | f4 f | g2 \bar "||"
  b2 | a4 a | a g | g2 \bar "||"
  g2 | c4 a | b2 \bar "||"
  d2 | b4 c | e d | c2 \bar "||"
}

B_notes = \relative c {
  c2 | d4 d | e2 \bar "||"
  e2 | a,4 c | d g, | c2 \bar "||"
  e2 | fis4 fis | g2 \bar "||"
  g2 | gis4 a | g g | c,2 \bar "||"
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
