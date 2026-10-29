\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Leman Rogers (1780-1847)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | es4 g | f2 \bar "||"
  c'2 | bes4 bes | bes a | bes2 \bar "||"
  bes2 | es4 d | c2 \bar "||"
  f,2 | es4 es | es d | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | es4 es | d2 \bar "||"
  es2 | es4 g | f f | f2 \bar "||"
  es2 | g4 bes | es,2 \bar "||"
  d2 | es4 c | bes bes | bes2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 bes | bes2 \bar "||"
  es2 | bes4 es | d c | d2 \bar "||"
  bes2 | bes4 bes | c2 \bar "||"
  as2 | g4 as | g f | g2 \bar "||"
}

B_notes = \relative c {
  es2 | g4 es | bes'2 \bar "||"
  as2 | g4 es | f f | bes,2 \bar "||"
  g'2 | es4 g | as2 \bar "||"
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
