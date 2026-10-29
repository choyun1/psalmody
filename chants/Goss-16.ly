\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis4. g8 | a4 d, | g2 \bar "||"
  fis2 | b4 a | a gis | a2 \bar "||"
  a4. b8 | cis4 a | d2 \bar "||"
  fis,2 | g4 fis | e e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 b | cis2 \bar "||"
  d2 | fis4 e | e e | e2 \bar "||"
  e2 | e4 e | d2 \bar "||"
  d2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | a4 b | g2 \bar "||"
  a2 | d4 cis | b b | cis2 \bar "||"
  cis4. d8 | e4 cis | a2 \bar "||"
  a2 | g4 a8 b | e,4 fis8 g | fis2 \bar "||"
}

B_notes = \relative c {
  d4. e8 | fis4 g | e2 \bar "||"
  d2 | b4 cis8 d | e4 e | a,2 \bar "||"
  a'2 | g4 a | fis2 \bar "||"
  c2 | b4 a8 g | a4 a | d2 \bar "||"
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
