\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Thomas Attwood (1765-1838)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | g4 g | g2 \bar "||"
  g2 | as4 es | f4 f | g2 \bar "||"
  g2 | f4 f | bes2 \bar "||"
  c2 | bes4 g | f f | es2 \bar "||"
}

A_notes = \relative c' {
  bes2 | b4 b | c2 \bar "||"
  des2 | c4 c | c c | d2 \bar "||"
  d2 | d4 d | es2 \bar "||"
  es2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  g2 | f4 f | es2 \bar "||"
  es2 | es4 as | as c | b2 \bar "||"
  b2 | bes4 bes | bes2 \bar "||"
  as2 | bes4 es | c bes8 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | d4 d | c2 \bar "||"
  bes2 | as4 as | as' as | g2 \bar "||"
  g2 | as4 as | g2 \bar "||"
  as2 | g4 bes, | as bes | es2 \bar "||"
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
