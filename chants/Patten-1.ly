\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "William Patten"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  bes2 | as4 g | f2 \bar "||"
  es2 | as4 g | f a | bes2 \bar "||"
  bes2 | c4 d | es2 \bar "||"
  c2 | bes4 as | g f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | d4 es | c2 \bar "||"
  es2 | c8 d es4 | f es | d2 \bar "||"
  f2 | f4 f | es2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | as4 bes | as2 \bar "||"
  bes2 | as4 bes | bes c | f,2 \bar "||"
  d'2 | c4 bes | bes2 \bar "||"
  as2 | bes4 es | es bes8 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 g | as2 \bar "||"
  g2 | f4 es | d c | bes2 \bar "||"
  bes'2 | a4 as | g2 \bar "||"
  as2 | g4 c | bes bes, | es2 \bar "||"
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
