\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Clement Martin (1844-1916)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | a4 e | a2 \bar "||"
  a2 | d4. cis8 | cis4 b | a2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 b | e2 \bar "||"
  cis2 | d4 fis | e d | cis2 \bar "||"
}

T_notes = \relative c' {
  cis4. b8 | a4 gis | a2 \bar "||"
  a2 | b4 a | gis gis | a2 \bar "||"
}

B_notes = \relative c {
  a4. b8 | cis4 e | cis2 \bar "||"
  fis2 | b,4 b | e e | a,2 \bar "||"
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
