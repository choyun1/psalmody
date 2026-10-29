\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Frederick William Huntley (1859-1913)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 a | a2 \bar "||"
  a2 | b4 cis | d fis, | e2 \bar "||"
  fis2 | fis4 fis | fis2 \bar "||"
  g2 | a4 a | b cis | d2 \bar "||"
}

A_notes = \relative c' {
  fis2 | fis4 e | g2 \bar "||"
  fis2 | e4 g | fis d | cis2 \bar "||"
  cis2 | b4 cis | d2 \bar "||"
  d2 | g4 fis8 e | d4 g | fis2 \bar "||"
}

T_notes = \relative c' {
  d2 | cis4 cis | d2 \bar "||"
  cis2 | b4 a | a b | cis2 \bar "||"
  ais2 | gis4 ais | b2 \bar "||"
  b2 | cis4 cis | d a | a2 \bar "||"
}

B_notes = \relative c {
  d2 | fis4 a | b2 \bar "||"
  a2 | g4 fis8 e | fis4 gis | a2 \bar "||"
  fis2 | fis4 e | d2 \bar "||"
  b2 | a4 a' | fis e | d2 \bar "||"
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
