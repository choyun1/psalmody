\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Myles B. Foster (1851-1922)"}
  tagline=#f
}

global = {
  \key a \major
  \time 2/4
}


S_notes = \relative c'' {
  a2 | cis4 d | e2 \bar "||"
  e,2 | fis4 gis | b d | cis2 \bar "||"
}

A_notes = \relative c' {
  e2 | a4 a | gis2 \bar "||"
  e2 | e4 d | cis fis | e2 \bar "||"
}

T_notes = \relative c' {
  cis2 | e4 a, | b2 \bar "||"
  gis2 | a4 b | a a | a2 \bar "||"
}

B_notes = \relative c' {
  a2 | a4 fis | e2 \bar "||"
  e2 | d4 b | fis' d | a'2 \bar "||"
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
