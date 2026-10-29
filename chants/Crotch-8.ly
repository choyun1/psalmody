\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 gis | a2 \bar "||"
  fis2 | e4 a | a gis | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  d2 | cis4 dis | e e | e2 \bar "||"
}

T_notes = \relative c' {
  cis2 | cis4 b | cis2 \bar "||"
  a2 | a4 a | b b | cis2 \bar "||"
}

B_notes = \relative c' {
  a2 | a4 e | a2 \bar "||"
  d,2 | a'4 fis | e e | a,2 \bar "||"
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
