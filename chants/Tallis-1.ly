\version "2.24.1"

\header{
  composer = \markup{\hspace #-53 \italic "Thomas Tallis (1505-1585)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative g' {
  bes2 | bes4 f | g2 \bar "||"
  g2 | a4 bes | bes a | bes2 | \bar "||"
}

A_notes = \relative c' {
  d2 | d4 d | ees2 \bar "||"
  ees2 | ees4 d | c c | d2 | \bar "||"
}

T_notes = \relative a {
  f2 | f4 bes | bes2 \bar "||"
  bes2 | ees,4 f | f f | f2 | \bar "||"
}

B_notes =  \relative c {
  bes2 | bes4 bes | ees2 \bar "||"
  ees2 | c4 bes | f f | bes2 | \bar "||"
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