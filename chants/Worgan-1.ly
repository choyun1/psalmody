\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "John Worgan (1724-1790)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | as4 g | f2 \bar "||"
  g2 | as4 c | bes as8 g | g4 f \bar "||"
  bes2 | as4 g | f2 \bar "||"
  g2 | as4 c | g f | es2 \bar "||"
}

A_notes = \relative c'' {
  g2 | f4 es | d2 \bar "||"
  e2 | f4 as | g f8 es | es4 d \bar "||"
  g2 | f4 es | d2 \bar "||"
  e2 | f4 f | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | d4 es | bes2 \bar "||"
  bes2 | as4 f | g c | bes2 \bar "||"
  bes2 | d4 es | bes2 \bar "||"
  bes2 | c4 c | bes4. as8 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 g | as2 \bar "||"
  g2 | f4 d | es as | bes2 \bar "||"
  es,2 | f4 g | as2 \bar "||"
  g2 | f4 as, | bes bes | es2 \bar "||"
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
