\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Jackson (1715-1781)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | b4 fis | g2 \bar "||"
  a2 | b4 d | c b | a2 | \bar "||"
  a2 | fis4 e | d2 \bar "||"
  g2 | e4 a | g fis | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | b4 c | b2 \bar "||"
  d2 | d4 d | fis g | fis2 | \bar "||"
  d2 | cis4 cis | d2 \bar "||"
  d2 | c4 e | d c | b2 | \bar "||"
}

T_notes = \relative a {
  b2 | g4 a | g2 \bar "||"
  fis2 | g4 g | a b | d2 | \bar "||"
  a2 | a4 g | fis2 \bar "||"
  g2 | g4 c | b a | g2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 d | e2 \bar "||"
  d2 | g,4 b | a g | d'2 | \bar "||"
  fis,2 | a4 a | d2 \bar "||"
  b2 | c4 a | d d | g,2 | \bar "||"
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