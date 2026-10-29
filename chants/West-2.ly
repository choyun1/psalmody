\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Ebenezer West (1863-1929)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | a4 g | fis2 \bar "||"
  fis2 | d'4 cis | b b | a2 \bar "||"
}

A_notes = \relative c' {
  d2 | fis4 e | cis2 \bar "||"
  d2 | fis4 fis | fis e | fis2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 b | ais2 \bar "||"
  b2 | b4 cis | d cis | d2 \bar "||"
}

B_notes = \relative c {
  d2 | d4 e | fis2 \bar "||"
  b,2 | b'4 a | g g | d2 \bar "||"
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
