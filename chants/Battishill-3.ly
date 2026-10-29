\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Jonathan Battishill (1738-1801)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | fis4 g | c2 \bar "||"
  b2 | e4 d | c c | b2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | e8 fis g4 | g fis | g2 \bar "||"
}

T_notes = \relative c' {
  d2 | c4 b | a2 \bar "||"
  g2 | g8 a b4 | e d | d2 \bar "||"
}

B_notes = \relative c' {
  b2 | a4 g | fis2 \bar "||"
  g2 | c,4 b | a d | g,2 \bar "||"
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
