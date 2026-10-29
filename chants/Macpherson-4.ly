\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Macpherson (1870-1927)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | b4 a | g fis \bar "||"
  g2 | g4 fis | e a | fis2 \bar "||"
  b2 | b4 c | b a \bar "||"
  b2 | d4 e | c a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 e | d2 \bar "||"
  b4. c8 | d4 d | c e | d2 \bar "||"
  d2 | e4 e | g fis \bar "||"
  g2 | a4 g | e fis | g2 \bar "||"
}

T_notes = \relative c' {
  g2 | g4 c | b a \bar "||"
  b2 | d4 b | g c | a2 \bar "||"
  b2 | g4 a | d2 \bar "||"
  b2 | c4 b | a c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | c,4 c | d2 \bar "||"
  g2 | b,4 b | c a | d2 \bar "||"
  g2 | e4 c | d2 \bar "||"
  g2 | fis4 g | a d, | g2 \bar "||"
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
