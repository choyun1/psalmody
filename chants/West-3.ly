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
  fis2 | e4 g | fis e \bar "||"
  a2 | b4 d | cis b | a2 \bar "||"
  b2 | a4 c | b a \bar "||"
  g2 | a4 fis | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 d | cis2 \bar "||"
  d2 | fis4 fis | e gis | a2 \bar "||"
  e2 | dis4 e | fis2 \bar "||"
  e2 | e4 d | d cis | d2 \bar "||"
}

T_notes = \relative c' {
  a2 | b4 b | a2 \bar "||"
  a2 | fis4 a | a d | cis2 \bar "||"
  b2 | c4 a | fis2 \bar "||"
  b2 | a4 a | b g | fis2 \bar "||"
}

B_notes = \relative c {
  d2 | g4 e | a2 \bar "||"
  fis2 | d4 b | e e | a,2 \bar "||"
  g'2 | fis4 e | dis2 \bar "||"
  e2 | cis4 d | g, a | d2 \bar "||"
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
