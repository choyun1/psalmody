\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Savage (1720-1789)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 fis | g2 \bar "||"
  g2 | g4 c | c b | c2 \bar "||"
}

A_notes = \relative c' {
  e2 | d4 c | d2 \bar "||"
  d2 | d4 e | f f | e2 \bar "||"
}

T_notes = \relative c' {
  c2 | d4 a | b2 \bar "||"
  b2 | b4 c | d d | g,2 \bar "||"
}

B_notes = \relative c' {
  c2 | b4 a | g2 \bar "||"
  g2 | f4 e | d d | c2 \bar "||"
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
