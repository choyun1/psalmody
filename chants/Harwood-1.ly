\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Basil Harwood (1859-1949)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | es,4 f8 g | as2 \bar "||"
  f2 | es4 c' | bes f | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | c2 \bar "||"
  d2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 bes | c2 \bar "||"
  bes4. as8 | g4 f | g bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | as4 g | f2 \bar "||"
  bes,2 | c4 as | bes bes | es2 \bar "||"
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
