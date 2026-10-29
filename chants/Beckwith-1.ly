\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Edward James Beckwith (1770/1-1833)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c' {
  d2 | a'4. g8 | g4 fis \bar "||"
  fis2 | e4 d | g fis | e2 \bar "||"
  a2 | d4. c8 | c4 b \bar "||"
  b4. ais8 | d4 e | d cis | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 cis | d2 \bar "||"
  d2 | a4 d | cis d | cis2 \bar "||"
  e2 | g4 fis | g2 \bar "||"
  d4. e8 | fis4 e | fis g | fis2 \bar "||"
}

T_notes = \relative c {
  fis2 | a4 a | a2 \bar "||"
  a2 | g4 a | a a | a2 \bar "||"
  cis2 | d4 d | d2 \bar "||"
  g,2 | a4 b | a a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | cis4 a | d2 \bar "||"
  d2 | g4 fis | e d | a2 \bar "||"
  a'2 | fis4 d | g2 \bar "||"
  g2 | fis4 g | a a, | d2 \bar "||"
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
