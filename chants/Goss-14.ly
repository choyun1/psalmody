\version "2.24.1"

\header{
  composer = \markup{\hspace #-27 \italic "John Goss (1800-1880)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  e2 | g4 c, | f2 \bar "||"
  e2 | a4 g | g fis | g2 | \bar "||"
  g2 | b4 g | c2 \bar "||"
  e,2 | f4 e | d d | c2 \bar "||"
}

A_notes = \relative c' {
  c2 | c4 c | b2 \bar "||"
  c2 | e4 d | d d | d2 | \bar "||"
  d2 | d4 d | c2 \bar "||"
  c2 | c4 c | c b | c2 | \bar "||"
}

T_notes = \relative a {
  g2 | g4 a | f2 \bar "||"
  g2 | c4 b | a4 a | b2 | \bar "||"
  b2 | d4 b | g2 \bar "||"
  g2 | f4 g8 a | d,4 e8 f | e2 | \bar "||"
}

B_notes =  \relative c {
  c2 | e4 f | d2 \bar "||"
  c2 | a4 b | d d | g,2 | \bar "||"
  g'2 | f4 g | e2 \bar "||"
  bes2 | a4 g8 f | g4 g | c2 | \bar "||"
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