\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Walford Davies (1869-1941)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 a | c bes \bar "||"
  a2 | g4 d' | bes a | bes2 \bar "||"
  a2 | b4 cis | e d \bar "||"
  f,2 | a4 g | f e | f2 \bar "||"
}

A_notes = \relative c' {
  c2 | cis4 cis | d2 \bar "||"
  d2 | d4 g | g fis | g2 \bar "||"
  e2 | f4 e | cis d \bar "||"
  a2 | d4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | bes4 g | f2 \bar "||"
  fis2 | g4 bes | d d | d2 \bar "||"
  cis2 | d4 a | a2 \bar "||"
  d2 | c4 bes | a a | a2 \bar "||"
}

B_notes = \relative c {
  f2 | f4 e | d2 \bar "||"
  c2 | bes4 g | d' d | g2 \bar "||"
  a2 | a4 g | f2 \bar "||"
  d2 | f4 g | a a, | d2 \bar "||"
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
