\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Stainer (1840-1901)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | es4 g, | c2 \bar "||"
  bes2 | as4 c | bes g | f2 \bar "||"
  g2 | b4 d | es2 \bar "||"
  c2 | as4 g | g f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | es2 \bar "||"
  e2 | f4 f | f es | d2 \bar "||"
  d2 | g4 f | es2 \bar "||"
  es2 | d4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | c4 bes | as2 \bar "||"
  bes2 | c4 as | f bes | bes2 \bar "||"
  g2 | g4 g | g2 \bar "||"
  as2 | as4 bes | bes as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | c4 es | as2 \bar "||"
  g2 | f4 es | d es | bes2 \bar "||"
  b2 | g4 b | c2 \bar "||"
  as'2 | f4 es | bes bes | es2 \bar "||"
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
