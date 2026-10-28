\version "2.24.1"

\header{
  composer = \markup{\hspace #-38.5 \italic "Henry Edward Dibdin (1813-1866)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative g' {
  a2 | e4 fis | e2 \bar "||"
  e2 | fis4 gis | a b | gis2 | \bar "||"
  a2 | e4 fis | gis2 \bar "||"
  gis2 | a4 b | cis b | a2 \bar "||"
}

A_notes = \relative c' {
  cis2 | cis4 d | b2 \bar "||"
  cis2 | d4 b | cis dis | b2 | \bar "||"
  cis2 | cis4 cis | bis2 \bar "||"
  cis2 | cis4 dis | e d? | cis2 | \bar "||"
}

T_notes = \relative a {
  e2 | a4 a | gis2 \bar "||"
  a2 | a4 e | e fis | e2 | \bar "||"
  a2 | gis4 fis | dis2 \bar "||"
  eis2 | fis4 a | a gis | a2 | \bar "||"
}

B_notes =  \relative c {
  a2 | a4 d | e2 \bar "||"
  a,2 | d4 d | cis b | e2 | \bar "||"
  a,2 | a4 a | gis2 \bar "||"
  cis2 | fis,4 fis' | e <\parenthesize \tweak font-size -3 e e,> | a,2 | \bar "||"
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