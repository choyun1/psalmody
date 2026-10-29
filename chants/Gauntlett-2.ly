\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Henry John Gauntlett (1805-1876)"}
  tagline=#f
}

global = {
  \key e \major
  \time 2/4
}


S_notes = \relative c'' {
  b2 | b4 b | b2 \bar "||"
  a2 | a4 gis | fis e | dis2 \bar "||"
  b'2 | b4 e | e2 \bar "||"
  ais,2 | b4 gis | gis fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | gis4 fis | e2 \bar "||"
  e2 | fis4 e | cis cis | b2 \bar "||"
  dis2 | e4 gis | e2 \bar "||"
  e2 | dis4 e | e dis | e2 \bar "||"
}

T_notes = \relative c' {
  gis4. b8 | e4 dis | cis2 \bar "||"
  cis2 | b4 b | ais ais | b2 \bar "||"
  b2 | b4 b | ais2 \bar "||"
  cis2 | b4 b | b a | gis2 \bar "||"
}

B_notes = \relative c {
  e2 | e4 e | e2 \bar "||"
  e2 | dis4 e | fis fis | b,2 \bar "||"
  b'2 | gis4 e | cis2 \bar "||"
  fis2 | b,4 e | b b | e2 \bar "||"
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
