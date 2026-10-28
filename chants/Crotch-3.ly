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
  d2 | g4 fis | e2 \bar "||"
  fis2 | g4 a | b c | b a | \bar "||"
  a2 | d4 c | b2 \bar "||"
  a2 | fis4 g | b a | g2 \bar "||"
}

A_notes = \relative c' {
  b2 | d4 b | c2 \bar "||"
  c2 | b4 d | d e | d2 | \bar "||"
  d2 | d4 d | d2 \bar "||"
  e2 | d4 d | d c | b2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 g | g2 \bar "||"
  a2 | g4 fis | g g | g fis | \bar "||"
  fis2 | a4 fis | g2 \bar "||"
  c2 | a4 g | g fis | g2 | \bar "||"
}

B_notes =  \relative c {
  g2 | b4 g | c2 \bar "||"
  a2 | e'4 d | g c, | d2 | \bar "||"
  d2 | fis4 d | g2 \bar "||"
  c,2 | c4 b | d d | g,2 | \bar "||"
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