\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Tertius Noble (1867-1953)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c' {
  es2 | f4 g | as2 \bar "||"
  g2 | f4 g | as bes | g2 \bar "||"
  g2 | a4 b | c2 \bar "||"
  b2 | bes4 as | g f | es2 \bar "||"
}

A_notes = \relative c' {
  bes2 | c4 d | es2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
  d2 | es4 f | g2 \bar "||"
  g2 | g4 f | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | as4 bes | c2 \bar "||"
  bes2 | c4 bes | c bes | bes2 \bar "||"
  b2 | c4 d | es2 \bar "||"
  d2 | des4 c | bes bes | bes2 \bar "||"
}

B_notes = \relative c {
  es2 | es4 es | es2 \bar "||"
  es2 | as4 g | f bes, | es2 \bar "||"
  g2 | g4 g | g2 \bar "||"
  g2 | e4 f | bes, bes | es2 \bar "||"
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
