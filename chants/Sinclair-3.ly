\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George Robertson Sinclair (1863-1917)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 f | c'4 bes \bar "||"
  as2 | as4 g | as g | d2 \bar "||"
  bes'2 | es4 d | c2 \bar "||"
  bes2 | as4 g | bes f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | d4 d | es2 \bar "||"
  d2 | des4 des | c c | c4 bes \bar "||"
  d2 | es4 f | g2 \bar "||"
  g2 | f4 c | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 bes | bes2 \bar "||"
  bes2 | bes4 bes | as as | f2 \bar "||"
  bes4. as8 | g4 b | c2 \bar "||"
  c2 | c4 as | f8 g as4 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | bes'4 as | g2 \bar "||"
  f2 | e4 es | f as, | bes2 \bar "||"
  bes2 | c4 d | es2 \bar "||"
  e2 | f4 as, | bes bes | es2 \bar "||"
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
