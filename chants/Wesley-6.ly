\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Samuel Sebastian Wesley (1810-1876)"}
  tagline=#f
}

global = {
  \key bes \major
  \time 2/4
}


S_notes = \relative c' {
  f2 | g4 a8 bes | a2 \bar "||"
  bes2 | es4 d | c c | bes2 \bar "||"
}

A_notes = \relative c' {
  f2 | f4 es | es2 \bar "||"
  d2 | g4 f8 g | es d es4 | d2 \bar "||"
}

T_notes = \relative c' {
  c2 | bes4 es | c2 \bar "||"
  bes2 | bes4 bes | bes a | bes2 \bar "||"
}

B_notes = \relative c' {
  a2 | g4 c, | f2 \bar "||"
  g2 | c,4 d8 es | f4 f | bes,2 \bar "||"
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
