\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "William Crotch (1775-1847)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  g2 | a4 b | g2 \bar "||"
  fis2 | e4 d | fis g | a2 | \bar "||"
  a2 | c4 a | b2 \bar "||"
  g2 | a4 g | g fis? | g2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 b | b2 \bar "||"
  d2 | c4 d | c d | fis2 | \bar "||"
  d2 | c4 d | d2 \bar "||"
  c2 | f4 e | d d | d2 | \bar "||"
}

T_notes = \relative a {
  b2 | a4 fis | g2 \bar "||"
  b2 | g4 g | a b | a2 | \bar "||"
  fis2 | g4 a | g2 \bar "||"
  g2 | c4 c | a a | b2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | fis4 d | e2 \bar "||"
  b2 | c4 b | a g | d'2 | \bar "||"
  d2 | e4 fis | g2 \bar "||"
  e2 | f4 c | d d | g,2 | \bar "||"
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