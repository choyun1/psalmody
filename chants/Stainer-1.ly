\version "2.24.1"

\header{
  composer = \markup{\hspace #-51.5 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | ees4 d | g2 \bar "||"
  bes2 | a4 bes | c c | bes2 | \bar "||"
}

A_notes = \relative c' {
  bes2 | a4 bes | bes2 \bar "||"
  ees2 | f4 f | g f | d2 | \bar "||"
}

T_notes = \relative a {
  d,2 | ees4 f | ees2 \bar "||"
  bes'2 | c4 bes | bes a | bes2 | \bar "||"
}

B_notes =  \relative c {
  bes2 | c4 d | ees2 \bar "||"
  g2 | f4 d | ees f | bes,2 | \bar "||"
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