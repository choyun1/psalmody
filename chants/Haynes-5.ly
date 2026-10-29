\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Battison Haynes (1859-1900)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | a4 d | c2 \bar "||"
  b2 | a4 e | fis a | g2 \bar "||"
}

A_notes = \relative c'' {
  g2 | a4 g | g2 \bar "||"
  e2 | e4 e | d c | b2 \bar "||"
}

T_notes = \relative c' {
  d2 | d4 b | c2 \bar "||"
  gis2 | a4 c | b fis | g2 \bar "||"
}

B_notes = \relative c' {
  g2 | fis4 f | e2 \bar "||"
  e4. d8 | c4 a | d d | g,2 \bar "||"
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
