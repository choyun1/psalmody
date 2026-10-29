\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George John Bennett (1863-1930)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | d4 a' | a2 \bar "||"
  g2 | g4 fis | b a8 gis | fis2 \bar "||"
  a2 | cis4 b | a2 \bar "||"
  fis2 | a4 g | g fis8 e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 e | d2 \bar "||"
  d2 | cis4 d | fis eis | fis2 \bar "||"
  d2 | d4 d | d2 \bar "||"
  d2 | fis4 e | cis cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | fis4 a | b2 \bar "||"
  b2 | a4 a | d cis8 b | a2 \bar "||"
  a2 | g4 g | a2 \bar "||"
  a2 | b4 b | b a8 g | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | d4 cis | b2 \bar "||"
  e2 | e4 d | b cis | fis2 \bar "||"
  fis2 | g4 g | fis2 \bar "||"
  d2 | dis4 e | a, a | d2 \bar "||"
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
