\version "2.24.1"

\header{
  composer = \markup{\hspace #-41.5 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key d \major
  \time 2/4
}


S_notes = \relative g' {
  fis2 | a4 fis | d2 \bar "||"
  g2 | g4 fis | e d | fis e | \bar "||"
  a2 | b4 fis | g2 \bar "||"
  fis2 | d4 g | fis e | d2 \bar "||"
}

A_notes = \relative c' {
  d2 | e4 cis | b2 \bar "||"
  b2 | a4 a | b d | d cis | \bar "||"
  cis2 | b4 dis | e2 \bar "||"
  cis2 | d4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 a | fis2 \bar "||"
  g2 | e4 fis | b gis | a2 | \bar "||"
  a2 | fis4 b | b2 \bar "||"
  fis2 | fis4 b | a g | fis2 | \bar "||"
}

B_notes =  \relative c {
  d2 | cis4 a | b2 \bar "||"
  e2 | cis4 d | g, b | a2 | \bar "||"
  fis'2 | dis4 b | e2 \bar "||"
  ais,2 | b4 g | a a | d2 | \bar "||"
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