\version "2.24.1"

\header{
  composer = \markup{\hspace #-28 \italic "John Foster (1752-1822)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative g' {
  e2 | dis4 e | fis2 \bar "||"
  a2 | gis4 b | b ais | b2 | \bar "||"
  b2 | fis4 fis | e2 \bar "||"
  cis'2 | b4 a | fis fis | e2 | \bar "||"
}

A_notes = \relative c' {
  b2 | a4 b | cis2 \bar "||"
  fis2 | e4 e | fis fis | fis2 | \bar "||"
  fis2 | dis4 cis8 dis | e2 \bar "||"
  e2 | e4 e | e dis | e2 | \bar "||"
}

T_notes = \relative a {
  gis2 | fis4 gis | a2 \bar "||"
  b2 | b4 b | cis cis | dis2 | \bar "||"
  dis2 | b4 b | b2 \bar "||"
  a2 | b4 cis | b b | gis2 | \bar "||"
}

B_notes =  \relative c {
  e2 | e4 e | e2 \bar "||"
  dis2 | e4 gis | fis fis | b,2 | \bar "||"
  b'2 | a4 a | gis2 \bar "||"
  a2 | gis4 a | b b, | e2 | \bar "||"
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