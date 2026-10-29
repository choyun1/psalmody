\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Wesley (1766-1837)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | b4 b | cis2 \bar "||"
  a2 | gis4 e' | dis cis | b2 \bar "||"
  gis2 | gis4 gis | a2 \bar "||"
  fis2 | b4 a | gis fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  e2 | e4 e | fis4. e8 | dis2 \bar "||"
  e2 | e4 e | fis2 \bar "||"
  dis2 | e4 e | e dis | e2 \bar "||"
}

T_notes = \relative c' {
  gis2 | gis4 gis | a2 \bar "||"
  a2 | b4 cis | b ais | b2 \bar "||"
  b2 | cis4 cis | cis2 \bar "||"
  b2 | b4 cis | b4. a8 | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | e4 e | a,2 \bar "||"
  cis2 | e4 cis | fis fis, | b2 \bar "||"
  e2 | cis4 cis | fis2 \bar "||"
  a2 | gis4 a | b b, | e2 \bar "||"
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
