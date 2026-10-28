\version "2.24.1"

\header{
  composer = \markup{\hspace #-64.5 \italic "Frederick A. Gore Ouseley (1825-1889)"}
  tagline=#f
}

global = {
  \key d \minor
  \time 2/4
}


S_notes = \relative g' {
  a2 | bes4 g | e2 | \bar "||"
  cis'2 | d4 a | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | cis2 | \bar "||"
  e2 | d4 d | d cis | d2 | \bar "||"
}

T_notes = \relative a {
  a2 | g4 bes | a2 | \bar "||"
  a2 | a4 a | bes a | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | g4 e | a2 | \bar "||"
  a2 | f4 f | e a, | d2 | \bar "||"
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