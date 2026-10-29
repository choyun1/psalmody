\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Marsh (1752-1828)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | f4 es | bes'2 \bar "||"
  c2 | bes4 es | bes as8 g | f2 \bar "||"
  f2 | g4 as | bes2 \bar "||"
  c2 | f,4 g8 as | g4 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | bes4 es | d2 \bar "||"
  es2 | es4 g | g f8 es | d2 \bar "||"
  d2 | es4 f | g2 \bar "||"
  es2 | d4 es8 f | es4 d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | f4 g8 a | bes2 \bar "||"
  as2 | bes4 bes | bes c | d2 \bar "||"
  bes2 | bes4 bes | g2 \bar "||"
  c2 | bes4 bes | bes4. as8 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | d4 c | bes2 \bar "||"
  as'2 | g4 es | g as | bes2 \bar "||"
  bes4. as8 | g4 f | es2 \bar "||"
  as2 | bes4 es, | bes bes | es2 \bar "||"
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
