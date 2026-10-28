\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "William Best (1826-1897)"}
  tagline=#f
}

global = {
  \key e \minor
  \time 2/4
}


S_notes = \relative g' {
  b2 | c4 b | a2 \bar "||"
  a2 | b4 g | g fis | g2 | \bar "||"
  g2 | a4 b | c2 \bar "||"
  b2 | a4 g | g fis | e2 \bar "||"
}

A_notes = \relative c' {
  e2 | e4 e | e2 \bar "||"
  d2 | d4 d | d d | d2 | \bar "||"
  e2 | d4 d | e2 \bar "||"
  d2 | c4 e | e dis | e2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 gis | a2 \bar "||"
  a2 | g4 b | c c | b2 | \bar "||"
  b2 | a4 fis | g2 \bar "||"
  g2 | e4 c' | b a | g2 | \bar "||"
}

B_notes =  \relative c {
  e2 | e4 d | c2 \bar "||"
  fis2 | g4 g | a d, | g2 | \bar "||"
  e2 | fis4 d | c2 \bar "||"
  g2 | a4 a | b b | e2 | \bar "||"
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