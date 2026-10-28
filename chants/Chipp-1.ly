\version "2.24.1"

\header{
  composer = \markup{\hspace #-34 \italic "Edmund T. Chipp (1823-1886)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative g' {
  gis2 | gis4 fis | b2 \bar "||"
  e,2 | a4 gis | fis e | dis2 | \bar "||"
  b'2 | cis4 b | e2 \bar "||"
  fis,2 | gis4 a | fis fis | e2 | \bar "||"
}

A_notes = \relative c' {
  e2 | dis4 dis | e2 \bar "||"
  e2 | fis4 e | cis cis | dis2 | \bar "||"
  fis2 | fis4 fis | e2 \bar "||"
  e2 | e4 e | e dis | e2 | \bar "||"
}

T_notes = \relative a {
  b2 | b4 b | b2 \bar "||"
  gis2 | fis4 gis | a ais | b2 | \bar "||"
  dis2 | e4 dis | b2 \bar "||"
  cis2 | e,4 e | fis a | gis2 | \bar "||"
}

B_notes =  \relative c {
  e2 | a4 a | gis2 \bar "||"
  cis,2 | dis4 e | fis fis | b,2 | \bar "||"
  b'2 | a4 a | gis2 \bar "||"
  a,2 | b4 cis | b b | e2 | \bar "||"
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