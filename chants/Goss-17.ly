\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key a \minor
  \time 2/4
}


S_notes = \relative c' {
  e2 | g4 fis | g2 \bar "||"
  g2 | a4 c | c b | c2 \bar "||"
  b2 | c4 d | gis,2 \bar "||"
  a2 | c4 b | e, gis | a2 \bar "||"
}

A_notes = \relative c' {
  c2 | d4 c | b2 \bar "||"
  c2 | f4 e | d d | e2 \bar "||"
  e2 | e4 d | e2 \bar "||"
  c2 | e4 d | c b | c2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 a | b2 \bar "||"
  g2 | f4 g | g g | g2 \bar "||"
  gis2 | a4 a | b2 \bar "||"
  a2 | g4 f | e e | e2 \bar "||"
}

B_notes = \relative c {
  c2 | b4 a | g2 \bar "||"
  e'2 | d4 c | g' g, | c2 \bar "||"
  e2 | a4 f | e2 \bar "||"
  f2 | c4 d | e e | a,2 \bar "||"
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
