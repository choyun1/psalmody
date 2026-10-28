\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key e \minor
  \time 2/4
}


S_notes = \relative g' {
  g2 | dis4 e | c'2 \bar "||"
  b2 | b4 e | d c | b2 | \bar "||"
  b2 | d4 c | a2 \bar "||"
  b2 | e,4 g | fis dis | e2 | \bar "||"
}

A_notes = \relative c' {
  b2 | b4 e | e2 \bar "||"
  dis2 | e4 e | a e | fis2 | \bar "||"
  g2 | e4 e | fis2 \bar "||"
  g2 | e4 d | c b | b2 | \bar "||"
}

T_notes = \relative a {
  g2 | a4 b | a2 \bar "||"
  b2 | b4 b | a a | a2 | \bar "||"
  g2 | b4 a | c2 \bar "||"
  b2 | c4 g | a a | g2 | \bar "||"
}

B_notes =  \relative c {
  e2 | fis4 g | a2 \bar "||"
  a2 | g4 g | fis e | dis2 | \bar "||"
  e2 | c4 c | d2 \bar "||"
  g,2 | c4 b | a b | e2 | \bar "||"
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