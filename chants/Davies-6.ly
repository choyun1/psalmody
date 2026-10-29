\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Walford Davies (1869-1941)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | b4 a | d,2 \bar "||"
  a'2 | d4 cis | b4 a8 g | fis4 e \bar "||"
  a2 | c4 b | e,2 \bar "||"
  fis2 | g4 g | g4. a8 | g4 fis \bar "||"
}

A_notes = \relative c' {
  d2 | d4 e | d2 \bar "||"
  cis2 | d4 d | d4 fis8 e | d4 cis \bar "||"
  d2 | dis4 d | e2 \bar "||"
  dis2 | e4 e | e4 cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 cis | a2 \bar "||"
  g2 | fis4 g8 a | b4 b | a2 \bar "||"
  a2 | a4 g | b2 \bar "||"
  a2 | b4 b | a4 a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | g4 g | fis2 \bar "||"
  e2 | d4 e8 fis | g4 e | a2 \bar "||"
  fis2 | fis4 b, | g'2 \bar "||"
  fis2 | e4 d | c4 a | d2 \bar "||"
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
