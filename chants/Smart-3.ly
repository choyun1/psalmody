\version "2.24.1"

\header{
  composer = \markup{\hspace #-29.5 \italic "Henry Smart (1813-1879)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  c,2 | e4 c | g'2 \bar "||"
  g2 | c4 a | g fis | g2 | \bar "||"
  g2 | b4 g | d'2 \bar "||"
  a2 | b4 c | e, d | c2 \bar "||"
}

A_notes = \relative c' {
  g2 | c4 c | d2 \bar "||"
  b2 | c4 e | d d | d2 | \bar "||"
  d2 | d4 d | f?2 \bar "||"
  d2 | f4 e | c b | c2 | \bar "||"
}

T_notes = \relative a {
  e2 | g4 e | d2 \bar "||"
  g2 | e4 c' | b a | b2 | \bar "||"
  b2 | g4 b | a2 \bar "||"
  a2 | d4 c | g f | e2 | \bar "||"
}

B_notes =  \relative c {
  c2 | c4 c | b2 \bar "||"
  e2 | a,4 c | d d | g,2 | \bar "||"
  g'2 | g4 g | d2 \bar "||"
  f2 | g4 a | g g, | c2 | \bar "||"
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