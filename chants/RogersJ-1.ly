\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Leman Rogers (1780-1847)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | d'4. c8 | c4 b \bar "||"
  a4. g8 | fis4 g | g4 fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  e2 | d4. e8 | d4 d | d2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 fis | g2 \bar "||"
  c4. b8 | a4 b8 a | a4 a | b2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 d | g2 \bar "||"
  c,2 | d4 b8 c | d4 d | g,2 \bar "||"
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
