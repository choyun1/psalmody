\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry Walford Davies (1869-1941)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | a4 gis | cis2 \bar "||"
  dis,2 | e4 fis | gis b8 a | gis4 fis \bar "||"
  gis2 | cis4 b | e,2 \bar "||"
  e2 | fis4 gis | a b | b2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  dis2 | cis4 dis | e fis | e dis \bar "||"
  gis2 | a4 e | e2 \bar "||"
  e2 | cis4 e | a gis8 fis | gis2 \bar "||"
}

T_notes = \relative c' {
  gis2 | cis4 b | a2 \bar "||"
  b2 | b4 a | gis cis | b2 \bar "||"
  b2 | e4 d | d cis \bar "||"
  b2 | a4 b | cis dis | e2 \bar "||"
}

B_notes = \relative c {
  e2 | e4 e | a,2 \bar "||"
  a'2 | gis4 fis | e a, | b2 \bar "||"
  e2 | fis4 gis | b a \bar "||"
  gis2 | a4 gis | fis b, | e2 \bar "||"
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
