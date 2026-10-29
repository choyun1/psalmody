\version "2.24.1"

\header{
  composer = \markup{\hspace #-33 \italic "Francis Edward Gladstone (1845-1928)"}
  tagline=#f
}

global = {
  \key ees \major
  \time 2/4
}


S_notes = \relative c'' {
  g2 | as4 bes | es,2 \bar "||"
  as2 | as4 g | f c' | b2 \bar "||"
  c2 | d4 es | bes2 \bar "||"
  bes2 | bes4 as8 g | f4 f | es2 \bar "||"
}

A_notes = \relative c' {
  es2 | c4 bes | bes2 \bar "||"
  es2 | e4 es | f f | g2 \bar "||"
  es2 | f4 es | d es \bar "||"
  f2 | es4 es | es d | es2 \bar "||"
}

T_notes = \relative c' {
  bes2 | as4 f | g2 \bar "||"
  as2 | des4 des | c4 c8 d | d2 \bar "||"
  c2 | ces4 bes | as2 \bar "||"
  as2 | g4 c | f, bes8 as | g2 \bar "||"
}

B_notes = \relative c {
  es2 | f4 d | es4 des \bar "||"
  c2 | bes4 bes | as as' | g2 \bar "||"
  as2 | as4 g | f es \bar "||"
  d2 | es4 as, | bes bes | es2 \bar "||"
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
