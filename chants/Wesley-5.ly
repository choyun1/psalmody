\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  fis2 | g4 fis | fis e \bar "||"
  d2 | b'4 a | g fis | e2 \bar "||"
  a2 | cis4 d8 e | d2 \bar "||"
  b2 | a4 d,8 g | fis4 e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | cis2 \bar "||"
  d2 | d4 d | e d | cis2 \bar "||"
  e2 | e4 d8 cis | d2 \bar "||"
  d2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | d4 a | a g \bar "||"
  a2 | g4 a | b b | cis2 \bar "||"
  cis2 | a4 a | a2 \bar "||"
  d2 | fis,4 g | a4. g8 | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | b'4 a | a g \bar "||"
  fis2 | g4 fis | g gis | a2 \bar "||"
  a2 | g4 g | fis2 \bar "||"
  g2 | fis4 b, | a a | d2 \bar "||"
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
