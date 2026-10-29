\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Battison Haynes (1859-1900)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  c2 | g4 a | e2 \bar "||"
  f2 | g4 c | a b | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | g4 c, | c2 \bar "||"
  c2 | d4 g | g f | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | b4 a | g2 \bar "||"
  a2 | b4 c | e d | c2 \bar "||"
}

B_notes = \relative c {
  c2 | e4 f | c2 \bar "||"
  a'2 | g4 e | f g | c,2 \bar "||"
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
