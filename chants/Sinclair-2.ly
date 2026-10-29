\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Robertson Sinclair (1863-1917)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | b4 a8 g | a2 \bar "||"
  g2 | g4 g | c8 b a4 | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | cis4 cis | c2 \bar "||"
  b2 | e4 d | e8 d c4 | b2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 g | g4 fis \bar "||"
  g2 | a4 b | g fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | e4 e | d2 \bar "||"
  e2 | c4 b | a d | g,2 \bar "||"
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
