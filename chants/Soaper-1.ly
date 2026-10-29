\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Soaper"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | e4 fis | g2 \bar "||"
  b2 | a4 b | a gis | a2 \bar "||"
  a2 | a4 gis | fis2 \bar "||"
  a2 | d4 e, | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | cis4 d | d2 \bar "||"
  g2 | fis4 fis | e e | e2 \bar "||"
  fis2 | fis4 eis | fis2 \bar "||"
  fis2 | fis4 e | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | a4 a | b2 \bar "||"
  cis2 | d4 d | cis b | cis2 \bar "||"
  cis2 | cis4 b | a2 \bar "||"
  d2 | d4 b | a g | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | a4 d | g,2 \bar "||"
  e'2 | fis4 d | e e | a,2 \bar "||"
  fis'2 | cis4 cis | fis2 \bar "||"
  d2 | b4 g | a a | d2 \bar "||"
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
