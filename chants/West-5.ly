\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Ebenezer West (1863-1929)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 f | bes2 \bar "||"
  bes2 | c4 bes | d c | bes2 \bar "||"
}

A_notes = \relative c' {
  d2 | d4 f | es2 \bar "||"
  f2 | g4 d8 es | f4 a | bes2 \bar "||"
}

T_notes = \relative c' {
  bes2 | d4 c | bes2 \bar "||"
  bes2 | g4 bes | bes es | <d bes>2 \bar "||"
}

B_notes = \relative c {
  bes2 | bes'4 a | g2 \bar "||"
  d2 | es4 g | f f | bes,2 \bar "||"
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
