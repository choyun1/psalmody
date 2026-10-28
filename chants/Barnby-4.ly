\version "2.24.1"

\header{
  composer = \markup{\hspace #-31.5 \italic "Joseph Barnby (1838-1896)"}
  tagline=#f
}

global = {
  \key c \minor
  \time 2/4
}


S_notes = \relative g' {
  g2 | ees4 f | g2 \bar "||"
  g2 | ees4 g | c c | b2 | \bar "||"
  c | g4 bes | aes2 \bar "||"
  g2 | ees4 f | d d | c2 | \bar "||"
}

A_notes = \relative c' {
  g'2 | ees4 f | g2 \bar "||"
  b,2 | c4 d | c d | d2 | \bar "||"
  e2 | c4 c | c2 \bar "||"
  d2 | c4 c | c b | c2 | \bar "||"
}

T_notes = \relative a {
  g2 | ees4 f | g2 \bar "||"
  g2 | g4 g | ees f | g2 | \bar "||"
  g2 | g4 e! | f2 \bar "||"
  d2 | g4 f | g g | ees2 | \bar "||"
}

B_notes =  \relative c {
  g'2 | ees4 f | g2 \bar "||"
  g,2 | c4 bes | a a | g2 | \bar "||"
  c2 | e4 c | f2 \bar "||"
  b,2 | c4 aes | g g | c2 | \bar "||"
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