\version "2.24.1"

\header{
  composer = \markup{\hspace #-60 \italic "Edwin George Monk (1819-1900)"}
  tagline=#f
}

global = {
  \key c \major
  \time 2/4
}


S_notes = \relative g' {
  c2 | e,4 f | g2 | \bar "||"
  a2 | b4 c | c b | c2 | \bar "||"
}

A_notes = \relative c' {
  e2 | c4 c | c2 | \bar "||"
  f2 | f4 e | d d | e2 | \bar "||"
}

T_notes = \relative a {
  c2 | c4 c | c2 | \bar "||"
  c2 | d4 c | a g | g2 | \bar "||"
}

B_notes =  \relative c {
  c2 | a'4 a | e2 | \bar "||"
  f2 | d4 a' | f g | c,2 | \bar "||"
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