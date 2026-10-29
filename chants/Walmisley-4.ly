\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Attwood Walmisley (1814-1856)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | d4 e | a,2 \bar "||"
  c2 | b4 g | g fis | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | g4 g | fis2 \bar "||"
  e4. fis8 | g4 b,8 cis | d4. c8 | b2 \bar "||"
}

T_notes = \relative c' {
  d2 | d4 c8 b | a2 \bar "||"
  a2 | g4 g | a a | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | b,4 c | d2 \bar "||"
  a2 | b4 e | d d | g,2 \bar "||"
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
