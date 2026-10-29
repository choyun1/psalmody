\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | g4 as | bes2 \bar "||"
  bes2 | c4 es | es d | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | d2 \bar "||"
  es2 | es4 es | as as | g2 \bar "||"
}

T_notes = \relative c' {
  g2 | bes4 c | f,2 \bar "||"
  bes2 | as4 bes | c bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 c | bes2 \bar "||"
  g'2 | as4 g | f bes | es,2 \bar "||"
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
