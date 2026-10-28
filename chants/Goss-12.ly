\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  e2 | a4 a | gis2 \bar "||"
  a2 | b4 d | cis b | cis2 | \bar "||"
  a2 | g4 g | fis2 \bar "||"
  gis?2 | a4 a | cis b | a2 \bar "||"
}

A_notes = \relative c' {
  cis2 | e4 dis | e2 \bar "||"
  e2 | fis4 fis | e e | e2 | \bar "||"
  cis2 | b4 a | a2 \bar "||"
  d2 | cis4 dis | e d | cis2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 a | b2 \bar "||"
  a2 | a4 a | a gis | a2 | \bar "||"
  a2 | d,4 e | fis2 \bar "||"
  b2 | a4 a | a gis | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | cis4 fis | e2 \bar "||"
  cis2 | d4 b | e e | a,2 | \bar "||"
  fis'2 | b,4 cis | d2 \bar "||"
  b2 | fis'4 fis | e e | a,2 | \bar "||"
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