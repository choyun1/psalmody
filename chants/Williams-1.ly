\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Lee Williams (1853-1935)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c' {
  e2 | gis4 a | b2 \bar "||"
  b2 | cis4 b | b4 a | gis2 \bar "||"
  gis2 | cis4 a | gis2 \bar "||"
  gis2 | gis4 a | gis4 fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | gis4 a | b2 \bar "||"
  gis2 | a4 gis | gis4 fis | e2 \bar "||"
  gis2 | cis4 a | gis2 \bar "||"
  fis2 | e4 fis | e4 dis | e2 \bar "||"
}

T_notes = \relative c {
  e2 | gis4 a | b2 \bar "||"
  e4. dis8 | cis4 dis | e4 b | b2 \bar "||"
  gis2 | cis4 a | gis2 \bar "||"
  dis'2 | cis4 cis | b4. a8 | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | gis4 a | b2 \bar "||"
  e,2 | a,4 b | cis4 dis | e2 \bar "||"
  gis2 | cis4 a | gis2 \bar "||"
  bis,2 | cis4 a | b4 b | e2 \bar "||"
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
