\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Charles Harford Lloyd (1849-1919)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  gis2 | fis4 e | e2 \bar "||"
  a2 | b4 gis | gis fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | dis4 d | cis2 \bar "||"
  fis2 | fis4 e | e dis | e2 \bar "||"
}

T_notes = \relative c' {
  b2 | a4 b | a2 \bar "||"
  cis2 | b4 b | cis a | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | fis4 gis | a2 \bar "||"
  fis2 | dis4 e | a, b | e2 \bar "||"
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
