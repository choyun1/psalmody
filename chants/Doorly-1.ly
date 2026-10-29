\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Carte Doorly (?-1926)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | a4 b | d2 \bar "||"
  b2 | g4 d | e a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  g2 | e4 d | c e8 fis | g2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 g | g2 \bar "||"
  d'2 | b4 g | g c | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 g | b,2 \bar "||"
  d2 | e4 b | c d | g,2 \bar "||"
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
