\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "George J. Elvey (1816-1893)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | bes4 es | d2 \bar "||"
  c2 | bes4 as | g c | f,2 \bar "||"
  bes2 | bes4 as | g2 \bar "||"
  c2 | as4 g | f f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | f4 es | f2 \bar "||"
  f2 | g4 f | es f8 es | d2 \bar "||"
  f2 | bes,4 f' | es2 \bar "||"
  c2 | c8 d es4 | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | bes4 a | bes2 \bar "||"
  d2 | es4 bes | bes c | bes2 \bar "||"
  d2 | es4 bes | bes2 \bar "||"
  g2 | as4 bes | bes bes8 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | d4 c | bes2 \bar "||"
  as'2 | g4 d | es as, | bes2 \bar "||"
  bes'2 | g4 d | es2 \bar "||"
  e2 | f4 g8 as | bes4 bes, | es2 \bar "||"
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
