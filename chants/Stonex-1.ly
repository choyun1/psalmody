\version "2.24.1"

\header{
  composer = \markup{\hspace #-30 \italic "Henry Stonex (1823-1897)"}
  tagline=#f
}

global = {
  \key fis \minor
  \time 2/4
}


S_notes = \relative g' {
  fis2 | fis4 gis | a2 \bar "||"
  a2 | a4 gis | a b | cis2 | \bar "||"
  cis2 | cis4 dis | e2 \bar "||"
  cis2 | d4 fis, | a gis | fis2 | \bar "||"
}

A_notes = \relative c' {
  cis2 | d4 e | e2 \bar "||"
  fis2 | e4 d | cis fis | eis2 | \bar "||"
  e?2 | fis4 a | gis2 \bar "||"
  g2 | fis4 d | fis eis | fis2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 d | cis2 \bar "||"
  d2 | a4 b | e, fis | gis2 | \bar "||"
  a2 | a4 b | b2 \bar "||"
  a2 | a4 d | cis b | a2 | \bar "||"
}

B_notes =  \relative c {
  fis2 | d4 b | a2 \bar "||"
  d2 | cis4 b | a d | cis2 | \bar "||"
  a2 | a'4 fis | e2 \bar "||"
  e2 | d4 b | cis cis | fis2 | \bar "||"
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