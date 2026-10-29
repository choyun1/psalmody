\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward John Hopkins (1818-1901)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 g | f2 \bar "||"
  g2 | e4 g | a c | c b \bar "||"
  c2 | b4 gis | a2 \bar "||"
  a2 | g4 c | c b | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | d2 \bar "||"
  d2 | c4 d | c d | d2 \bar "||"
  c2 | d4 d | c2 \bar "||"
  f2 | f4 e | d e8 f | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | a4 a | a2 \bar "||"
  g2 | g4 g | g fis | g2 \bar "||"
  g2 | gis4 b | a2 \bar "||"
  a2 | d4 g, | g g | g2 \bar "||"
}

B_notes = \relative c {
  c2 | c4 c | d2 \bar "||"
  b2 | c4 b | a a | g2 \bar "||"
  e'2 | e4 e | f2 \bar "||"
  d2 | b4 c | g g | c2 \bar "||"
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
