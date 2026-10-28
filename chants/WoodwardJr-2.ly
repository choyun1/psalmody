\version "2.24.1"

\header{
  composer = \markup{\hspace #-39.5 \italic "Richard Woodward, Jr. (1743-1777)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | a4 a | d2 \bar "||"
  fis,2 | b4 a | g fis | e2 | \bar "||"
  a4.g8 | fis4 d' | cis2 \bar "||"
  d2 | d,4 e | fis e | d2 | \bar "||"
}

A_notes = \relative c' {
  fis2 | fis4 e | fis2 \bar "||"
  d2 | d4 d | cis d | cis2 | \bar "||"
  e2 | d4 e | e2 \bar "||"
  d2 | d4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  d2 | d4 e | d2 \bar "||"
  d2 | d4 a | a a | a2 | \bar "||"
  cis2 | d4 b | a2 \bar "||"
  a2 | b4 b | a4. g8 | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | d'4 cis | b2 \bar "||"
  b4. a8 | g4 fis | e d | a2 | \bar "||"
  a'2 | b4 gis | a2 \bar "||"
  fis2 | b4 g | a a, | d2 | \bar "||"
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