\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "James Turle (1802-1882)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | f4 as | g2 \bar "||"
  bes2 | c4 as | bes4. as8 | g2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | es2 \bar "||"
  es4. des8 | c4 f | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | as4 c | bes2 \bar "||"
  es,2 | es4 es | f bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 es | es2 \bar "||"
  g,2 | as4 c | bes bes | es2 \bar "||"
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
