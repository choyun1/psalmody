\version "2.24.1"

\header{
  composer = \markup{\hspace #-48 \italic "John Blow (1649-1708)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  f2 | f4 g | a2 \bar "||"
  a2 | g4 f | e e | d2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 e | f2 \bar "||"
  c2 | cis4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 c | c2 \bar "||"
  f,2 | g4 a | a a | f2 | \bar "||"
}

B_notes =  \relative c {
  d2 | d4 c | f2 \bar "||"
  f2 | e4 d | a a | d2 | \bar "||"
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