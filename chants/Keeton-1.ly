\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Haydn Keeton (1847-1921)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | b4 a | g2 \bar "||"
  fis2 | fis4 b | d cis | b2 \bar "||"
  b2 | a4 d, | g2 \bar "||"
  fis2 | fis4 g | a a | d,2 \bar "||"
}

A_notes = \relative c' {
  d2 | fis4 fis | d2 \bar "||"
  cis2 | d4 e | fis4. e8 | d2 \bar "||"
  d2 | e4 d | d4 cis \bar "||"
  d2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | d4 c | b2 \bar "||"
  ais2 | b4 b | b ais | b2 \bar "||"
  b2 | cis4 a | ais2 \bar "||"
  b2 | b4 g | fis e | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | d4 d | d2 \bar "||"
  e2 | d4 g | fis fis | b,2 \bar "||"
  g'2 | g4 fis | e2 \bar "||"
  d2 | b4 b | a a | d2 \bar "||"
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
