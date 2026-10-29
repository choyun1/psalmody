\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Alford (1810-1871)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | b4 d | g,2 \bar "||"
  b2 | e,4 g | fis g | a2 \bar "||"
  c2 | c4 e | a,2 \bar "||"
  c2 | b4 g | a g8 fis | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | d4 d | e2 \bar "||"
  fis2 | e4 d | d d | d2 \bar "||"
  e2 | e4 e | d2 \bar "||"
  fis2 | g4 d | e d | d2 \bar "||"
}

T_notes = \relative c' {
  d2 | g,4 a | b2 \bar "||"
  b2 | c4 g | c b8 g | fis2 \bar "||"
  e2 | c'4 b | a2 \bar "||"
  a2 | b4 d | c b8 a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | g4 fis | e2 \bar "||"
  d2 | c4 b | a g | d'2 \bar "||"
  a2 | a'4 g | fis2 \bar "||"
  d2 | g4 b, | c d | g,2 \bar "||"
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
