\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward Cuthbert Bairstow (1874-1946)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 c | b2 \bar "||"
  b2 | c4 b | g a | g2 \bar "||"
  a2 | a4 d | c2 \bar "||"
  c2 | c4 g | a g | g2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 fis | g2 \bar "||"
  e2 | a4 fis | e fis | g2 \bar "||"
  e2 | a4 gis | a2 \bar "||"
  a2 | g4 g | f d | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | c4 d | e2 \bar "||"
  g,2 | e'4 d | b c | b2 \bar "||"
  cis2 | d4 f | e2 \bar "||"
  d2 | e4 d8 c | c4 b | c2 \bar "||"
}

B_notes = \relative c' {
  c2 | b4 a | e2 \bar "||"
  e2 | a,4 b | e d | g2 \bar "||"
  g2 | f4 d | a'2 \bar "||"
  fis2 | g4 f8 e | d4 g | c,2 \bar "||"
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
