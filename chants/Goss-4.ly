\version "2.24.1"

\header{
  composer = \markup{\hspace #-47.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative g' {
  gis2 | fis4 fis | b2 \bar "||"
  gis2 | a4 fis | e dis | e2 | \bar "||"
}

A_notes = \relative c' {
  e2 | e4 dis | e2 \bar "||"
  e2 | e4 cis | b b | b2 | \bar "||"
}

T_notes = \relative a {
  b2 | cis4 b | b2 \bar "||"
  b2 | a4 a | gis fis | gis2 | \bar "||"
}

B_notes =  \relative c {
  e2 | a,4 a | gis2 \bar "||"
  e'2 | cis4 a | b b | e2 | \bar "||"
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