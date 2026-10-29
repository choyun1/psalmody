\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Macpherson (1870-1927)"}
  tagline=#f
}

global = {
  \key e \minor
  \time 2/4
}


S_notes = \relative c' {
  e4. fis8 | g4 a | b2 \bar "||"
  b2 | d4 b | a fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2~ | e4 e | <fis dis>2 \bar "||"
  g2 | fis4 e | fis dis | e2 \bar "||"
}

T_notes = \relative c' {
  <b g>4. a8 | b4 a | fis2 \bar "||"
  d'2 | b4 b | c b | g2 \bar "||"
}

B_notes = \relative c {
  e2~ | e4 c | b2 \bar "||"
  g'2 | b4 g | a b | e,2 \bar "||"
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
