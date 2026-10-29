\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Battison Haynes (1859-1900)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | a4 d, | g2 \bar "||"
  g2 | a4 g | f c' | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 c | bes2 \bar "||"
  b2 | c4 e | f f | f2 \bar "||"
}

T_notes = \relative c {
  f2 | fis4 a | g2 \bar "||"
  f2 | e4 bes' | a es' | d2 \bar "||"
}

B_notes = \relative c {
  bes2 | d4 d | es2 \bar "||"
  d2 | c4 c | f f | bes2 \bar "||"
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
