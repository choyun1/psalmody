\version "2.24.1"

\header{
  composer = \markup{\hspace #-26.5 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key g \major
  \time 2/4
}


S_notes = \relative g' {
  d2 | e4 fis | g2 \bar "||"
  a2 | b4 g | e e | d2 | \bar "||"
  g2 | a4 b | c2 \bar "||"
  a2 | b4 g | g fis | g2 | \bar "||"
}

A_notes = \relative c' {
  d2 | c4 c | b2 \bar "||"
  d2 | d4 d | d cis | d2 | \bar "||"
  b2 | f'4 f | e2 \bar "||"
  d2 | b4 d | d d | d2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 a | g2 \bar "||"
  fis2 | g4 g | b a | fis2 | \bar "||"
  g2 | g4 g | g2 \bar "||"
  fis2 | g4 b | a c | b2 | \bar "||"
}

B_notes =  \relative c {
  g2 | c4 a | e'2 \bar "||"
  d2 | g4 b, | g a | d2 | \bar "||"
  e2 | d4 g, | c2 \bar "||"
  d2 | g4 b, | d d | g,2 | \bar "||"
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