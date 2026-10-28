\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Thomas Norris (1741-1790)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | b4 d | g,2 \bar "||"
  g2 | e4 g | c b | a2 | \bar "||"
  a2 | d4 b | c2 \bar "||"
  a2 | b4 c | b a | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | e2 \bar "||"
  d2 | c4 d | e8 fis g4 | fis2 | \bar "||"
  d2 | d4 e | e2 \bar "||"
  d2 | d4 e | d4. c8 | b2 | \bar "||"
}

T_notes = \relative a {
  b2 | g4 a | b2 \bar "||"
  g2 | g4 b | c d | d2 | \bar "||"
  fis,2 | b4 gis | a2 \bar "||"
  fis2 | g4 g | g fis | g2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | g4 fis | e2 \bar "||"
  b2 | c4 b | a g | d'2 | \bar "||"
  d2 | b4 e | a,2 \bar "||"
  d2 | g4 c, | d d | g,2 | \bar "||"
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