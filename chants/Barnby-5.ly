\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | gis4 b | a2 \bar "||"
  gis2 | fis4 a | gis4 fis | e2 \bar "||"
}

A_notes = \relative c'' {
  gis2 | gis4 fis | e2 \bar "||"
  e2 | cis4 cis | dis4 dis | e2 \bar "||"
}

T_notes = \relative c' {
  b2 | e4 dis | cis2 \bar "||"
  b2 | a4 fis | b4 a | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | e4 e | e2 \bar "||"
  e2 | a,4 a | b4 b | e2 \bar "||"
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
