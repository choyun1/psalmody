\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Walter Battison Haynes (1859-1900)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | d,4 e | f2 \bar "||"
  fis2 | g4 a | bes g | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 bes | a2 \bar "||"
  d2 | d4 c | bes bes | a2 \bar "||"
}

T_notes = \relative c {
  f2 | f4 g | f2 \bar "||"
  a2 | g4 fis | g e | f2 \bar "||"
}

B_notes = \relative c {
  f2 | bes,4 g | d'2 \bar "||"
  c2 | bes4 a | g c | f2 \bar "||"
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
