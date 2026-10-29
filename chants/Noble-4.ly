\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tertius Noble (1867-1953)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | as4 f | bes2 \bar "||"
  c2 | d4 es | as, bes | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 d | es2 \bar "||"
  es2 | as4 g | es f | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 bes | bes2 \bar "||"
  as2 | as4 bes | c d | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 as | g2 \bar "||"
  as4. g8 | f4 es | c bes | es2 \bar "||"
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
