\version "2.24.1"

\header{
  composer = \markup{\hspace #-55 \italic "Richard Farrant (1525-1580)"}
  tagline=#f
}

global = {
  \key f \major
  \time 2/4
}


S_notes = \relative g' {
  f2 | f4 g | a2 \bar "||"
  c2 | bes4 a | g g | f2 | \bar "||"
}

A_notes = \relative c' {
  c2 | d4 e | f2 \bar "||"
  f2 | f4 f | f e | f2 | \bar "||"
}

T_notes = \relative a {
  a2 | a4 c | c2 \bar "||"
  c2 | d4 c | c bes | a2 | \bar "||"
}

B_notes =  \relative c {
  f2 | d4 c | f2 \bar "||"
  a,2 | bes4 f' | c c | f2 | \bar "||"
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