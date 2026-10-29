\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Stephen Elvey (1805-1860)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 fis | b2 \bar "||"
  a2 | cis4 d | g, fis | fis e \bar "||"
  g2 | fis4 e | a2 \bar "||"
  d,2 | e4 fis | g g | fis2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | d2 \bar "||"
  d2 | g4 fis | e d | d cis \bar "||"
  d2 | d4 cis | d2 \bar "||"
  b2 | b8 cis d4 | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 d | g,2 \bar "||"
  a2 | g4 a | a a | a2 \bar "||"
  b2 | d4 a | a2 \bar "||"
  fis2 | g4 a | b a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | b'4 a | g2 \bar "||"
  fis2 | e4 d | cis d | a2 \bar "||"
  b'2 | a4 g | fis2 \bar "||"
  b,2 | g'4 fis | e a, | d2 \bar "||"
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
