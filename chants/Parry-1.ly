\version "2.24.1"

\header{
  composer = \markup{\hspace #-47.5 \italic "Charles Hubert Hastings Parry (1848-1918)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative g' {
  gis2 | a4 b | e,2 \bar "||"
  fis2 | a4 gis | fis e | gis fis | \bar "||"
  b2 | cis4 dis | gis,2 \bar "||"
  a2 | cis4 b | a fis | e2 | \bar "||"
}

A_notes = \relative c' {
  e2 | e4 dis | e2 \bar "||"
  cis2 | fis4 e | cis e | e dis | \bar "||"
  fis2 | fis4 fis | eis2 \bar "||"
  fis2 | a4 gis | fis dis | e2 | \bar "||"
}

T_notes = \relative a {
  b2 | a4 a | gis2 \bar "||"
  a2 | b4 b | a gis | b2 | \bar "||"
  dis2 | cis4 bis | cis2 \bar "||"
  cis2 | dis4 e | cis b8 a | gis2 | \bar "||"
}

B_notes =  \relative c {
  e2 | cis4 b | cis2 \bar "||"
  fis4. e8 | dis4 e | a, cis | b2 | \bar "||"
  b'2 | a4 gis | cis2 \bar "||"
  fis,2 | fis,4 gis | a b | e2 | \bar "||"
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