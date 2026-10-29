\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Phocion Henley (1728-1764)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | f4 es | c'2 \bar "||"
  bes4. as8 | g4 c | bes a | bes2 \bar "||"
  f2 | f4 g | as2 \bar "||"
  g2 | f4 es8 f | g4 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | d4 es | es2 \bar "||"
  f2 | bes,4 es | d c | d2 \bar "||"
  d2 | d4 e | f2 \bar "||"
  bes,2 | c8 d es4 | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 bes | c2 \bar "||"
  f,2 | g4 g | f f | f2 \bar "||"
  bes2 | bes4 bes | c4 d \bar "||"
  es2 | c4 bes8 c | bes4. as8 | g2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 g | as2 \bar "||"
  d,2 | es4 c | f f | bes,2 \bar "||"
  bes'2 | as4 g | f2 \bar "||"
  es2 | as4 g8 as | bes4 bes, | es2 \bar "||"
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
